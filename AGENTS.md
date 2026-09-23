# Policy Repository Instructions

Adopted: engineering-standard 3.0.0 on 2026-09-23. Owner: Ulaş Nazım.

## Purpose

This repository holds the top-level engineering policies, model guidance, onboarding templates and optional installer scripts for Ulaş's software projects. It does not contain an application or the live VPS configuration. `main` and its matching release represent the owner-approved standard after publication. Other agent playbooks are subordinate for governance; project `AGENTS.md` records applicable facts and the adopted version.

## Governing files

Read `UNIVERSAL_SOFTWARE_ENGINEERING_STANDARD.md`, `TEAM_DEVELOPMENT_OPERATING_POLICY.md`, `AGENT_BOOTSTRAP.md` and `MODELS.md` before changing rules. Update dependent templates and documentation together. Mandatory policy changes require a GitHub PR and Ulaş's approval. A user's explicit later direction takes priority over older repository preferences; protect security, data integrity and unrelated work.

## Active Universal Standard profiles

- CLI, automation or background worker (§18.8): `install/install.sh` and `install/install.ps1` change global AI-tool instruction files on developer machines. For changes to these scripts, verify dry-run and uninstall behavior and preserve unrelated user instructions.
- No web, mobile, backend, database, IoT or multi-tenant application profile applies to the policy repository itself. Individual product repositories choose their own profiles.

## Structure and checks

- Entry: `README.md`; per-project guidance: `AGENT_BOOTSTRAP.md` and `templates/PROJECT_AGENTS.md`.
- Model and provider guidance: `MODELS.md`; policy versions: `VERSION` and `CHANGELOG.md`.
- Shell syntax: `bash -n install/install.sh`.
- Safe shell installer preview: `ENG_STANDARD_HOME="$(pwd)" bash install/install.sh --all --dry-run` (never use a real installation to verify a documentation-only change).
- Policy integrity: `python3 scripts/check_policy.py`.
- Linux installer smoke test: `bash scripts/test_install_sh.sh` (uses a disposable home and a local Git remote).
- Whitespace check: `git diff --check`.
- GitHub Actions checks the PowerShell installer syntax and dry-run on a Windows runner.

## Deployment

Publishing this public repository does not install instructions on developer machines or run jobs on the VPS. The owner uses Hostinger for VPS backups outside this repository. GitHub Actions publishes a versioned ZIP after checks pass on approved `main`; it excludes `.git`. Policy changes go through a PR before `main` is updated; each team member chooses when to install its tool configuration.

## Definition of Done

Report applicable Universal Standard §17 items and any human-accepted exception truthfully. For a policy-only change, check cross-file consistency, validate modified scripts, review the diff and report the repository/publication status accurately.
