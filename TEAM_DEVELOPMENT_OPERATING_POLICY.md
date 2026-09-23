# Team Development Operating Policy

**Version:** 1.0 (approved owner decisions incorporated)
**Date:** 2026-09-23  
**Owner:** Project owner; adoption and changes to mandatory rules require their approval.  
**Applies to:** Human developers, contractors, AI agents, and every software project the team adopts.

## 1. Purpose and authority

We build understandable, maintainable software with AI assistance. Humans remain accountable for product decisions, access, quality, security, and releases.

The version-controlled **Universal Software Engineering Standard** governs engineering quality, project profiles, AI-agent conduct, and the Definition of Done. This policy adds team workflow, tool ownership, infrastructure preferences, and cost controls. Neither replaces a project's `AGENTS.md`, which records local facts. If the documents conflict, stop and ask the project owner and technical lead to resolve the conflict in a recorded change. No project exception may silently weaken security or data integrity.

**Adoption prerequisite:** An approved, versioned copy of the Universal Standard and this policy lives in the owner's `ulasnazim/engineering-standard` GitHub repository. Its `main` branch is the approved version. Policy changes are proposed in a PR and approved by Ulaş Nazım. Where his GitHub plan supports protected branches on private repositories, enable protection. A chat message, shared URL that might change, or an agent's memory is not sufficient.

**How agents receive the policy without per-project editing:**

1. Every developer machine may run `install/install.sh` (or `install.ps1`) to register `AGENT_BOOTSTRAP.md` with the tools those scripts support. Other tools need their own global-rule configuration. A global instruction alone cannot guarantee that an agent reads or follows it; project PR checks and human review supply independent evidence.
2. The first time an agent works in a repository without a compliant `AGENTS.md`, the bootstrap makes the agent inspect the project, select only the applicable profiles and generate `AGENTS.md` itself, recording the policy version it applied. Humans do not hand-edit per-project files; they review the agent's PR.
3. Cloud-hosted agents that cannot see a developer's machine rely on the "Portable core" section that step 2 writes into each `AGENTS.md`.

## 2. People, ownership, and access

- The **project owner, Ulaş Nazım**, defines priorities, budget and acceptable business risk. The GitHub account and repositories, Cloudflare domains, VPS/VDS account, Google Drive backup destination and AI-provider accounts remain under his ownership/control. Team members receive access to his projects; leaving the team must not remove the code, domains, backups or access to accounts from Ulaş.
- A **technical lead** selects the smallest sensible architecture, approves exceptional infrastructure choices, maintains CI and deployment documentation, and owns technical incident response.
- A **developer** owns assigned issues, checks AI-generated code, writes tests, and prepares reviewable pull requests (PRs). The developer who accepted the work remains responsible even if an agent wrote it.
- A **reviewer** other than the author reviews significant changes when another qualified developer is available. While only one engineer works on a project, that engineer records self-review and test evidence, and the owner can inspect the PR; a separate AI review can help find mistakes but does not count as an independent human review. Critical security/data changes merit a qualified second opinion when feasible.
- An **AI agent** is an assistant, not an approver, administrator, or unaccountable autonomous team member. It gets task-scoped permissions and a named human owner. It may propose changes to policies, but cannot approve them.

Accounts must be individual, never shared. Enable MFA on GitHub, Cloudflare, Google and VPS-provider accounts; use SSH keys for server access. Grant each team member appropriate access, record who made each change or deployment, keep a recoverable owner account, and revoke/rotate access when someone leaves. The repository's presence in Ulaş's account controls access, but does not by itself transfer a developer's intellectual-property rights: have written agreements assigning project code and AI-assisted output to Ulaş or his nominated entity.

## 3. The default tool map

