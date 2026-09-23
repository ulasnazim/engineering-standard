# Policy Repository Instructions

Adopted: engineering-standard 1.0.0 on 2026-09-23. Owner: Ulaş Nazım.

## Purpose

This repository holds the engineering policies, model guidance, onboarding templates and optional installer scripts for Ulaş's software projects. It does not contain an application or the live VPS configuration. `main` represents the owner-approved standard after publication.

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
- Whitespace check: `git diff --check`.
- PowerShell syntax and behavior should be checked on a Windows machine before calling that installer verified; PowerShell was not available in the environment used to prepare v1.0.0.

## Deployment

Publishing this repository does not install instructions on developer machines or back up the VPS. Avoid including a prior `.git` directory in distributed ZIP files. Once Ulaş's private GitHub repository exists, publish the clean source tree, inspect the default branch, then let each team member choose whether to install its tool configuration.

## Definition of Done

All applicable items in the Universal Standard §17 must be met or explicitly reported as incomplete. For a policy-only change, check cross-file consistency, validate modified scripts, review the diff and report the repository/publication status accurately.
