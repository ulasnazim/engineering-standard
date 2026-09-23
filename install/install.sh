#!/usr/bin/env bash
# Registers the team engineering standard with supported AI coding tools on this
# machine; other tools require their own global instruction configuration.
#
# Usage:
#   install.sh              install or update (clone/pull, then wire detected tools)
#   install.sh --all        wire all supported tools even if not detected
#   install.sh --dry-run    show what would change, change nothing
#   install.sh --uninstall  remove everything this script added (keeps the clone)
#
# Environment overrides:
#   ENG_STANDARD_REPO   git URL of the policy repository
#   ENG_STANDARD_HOME   local clone path (default: ~/.engineering-standard)
#   CODEX_HOME          Codex home (default: ~/.codex)
set -euo pipefail

REPO_URL="${ENG_STANDARD_REPO:-git@github.com:ulasnazim/engineering-standard.git}"
DEST="${ENG_STANDARD_HOME:-$HOME/.engineering-standard}"
CODEX_DIR="${CODEX_HOME:-$HOME/.codex}"
CLAUDE_DIR="$HOME/.claude"
OPENCODE_DIR="$HOME/.config/opencode"

BEGIN_MARK="<!-- BEGIN engineering-standard (managed by install.sh; edits inside are overwritten) -->"
END_MARK="<!-- END engineering-standard -->"

MODE="install"
FORCE_ALL=0
for arg in "$@"; do
  case "$arg" in
    --all) FORCE_ALL=1 ;;
    --dry-run) MODE="dry-run" ;;
    --uninstall) MODE="uninstall" ;;
    -h|--help) sed -n '2,15p' "$0"; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 2 ;;
  esac
done

say() { printf '%s\n' "$*"; }
run() { if [ "$MODE" = "dry-run" ]; then say "  [dry-run] $*"; else "$@"; fi; }

detected() { # detected <command> <config-dir>
  [ "$FORCE_ALL" -eq 1 ] || command -v "$1" >/dev/null 2>&1 || [ -d "$2" ]
}

# Print $1 without the managed block and without trailing blank lines.
strip_block() {
  [ -f "$1" ] || return 0
  awk -v b="$BEGIN_MARK" -v e="$END_MARK" '
    $0 == b { skip = 1; next }
    $0 == e { skip = 0; next }
    skip { next }
    /^[[:space:]]*$/ { blank++; next }
    { while (blank > 0) { print ""; blank-- } print }
  ' "$1"
}

# upsert_block <target-file> <file-with-block-body>
upsert_block() {
  local target="$1" body="$2" tmp
  tmp="$(mktemp)"
  strip_block "$target" > "$tmp"
  {
    if [ -s "$tmp" ]; then cat "$tmp"; printf '\n'; fi
    printf '%s\n' "$BEGIN_MARK"
    cat "$body"
    printf '%s\n' "$END_MARK"
  } > "$tmp.new"
  if [ -f "$target" ] && cmp -s "$tmp.new" "$target"; then
    say "  unchanged: $target"
  elif [ "$MODE" = "dry-run" ]; then
    say "  [dry-run] would update: $target"
  else
    mkdir -p "$(dirname "$target")"
    if [ -f "$target" ] && [ ! -f "$target.before-engineering-standard" ]; then
      cp "$target" "$target.before-engineering-standard"
    fi
    mv "$tmp.new" "$target"
    say "  updated: $target"
  fi
  rm -f "$tmp" "$tmp.new"
}

# remove_block <target-file>: delete the managed block; delete the file if nothing else remains.
remove_block() {
  local target="$1" tmp
  [ -f "$target" ] || return 0
  grep -qF "$BEGIN_MARK" "$target" || return 0
  tmp="$(mktemp)"
  strip_block "$target" > "$tmp"
  if [ "$MODE" = "dry-run" ]; then
    say "  [dry-run] would remove block from: $target"
    rm -f "$tmp"
  elif [ -s "$tmp" ]; then
    mv "$tmp" "$target"; say "  removed block: $target"
  else
    rm -f "$tmp" "$target"; say "  removed file: $target"
  fi
}

# ---------------------------------------------------------------- uninstall
if [ "$MODE" = "uninstall" ]; then
  say "Removing engineering-standard wiring (the clone at $DEST is kept)."
  remove_block "$CLAUDE_DIR/CLAUDE.md"
  remove_block "$CODEX_DIR/AGENTS.md"
  remove_block "$OPENCODE_DIR/AGENTS.md"
  say "Done."
  exit 0
fi

# ---------------------------------------------------------------- clone or update
command -v git >/dev/null 2>&1 || { echo "git is required" >&2; exit 1; }
if [ -d "$DEST/.git" ]; then
  say "Updating $DEST"
  run git -C "$DEST" pull --ff-only --quiet
elif [ -e "$DEST" ]; then
  echo "$DEST exists but is not a git clone; move it or set ENG_STANDARD_HOME" >&2; exit 1
else
  say "Cloning $REPO_URL -> $DEST"
  run git clone --quiet "$REPO_URL" "$DEST"
fi
if [ "$MODE" = "dry-run" ] && [ ! -f "$DEST/AGENT_BOOTSTRAP.md" ]; then
  say "Dry run: clone not present yet, so file contents cannot be previewed."; exit 0
fi
[ -f "$DEST/AGENT_BOOTSTRAP.md" ] || { echo "AGENT_BOOTSTRAP.md not found in $DEST" >&2; exit 1; }
VERSION="$(tr -d '[:space:]' < "$DEST/VERSION" 2>/dev/null || echo unknown)"
say "Policy bundle version: $VERSION"

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT
HEADER="Company engineering policy (bundle $VERSION). Local copy of the policy files: $DEST"

# Claude Code: import by absolute path, so updates via git pull apply without re-running.
{ printf '%s\n' "$HEADER"; printf '@%s\n' "$DEST/AGENT_BOOTSTRAP.md"; } > "$WORK/claude"
# Codex and OpenCode: embed the text, because their global files have no import syntax we rely on.
{ printf '%s\n\n' "$HEADER"; cat "$DEST/AGENT_BOOTSTRAP.md"; } > "$WORK/embedded"

wired=0
if detected claude "$CLAUDE_DIR"; then
  say "Claude Code:"
  upsert_block "$CLAUDE_DIR/CLAUDE.md" "$WORK/claude"
  wired=1
fi
if detected codex "$CODEX_DIR"; then
  say "Codex:"; upsert_block "$CODEX_DIR/AGENTS.md" "$WORK/embedded"; wired=1
fi
if detected opencode "$OPENCODE_DIR"; then
  say "OpenCode:"; upsert_block "$OPENCODE_DIR/AGENTS.md" "$WORK/embedded"; wired=1
fi

[ "$wired" -eq 1 ] || say "No supported tool detected. Re-run with --all, or paste AGENT_BOOTSTRAP.md into your tool's global instructions."
say ""
say "Other tools (Cursor, Gemini CLI, OpenClaw, etc.): add AGENT_BOOTSTRAP.md to the tool's global/user rules."
say "Re-run this script after each policy release (Codex/OpenCode copies are embedded, not linked)."