| Concern | Default | Boundary |
| --- | --- | --- |
| Source and review | Private repository per product in Ulaş's `ulasnazim` GitHub account | Code, issues, PR evidence and releases have an authoritative home here. For enforceable branch protection on private personal repositories, check GitHub Pro or a suitable paid plan; the policy does not require a paid organization. |
| Planning | GitHub Issues and Projects | Every meaningful task has an issue with outcome and acceptance criteria. |
| Conversation and agent collaboration | Pilot Buzz in an isolated environment | Conversation may happen here; decisions and merge evidence still land in GitHub. |
| Domains and DNS | Company-controlled Cloudflare account | Register domains in the company's name through Cloudflare Registrar where the TLD is supported. Domains registered there must use Cloudflare nameservers, and not every TLD is available, so check country-code domains first. Auto-renew and transfer lock stay on. Limit DNS-automation tokens to the relevant zone. |
| Application hosting | Company-managed VPS/VDS | No default Vercel or Supabase dependency; exceptions require an explicit decision. |
| Backups | One encrypted archive file **per backup run** uploaded to Ulaş's Google Drive | Keep dated recovery points; a single file overwritten every day would leave no earlier version to restore. |

GitHub, Cloudflare, offsite backup storage and paid model APIs are intentional external dependencies. “VPS-hosted” describes application runtime and data services, not a claim that every supporting service is local.

**Buzz pilot:** Buzz's own repository documents a single-node production Compose bundle with Postgres, Redis, MinIO and a Git volume, and an agent CLI. Start with one project and limited access. Measure resource use, reliability, backup/restore, permissions and how its agents reference GitHub issues/PRs. Do not treat Buzz's planned features as deployed controls. Do not replace GitHub Issues/PRs, reviews or CI until the same controls are demonstrated and approved. If the Buzz deployment threatens production capacity, run it on a separate instance or postpone the pilot.

## 4. Project setup and human-readable code

Each new project must have its own repository and at minimum:

- `README.md` with purpose, local setup and run instructions;
- a concise `AGENTS.md` pointing to exact policy versions, selecting **only applicable** Universal Standard profiles, and documenting verified test/build commands, architecture and deployment constraints;
- tracked source, tests, `.gitignore`, `.env.example` without real values, dependency lockfiles, and CI checks appropriate to the stack;
- an issue/PR template recording acceptance criteria, changed behaviour, test evidence, rollout and rollback notes;
- a short decision record for consequential architecture choices, with a reason and alternatives considered.

Apply Clean Code and clear module responsibilities. Use a domain/application/infrastructure split only where it makes changes easier; do not create layers and interfaces for every simple CRUD operation. Readability, traceability and small PRs matter more than folder-count or trendy frameworks. Repositories are proprietary by default. Adding a copyleft-licensed dependency (GPL, AGPL, LGPL, SSPL) requires the project owner's approval. Implement and check accessibility, responsive behaviour, permissions and error states where relevant, as required by the Universal Standard.

## 5. One routine from idea to release

1. **Specify:** Project owner and developer create or refine a GitHub issue with user outcome, acceptance criteria, privacy/security concerns and non-goals. The technical lead makes a short design decision only if the choice is consequential.
2. **Assign:** Name one human owner and one agent/task owner; state the access scope and a time/usage budget. Avoid duplicate agents on the same task unless work is explicitly divided.
3. **Implement:** Work on a short-lived branch, preferably in small, reviewable increments. Agents read project instructions and existing code first. Any team member may deploy a completed change; an agent may perform the deployment on a named team member's instruction using appropriately scoped access. Agents do not change mandatory policies by themselves.
4. **Verify:** Run relevant formatting, linting, type checks, tests and builds. A green AI message is not test evidence.
5. **Review:** Open a PR linked to the issue with a short explanation, test results, screenshots for UI changes, migration impact and rollback notes. CI must pass; request another human's review when available. Enable required PR reviews and status checks on `main` if the account's plan supports enforcement for private repositories. On an unsupported plan, follow the workflow manually and record that the checks are not enforced by GitHub.
6. **Release:** Every team member may deploy after the applicable Definition of Done and deployment checklist are met; no special person or case-by-case owner permission is required for a normal release. Record who deployed which revision and when. Verify health, critical user journeys and logs; keep an identified rollback or forward-recovery path. A deployment agent acts for its named team member and records the same evidence.
7. **Close:** Mark the issue complete only after the Universal Standard's applicable Definition of Done is met. Record what was not verified or what remains blocked; never label a merely generated feature “done.”

Urgent incident changes can use an expedited path with a named human authorizer, recorded reason, retrospective PR/review and incident follow-up. An emergency is not a permanent exemption.

