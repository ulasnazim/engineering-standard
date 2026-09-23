#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test_area="$(mktemp -d)"
trap 'rm -rf -- "$test_area"' EXIT

mkdir -p "$test_area/source" "$test_area/toolroot/.claude"
git -C "$test_area/source" init -q -b smoke
cp "$repo_dir/AGENT_BOOTSTRAP.md" "$repo_dir/VERSION" "$test_area/source/"
git -C "$test_area/source" add AGENT_BOOTSTRAP.md VERSION
git -C "$test_area/source" -c user.name=PolicySmoke -c user.email=ci@example.invalid \
  commit -qm 'Disposable installer fixture'
git init -q --bare "$test_area/upstream.git"
git -C "$test_area/source" push -q "$test_area/upstream.git" HEAD:refs/heads/smoke
git --git-dir="$test_area/upstream.git" symbolic-ref HEAD refs/heads/smoke
git clone -q "$test_area/upstream.git" "$test_area/policy"

printf 'My existing instructions\n' > "$test_area/toolroot/.claude/CLAUDE.md"
export ENG_STANDARD_HOME="$test_area/policy"
export ENG_STANDARD_TOOL_HOME="$test_area/toolroot"

bash "$repo_dir/install/install.sh" --all --dry-run > "$test_area/dry-run.log"
grep -q 'My existing instructions' "$test_area/toolroot/.claude/CLAUDE.md"
test ! -e "$test_area/toolroot/.codex/AGENTS.md"

bash "$repo_dir/install/install.sh" --all > "$test_area/first.log"
for config in .claude/CLAUDE.md .codex/AGENTS.md .config/opencode/AGENTS.md; do
  test "$(grep -c 'BEGIN engineering-standard' "$test_area/toolroot/$config")" -eq 1
done
grep -q 'My existing instructions' "$test_area/toolroot/.claude/CLAUDE.md"
test -f "$test_area/toolroot/.claude/CLAUDE.md.before-engineering-standard"

cp "$test_area/toolroot/.codex/AGENTS.md" "$test_area/codex-first"
bash "$repo_dir/install/install.sh" --all > "$test_area/second.log"
cmp "$test_area/codex-first" "$test_area/toolroot/.codex/AGENTS.md"

bash "$repo_dir/install/install.sh" --uninstall > "$test_area/uninstall.log"
test "$(cat "$test_area/toolroot/.claude/CLAUDE.md")" = 'My existing instructions'
test ! -e "$test_area/toolroot/.codex/AGENTS.md"
test ! -e "$test_area/toolroot/.config/opencode/AGENTS.md"
echo 'Shell installer dry-run, install, repeat and uninstall passed'
