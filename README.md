# engineering-standard

One policy repository for the software projects owned by Ulaş Nazım. The optional installer registers instructions for supported coding tools on a developer's machine; other tools need their own configuration. Agents can propose each project's `AGENTS.md` after inspecting its actual code and commands, and humans review the proposal. Instruction files alone do not enforce conduct.

## What is in here

| File | Purpose | Read by |
|---|---|---|
| `AGENT_BOOTSTRAP.md` | Short entry point registered by the installer for supported local tools | Agents using that configuration |
| `AGENTS.md` | Instructions for changing this policy repository itself | Contributors to this repository |
| `UNIVERSAL_SOFTWARE_ENGINEERING_STANDARD.md` | Engineering rules, profiles, Definition of Done (v1.0) | Agents: in full at project adoption, then by section. Humans: once in full |
| `TEAM_DEVELOPMENT_OPERATING_POLICY.md` | Ownership, GitHub workflow, AI cost, Buzz, Cloudflare, VPS and single-file Google Drive backups (v1.0) | Humans in full; agents by section |
| `MODELS.md` | Model experiments and spending limits; no restriction on provider use for private code/customer data | Humans; agents when choosing or delegating |
| `templates/` | `PROJECT_AGENTS.md`, `CLAUDE.md`, `PLAN.md`, `ADR.md`, PR template | Agents copy them into repos when missing |
| `claude/agents/` | Optional example sub-agent instructions for Claude Code | Install separately if desired; not required |
| `install/` | `install.sh` (macOS/Linux) and `install.ps1` (Windows) | Each developer, once and after each release |
| `docs/owner/` | Owner setup checklist | The owner only |

## How it works

```text
ulasnazim/engineering-standard (GitHub, main = approved version)
        │  git clone / pull (installer)
        ▼
~/.engineering-standard/            on each developer machine
        │  installer registers AGENT_BOOTSTRAP.md as global instructions
        ├── Claude Code  ~/.claude/CLAUDE.md   (@import: updates apply on every git pull)
        ├── Codex        ~/.codex/AGENTS.md     (embedded copy: re-run installer after releases)
        └── OpenCode     ~/.config/opencode/AGENTS.md (embedded copy)
        ▼
any repository ── first agent session ──► agent inspects the repo, selects profiles,
                                          writes AGENTS.md + gap report, opens a PR
```

The installer adds a clearly marked block to each supported global instruction file. Other instructions are preserved and a one-time backup is kept (`*.before-engineering-standard`); `--uninstall` removes the managed block. It does not install optional Claude helper-agent files or configure other AI tools.

## Install (each developer)

```bash
git clone git@github.com:ulasnazim/engineering-standard.git ~/.engineering-standard
bash ~/.engineering-standard/install/install.sh            # add --dry-run first to preview
```

Windows (PowerShell): clone to `%USERPROFILE%\.engineering-standard`, then run `.\install\install.ps1`.

Other tools such as Cursor, Gemini CLI or OpenClaw: paste `AGENT_BOOTSTRAP.md` into that tool's global or user rules. Tools and sessions with no global configuration can use the one-paragraph instruction in Policy §9.

## Starting a new project

Create the repository and open your AI tool in it. On first use the agent adopts the standard (bootstrap §2): it writes `AGENTS.md` with verified commands and only the applicable profiles, adds `CLAUDE.md` (`@AGENTS.md`), the PR template and `docs/plans/`, and opens a PR with a gap report. You review and merge it. There is nothing to fill in by hand.

## Cloud agents

Cloud-hosted agents (for example GitHub-triggered or browser-based coding agents) do not see a developer's home directory. They follow the repository's `AGENTS.md`, which includes a "Portable core" of the hard rules written at adoption. If such an agent has read access to this repository, the `AGENTS.md` header tells it where the full policy lives.

## Limits to be aware of

- Instruction files are **guidance** that models usually, but not always, follow. CI and PR evidence improve reliability. For a **private personal repository**, enforced branch protection requires a qualifying GitHub paid plan such as Pro; on Free, perform the process manually and do not claim GitHub enforced it.
- Every team member may deploy after meeting the applicable Definition of Done. An agent can perform a named team member's deployment with scoped access and release logs; destructive data changes remain separately authorized.
- One dated encrypted archive file per VPS backup run is uploaded to **Ulaş's Google Drive**; keep several recovery points and test a restore.
- Private code and customer data may be sent to **any AI provider** for team work, while credentials and authentication secrets stay out of prompts and logs.
- This ZIP included a `.git` directory from an earlier local draft. Publish only the clean file tree; do not import that embedded history into a new repository.
- Codex caps combined instruction files at 32 KiB by default. The bootstrap is kept small for that reason; do not inline the full Standard into global files.
- Tool behaviour changes often. Verify after installing: open a tool in any repo and ask "which engineering policy version are you following?"

## Changing the policy

Open an issue, then a PR with the problem, evidence, affected projects, benefit and migration. Update `VERSION` and `CHANGELOG.md` for later releases. Changes to MUST rules require Ulaş's approval. Agents may draft changes but cannot approve them on behalf of the owner.