## 6. AI tools, model selection and cost controls

Do not make a premium model or a multi-agent chain the automatic default. Choose the cheapest *reliable* process, measured by total cost per accepted task, including retries, human rework, latency and security—not just input-token price.

| Task | Starting approach | Escalate when |
| --- | --- | --- |
| Clear small code or tests | Deterministic tooling plus a cost-effective coding agent/model (DeepSeek may be a pilot candidate) | Tests fail repeatedly, scope is unclear, or quality drops. |
| Architecture, ambiguous requirements and migration plans | Strong reasoning model for a bounded design pass plus a human decision | High impact or multiple viable designs demand deeper review. |
| Security-sensitive logic, database migrations, payment or cross-tenant access | Human technical lead plus stronger model for targeted analysis/review | Never replace independent human approval with AI. |
| Formatting, linting, type checking, builds and ordinary tests | Automated tools, not model calls | Use AI only to investigate a nontrivial failure. |
| Simple support or status replies | Short context, inexpensive model if AI is needed | Escalate complex decisions or sensitive data. |

For each task: define an acceptance test, cap agent turns/time and spending, load only relevant files, summarize decisions once, stop repeated failed attempts and hand off a compact evidence-backed report. Track approximate cost and rework per *accepted issue*, not raw tokens alone. Run a small comparison on real tasks before adopting any model/provider as default. A ChatGPT/Codex subscription, API billing and an OpenRouter or DeepSeek account are distinct commercial arrangements: do not assume one covers the other.

**Owner's AI-data decision:** Private code, customer data and other project material **may be sent to any AI provider** to complete team work. Do not impose provider, geography or data-class restrictions on this permission. Share only what the task needs to reduce token use and accidental disclosure; never send authentication credentials, API keys, SSH keys or raw `.env` secrets in prompts or logs. Team members remain responsible for applicable customer agreements and mandatory legal duties. `MODELS.md` records economical model choices and optional provider notes, rather than restricting use of private code or customer data.

**Delegation:** when a tool supports sub-agents with a model choice, a stronger model may plan and delegate clear, testable implementation steps to a cheaper executor, then check the result. Delegation is optional and must reduce total cost per accepted task. Avoid sending entire database exports when a relevant sample will do. Agents cannot purchase services, create broad API tokens, or escalate their own privileges without explicit human authorization.

## 7. Single-VPS hosting: preferred starting point, not a guarantee

Start small on the existing VPS **after** inventorying its real CPU, RAM, disk, network, running services, open ports and backup state. Use a documented reverse proxy with TLS and an isolated deployment stack per product, for example separate Compose projects, databases/roles, secrets, volumes and resource limits. Prefer a subdomain per application and separate staging/test state from production data. Do not expose database ports to the public internet. Store persistent uploads and database data in named, backed-up volumes. Monitor disk, memory, uptime, TLS, backups, errors and costs, using an uptime monitor hosted **outside** the VPS.

**Cloudflare edge:** proxy web records, use SSL/TLS mode Full (strict), and prefer a Cloudflare Tunnel so the VPS needs no open web ports. Alternatively, allow ports 80/443 only from Cloudflare's IP ranges. Put staging and admin interfaces behind Cloudflare Access. Do not host email on the VPS. Every domain has SPF, DKIM and DMARC records, and domains that send no mail publish `v=spf1 -all` and DMARC `p=reject`.

Production applications must not share administrator credentials or writable production secrets with the OpenClaw coding agent or Buzz. A team member may use an agent to deploy through a scoped, auditable deployment mechanism. Do not give AI agents unrestricted root access, production database write access, or a production Docker socket merely to enable releases. CI can run on GitHub-hosted runners; do not install a general-purpose self-hosted GitHub Actions runner on the production VPS merely for convenience. Pin deployed image versions; never rely on an unreviewed moving `latest` or `main` tag for production.

