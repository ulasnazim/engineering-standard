# Agent Bootstrap: Universal Engineering Policy

**Bundle version:** see `VERSION` in the policy repository (1.0.0 = Universal Software Engineering Standard 1.0 + Team Development Operating Policy 1.0).
**Applies to:** every repository, every AI coding tool, every model, for all work done for this team.
**Policy files:** the local clone named in the installer line above this file (default `~/.engineering-standard/`). If you cannot read the local clone, use Ulaş's `ulasnazim/engineering-standard` GitHub repository if you have access, otherwise the "Portable core" in the repository's `AGENTS.md`.

- `UNIVERSAL_SOFTWARE_ENGINEERING_STANDARD.md`: engineering rules, profiles (§18), Definition of Done (§17). About 8,000 tokens.
- `TEAM_DEVELOPMENT_OPERATING_POLICY.md`: ownership, GitHub workflow, AI cost and data rules, hosting.
- `MODELS.md`: model-cost choices and pilot results; private code and customer data may go to any AI provider under Policy §6.
- `templates/`: files you copy into a repository when they are missing.

## 1. Every session (keep this cheap)

1. Read the repository's `AGENTS.md`. Run `git status`. Preserve unrelated and uncommitted work.
2. If `AGENTS.md` is missing, or lacks the line `Adopted: engineering-standard`, perform **Project adoption** (§2) before feature work, unless the user's request is read-only or trivial. In that case mention that adoption is pending.
3. If `AGENTS.md` records an older bundle version than the current `VERSION`, tell the user and offer to refresh `AGENTS.md`. Do not refresh it unasked in the middle of other work.
4. **Do not** load the full Standard or Policy every session. Read only the sections the task needs (§4 index). Read the full Standard only during adoption.

## 2. Project adoption (once per repository; the agent does it, humans only review)

1. Read the full Standard and Policy. Inspect the repository: tree (two levels), manifests, lockfiles, CI, tests, Docker/deploy files, existing `README`/`AGENTS.md`/`CLAUDE.md`. Run the install, test and build commands you find, where it is safe to do so, so the commands you record are verified.
2. Select **only** the applicable Standard §18 profiles, each with one line of evidence. Report the rejected ones in the PR, not in the file.
3. Write `AGENTS.md` from `templates/PROJECT_AGENTS.md`. Fill every field from evidence. Where something cannot be verified, write `TODO(owner): <what is needed>`; never guess. Keep existing project-specific instructions; flag any that conflict with the policy instead of deleting them. Keep it under ~120 lines.
4. If `CLAUDE.md` is missing, add the small `@AGENTS.md` pointer from `templates/CLAUDE.md`. If it already exists, preserve its instructions and add a pointer only if supported and useful. Add `.github/pull_request_template.md` and `docs/plans/`, `docs/adr/` from `templates/` if missing.
5. Write a gap report `docs/adr/0001-engineering-standard-adoption.md`: the rules the repository does not yet meet, ranked by risk, each with a proposed issue title. Do not fix the gaps in the same change.
6. Branch `chore/adopt-engineering-standard`, commit `docs(repo): adopt engineering standard <version>`, open a PR. Do not merge it.

## 3. Hard rules (MUST, every repository)

- Never commit, print, log or send authentication secrets, `.env` secrets or credentials to an AI provider. **Private code and customer data may be sent to any AI provider** for team work as directed by the owner (Policy §6). Minimize irrelevant material to save tokens; observe applicable customer agreements and legal duties.
- Work on a short-lived branch linked to a GitHub issue. Do not force-push shared branches or silently change policy. **Every human team member may deploy** a change that satisfies the applicable Definition of Done; an agent may execute that deployment on its named team member's instruction using scoped access and an auditable release process. Destructive data changes, increased permissions or paid purchases still need explicit human authorization. Do not merge or change account settings without task authorization.
- Small, focused, reversible changes. Conventional Commits. No unrelated edits.
- Validate untrusted input at boundaries; authorise on the server; use parameterised queries; do not weaken tests, validation or security controls to get a green result.
- A behaviour change needs tests; a bug fix needs a regression test where practical. Run lint, type-check, tests and build, using deterministic tools rather than model judgement.
- Schema changes only through new, backward-compatible migrations. Never edit an applied migration.
- Human-readable code: intention-revealing names, small focused functions, comments that explain *why*. No narrating comments, dead code, debug output or commented-out attempts.
- New dependency: state why in the PR. Copyleft licences (GPL/AGPL/LGPL/SSPL) need owner approval.
- Do not invent APIs, commands, files, test results or completed steps.

## 4. Read on demand: section index

| The task involves | Read |
|---|---|
| Planning a feature, unclear requirements | Standard §1, §4; Policy §5 |
| Git, branches, commits, PRs | Standard §2; Policy §5 |
| Tests | Standard §5 |
| Auth, permissions, secrets, input handling | Standard §6; Policy §6 |
| Data, database, migrations | Standard §7, §18.4 |
| APIs, integrations, webhooks | Standard §8 |
| User interface | Standard §9, §10 |
| Performance, cost | Standard §11 |
| Logging, monitoring, errors | Standard §12 |
| Docker, deployment, VPS, Cloudflare | Standard §13; Policy §7 |
| Dependencies, CI supply chain | Standard §14 |
| Docs, ADRs | Standard §15 |
| AI features inside the product | Standard §18.6 |
| Finishing and reporting | Standard §16.3, §17 |

## 5. Cost discipline

- Use the cheapest reliable approach per *accepted task* (Policy §6). Deterministic tools do formatting, linting, type checks and builds, not model calls.
- Load only the files the task needs. Summarise once; do not re-read what is already in context. Use `tail`/`grep` on logs; never paste whole logs or dumps.
- **Plan → build handoff:** when the complexity justifies it, a strong model writes `docs/plans/<issue>-<slug>.md` from `templates/PLAN.md`, precise enough for a cheaper model that never saw the conversation. A clear small task may be implemented directly; an agent handoff is optional.
- If your tool offers helpers such as the optional `std-executor` / `std-reviewer` examples (installed separately), a strong model may delegate clear plan steps to a lower-cost executor and an independent diff review. Do this only when it lowers total cost. Never have an agent review its own work in the same context.
- If the same step fails twice, stop. Report what you tried and the exact error, and hand back. Do not loop.
- Security, payments, personal data, cross-tenant access and production migrations require careful verification and a recorded responsible human; ordinary deployments require no special approval gate.

## 6. Completion

Do not claim completion unless every applicable Definition of Done item (Standard §17) is satisfied. Report in the PR template: what changed · what was verified (commands and result lines) · what was not verified · risks · deployment status · decisions needed. List any unchecked applicable item explicitly. Planned or partial work is never "done".

## 7. Precedence

Safety, security and data integrity → the user's explicit requirements for this task → the repository's `AGENTS.md` → Team Development Operating Policy → Universal Standard → tool conventions. A repository file may add rules or record approved exceptions (with reason, owner, scope). It may never silently weaken security or data-integrity rules. If documents conflict, stop and ask.
