# AGENTS.md: [repository name]

Adopted: engineering-standard [bundle version, e.g. 2.0.0] on [YYYY-MM-DD] by [tool/model], reviewed in PR #[n] if applicable.
Governing documents: Universal Software Engineering Standard + Team Development Operating Policy, from `ulasnazim/engineering-standard` (local clone: `~/.engineering-standard/`). This file records **project facts only**. Agents maintain it; humans review changes by PR.

## Product
[One or two sentences: what it does and for whom. Link `docs/BRIEF.md` if present.]

## Active profiles (Standard §18)
- [Profile]: [evidence, e.g. "Next.js pages in app/; served to browsers"]

## AI tools and test data
The owner permits private code and customer data with any AI provider. Never put credentials or authentication secrets in prompts, commits or logs. Project-specific test fixtures: [path or TODO(owner)].

## Verified commands
- Install: `[cmd]`
- Develop: `[cmd]`
- Test all / one file: `[cmd]` / `[cmd]`
- Type-check: `[cmd]`
- Lint + format: `[cmd]`
- Build: `[cmd]`
- Smoke test: `[cmd]`

## Repository map
- Entry point: `[path]` · Business logic: `[path]` · Data access and migrations: `[path]` · Tests: `[path]`
- Plans `docs/plans/` · ADRs `docs/adr/` · Runbook `docs/RUNBOOK.md`

## Architecture rules
[Allowed dependency directions and module boundaries actually present in the code.]

## Deployment
[Target (owner's VPS / not deployed yet), deployment command or automation, health endpoint, rollback path, persistent data locations and how this app receives credentials. Ulaş separately manages Hostinger backups. Any team member may deploy within existing authority; an agent may act on a named team member's instruction. TODO(owner) where unknown.]

## Data-change history and recovery (if the product stores valuable records)
[How deletion is reversed, where create/update/delete and bulk-change audit events are kept, agent/sponsoring-human attribution, retention, bulk-delete alerts and verified recovery. Write "Not applicable" for products without valuable persistent records.]

## Project-specific rules
[Only rules genuinely specific to this repository, or "None".]

## Material human decisions and exceptions (if any)
| Default | Decision and likely consequence | Human | Scope |
|---|---|---|---|

## Portable core (for agents without the global policy installed; do not edit)
- Never commit, log or send credentials, authentication secrets or `.env` secrets to AI providers; private code and customer data may go to any AI provider for the task.
- Prefer branch and issue for meaningful work; avoid force-push to shared branches. Any team member may deploy within existing authority, including with a disclosed engineering exception. An agent may execute a named member's scoped deployment. Log the revision and checks run or skipped.
- Small focused changes; Conventional Commits; validate input; authorise server-side; parameterised queries.
- Tests for behaviour changes and regressions; run lint, type-check, tests and build before the PR.
- New backward-compatible migrations only; never edit an applied migration.
- Valuable records: reversible deletion when appropriate, automatic change/deletion audit with actor and sponsoring human for agent actions, unusual bulk-delete alert and tested recovery. Obsidian can contain summaries but is not the audit source.
- Readable code; comments explain why; no dead code or debug output; justify new dependencies; no copyleft without owner approval.
- Same step fails twice → stop and report. Do not invent commands or results.
- A human developer may choose engineering exceptions without a new approval gate. Flag material risk once, follow the authorized decision, and record a short reason/consequence. Destructive production data changes, permission escalation and paid purchases still need a decision by someone empowered to make it. Owner account/access/budget authority persists. Report what changed, what was checked or skipped, and deployment status honestly.