**The one-server trade-off:** If the VPS fails, *every hosted application can be unavailable at once*. Set per-project recovery targets (maximum data loss and acceptable downtime). By default create **one dated, encrypted archive file per run** containing database-consistent exports, application files and uploads, necessary system/configuration files and a restore manifest; upload that one file to a folder in **Ulaş's Google Drive**. Retain multiple dated single-file archives (initial target: 7 daily, 4 weekly, 6 monthly) rather than overwriting the only recoverable copy. Perform a pre-migration backup. Monitor upload completion, file integrity and Drive storage quota; keep the decryption key available to Ulaş independently of the VPS and Drive. Restore the archive into a separate test environment at least monthly and document how to rebuild the OS and applications. GitHub source is not a backup of production data; an encrypted application-data archive is not automatically a bootable full-disk image. If business-critical uptime eventually requires a second server or a provider snapshot, propose it as a separate, owner-controlled addition.

## 8. Approval gates and policy improvement

The project owner approves new products, budgets, domains and account access. The technical lead reviews architecture exceptions, production secrets scope and migration design. Normal deployments are open to every team member under §5. Destructive data changes, permission escalation, account takeover and new external costs still require an explicit human decision and a recovery plan.

Propose refinements to this policy or the Universal Standard through a GitHub issue and PR. The proposal must state a concrete problem, evidence, affected projects, expected benefit, cost and migration plan. Agents may draft it; a human owner must approve changes to mandatory rules. Review both documents after incidents and on a regular cadence, deleting rules that are duplicative or cannot be tested.

## 9. Reusable instruction for any coding agent

Machines that ran the installer do not need this; `AGENT_BOOTSTRAP.md` loads automatically. Paste the following only into tools or sessions with no global configuration:

> Read this repository's `AGENTS.md` and its pinned versions of the Universal Software Engineering Standard and Team Development Operating Policy. Inspect the actual project and Git state; select only applicable project profiles and, if necessary, create or update `AGENTS.md` with accurate project-specific commands and constraints. Link work to its GitHub issue, implement a focused change, run relevant checks, and report exact evidence. The owner permits use of any AI provider for private code and customer data; never expose credentials or secrets. Any team member may deploy after the applicable Definition of Done, with a recorded release and recovery path. Choose the cheapest reliable model and keep context/tool calls bounded. Do not claim completion until all applicable Definition of Done items pass; report unverified or blocked items honestly.

**Important:** This is a template for *each real application repository*. The policies alone do not reveal an application's build commands, active profiles, current VPS configuration or secrets. Verify those per project before generating its `AGENTS.md` or deploying it.

## 10. First adoption steps

1. Verify Ulaş owns and can recover the `ulasnazim` GitHub account, Cloudflare, VPS and Google Drive backup destination. Enable MFA, document recovery contacts and access; sign appropriate IP-assignment and confidentiality agreements for team contributions and AI-assisted output.
2. Approve and version the policy repository, push it to GitHub with a protected `main`, and have every developer run the installer.
3. Use one small existing product as a pilot: let an agent generate its `AGENTS.md` and gap report, then add branch protection and minimal CI with the technical lead.
4. Inventory the current VPS and implement and test an offsite restore before adding more production services.
5. Run one measured AI coding comparison on real, testable tasks; record a per-issue budget and candidate models in `MODELS.md`.
6. Trial Buzz separately with noncritical data; keep GitHub as the record of code, issues, PRs and releases until the pilot earns a broader role.

## Sources for product-specific claims

- GitHub [pull request standardization](https://docs.github.com/en/pull-requests/reference/managing-and-standardizing-pull-requests), [Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects) and [runner security](https://docs.github.com/en/actions/reference/security/secure-use).
- Cloudflare [scoped API token creation](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/), [Registrar registration](https://developers.cloudflare.com/registrar/get-started/register-domain/) and [supported TLDs](https://developers.cloudflare.com/registrar/top-level-domains/).
- GitHub [protected branches plan availability](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule) and [content ownership terms](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service).
- Google Drive [file-size limits](https://support.google.com/drive/answer/37603).
- Claude Code [memory and instruction files](https://code.claude.com/docs/en/memory); OpenCode [rules](https://opencode.ai/docs/rules/); Codex [AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).
- Buzz [current capabilities](https://github.com/block/buzz/blob/main/README.md) and [VPS Compose deployment](https://github.com/block/buzz/blob/main/deploy/compose/README.md).
- PostgreSQL [backup and point-in-time recovery](https://www.postgresql.org/docs/current/continuous-archiving.html).
