# AGENTS.md: [repository name]

Adopted: engineering-standard [bundle version, e.g. 1.0.0] on [YYYY-MM-DD] by [tool/model], reviewed in PR #[n].
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
[Target (owner's VPS / not deployed yet), deployment command or automation, health endpoint, backup/rollback method. Any team member may deploy after applicable DoD checks; an agent may act on a named team member's instruction. TODO(owner) where unknown.]

## Project-specific rules
[Only rules genuinely specific to this repository, or "None".]

## Approved exceptions
| Rule | Reason | Owner | Scope | Expiry |
|---|---|---|---|---|

## Portable core (for agents without the global policy installed; do not edit)
- Never commit, log or send credentials, authentication secrets or `.env` secrets to AI providers; private code and customer data may go to any AI provider for the task.
- Branch per GitHub issue; avoid force-push to shared branches. Any team member may deploy after the applicable DoD; an agent may execute a named member's scoped deployment. Log the revision and verification.
- Small focused changes; Conventional Commits; validate input; authorise server-side; parameterised queries.
- Tests for behaviour changes and regressions; run lint, type-check, tests and build before the PR.
- New backward-compatible migrations only; never edit an applied migration.
- Readable code; comments explain why; no dead code or debug output; justify new dependencies; no copyleft without owner approval.
- Same step fails twice → stop and report. Do not invent commands or results.
- Destructive data changes, permission escalation and paid purchases need explicit human authorization. Not done until the Definition of Done passes; the PR reports what changed, was verified (commands), was not verified, risks, deployment status and decisions needed.
