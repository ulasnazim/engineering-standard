# Team Development Operating Policy

**Version:** 3.0 (owner-approved human discretion and Hostinger-managed VPS backups)
**Date:** 2026-09-23  
**Owner:** Project owner; adoption and changes to mandatory rules require their approval.  
**Applies to:** Human developers, contractors, AI agents, and every software project the team adopts.

## 1. Purpose and authority

We build understandable, maintainable software with AI assistance. Humans remain accountable for product decisions, access, quality, security, and releases.

The version-controlled **Universal Software Engineering Standard** provides engineering defaults, project profiles, AI-agent conduct, and the Definition of Done. This policy adds team workflow, tool ownership, infrastructure preferences, and cost controls. Together, the two documents in `ulasnazim/engineering-standard` are the top-level owner-approved team policy. Other rule repositories may define narrower agent workflows, and a project's `AGENTS.md` records local facts; neither silently changes team-wide rules. Flag conflicts for a policy or project PR. The responsible human developer may choose an engineering exception within their existing authority without another approval step. For material security, data, availability or cost consequences, leave a short note in the issue, PR or release record. Agents flag a material risk once, then follow the decision without repeated confirmation and report unverified work truthfully. An engineering exception does not transfer Ulaş's account ownership or spending/access authority and does not waive legal or customer obligations. Only Ulaş approves changes to the published policy.

**Adoption prerequisite:** An approved, versioned copy of the Universal Standard and this policy lives in the owner's `ulasnazim/engineering-standard` GitHub repository. Its `main` branch and matching release are the approved version. Policy changes are proposed in a PR and approved by Ulaş Nazım. Protect this public repository's `main` with a PR and the repository's CI checks when repository settings allow it; do not make a second human reviewer mandatory. On private repositories, check plan support before claiming branch protection is enforced. A chat message, shared URL that might change, or an agent's memory is not sufficient.

**How agents receive the policy without per-project editing:**

1. Every developer machine may run `install/install.sh` (or `install.ps1`) to register `AGENT_BOOTSTRAP.md` with the tools those scripts support. Other tools need their own global-rule configuration. A global instruction alone cannot guarantee that an agent reads or follows it; project PR checks and human review supply independent evidence.
2. The first time an agent works in a repository without a compliant `AGENTS.md`, the bootstrap makes the agent inspect the project, select only the applicable profiles and generate `AGENTS.md` itself, recording the policy version it applied. Humans do not hand-edit per-project files; they review the agent's PR.
3. Cloud-hosted agents that cannot see a developer's machine rely on the "Portable core" section that step 2 writes into each `AGENTS.md`.

## 2. People, ownership, and access

- The **project owner, Ulaş Nazım**, defines priorities, budget and acceptable business risk. The GitHub account and repositories, Cloudflare domains, Hostinger VPS/backups and AI-provider accounts remain under his ownership/control. Team members receive access to his projects; leaving the team must not remove the code, domains or access to accounts from Ulaş.
- A **technical lead** recommends the smallest sensible architecture, helps with exceptional infrastructure choices, maintains CI and deployment documentation, and owns technical incident response. Routine engineering choices do not wait for their approval.
- A **developer** owns assigned issues, checks AI-generated code, writes tests, and prepares reviewable pull requests (PRs). The developer who accepted the work remains responsible even if an agent wrote it.
- A **reviewer** other than the author can help with significant changes when available; lack of a second reviewer does not block an authorized release. A solo developer briefly inspects the diff and relevant risks, such as permissions, tenant boundaries or database locking when touched. An AI review may help but is not an independent human review. Critical security/data changes merit a qualified second opinion when feasible, without becoming a universal gate.
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

GitHub, Cloudflare, Hostinger and paid model APIs are intentional external dependencies. “VPS-hosted” describes application runtime and data services, not a claim that every supporting service is local. VPS backups are an owner-managed Hostinger service, outside the engineering policy and its CI/CD workflows.

**Buzz pilot:** Buzz's own repository documents a single-node production Compose bundle with Postgres, Redis, MinIO and a Git volume, and an agent CLI. Start with one project and limited access. Measure resource use, reliability, permissions and how its agents reference GitHub issues/PRs. Do not treat Buzz's planned features as deployed controls. Do not replace GitHub Issues/PRs, reviews or CI until the same controls are demonstrated and approved. If the Buzz deployment threatens production capacity, run it on a separate instance or postpone the pilot.

## 4. Project setup and human-readable code

Each new project should have its own repository and, in a form proportionate to its size and risk:

- `README.md` with purpose, local setup and run instructions;
- a concise `AGENTS.md` pointing to exact policy versions, selecting **only applicable** Universal Standard profiles, and documenting verified test/build commands, architecture and deployment constraints;
- tracked source, tests, `.gitignore`, `.env.example` without real values, dependency lockfiles, and CI checks appropriate to the stack;
- an issue/PR template recording acceptance criteria, changed behaviour, test evidence, rollout and rollback notes;
- a short decision record for consequential architecture choices, with a reason and alternatives considered.

Apply Clean Code and clear module responsibilities. Use a domain/application/infrastructure split only where it makes changes easier; do not create layers and interfaces for every simple CRUD operation. Readability, traceability and small PRs matter more than folder-count or trendy frameworks. Repositories are proprietary by default. Adding a copyleft-licensed dependency (GPL, AGPL, LGPL, SSPL) requires the project owner's approval. Implement and check accessibility, responsive behaviour, permissions and error states where relevant, as required by the Universal Standard.

## 5. One routine from idea to release

1. **Specify:** For meaningful work, capture the user outcome and acceptance criteria in GitHub. A direct PR can suffice for a small change. Record a design decision only if consequential.
2. **Assign:** Name one human owner and one agent/task owner; state the access scope and a time/usage budget. Avoid duplicate agents on the same task unless work is explicitly divided.
3. **Implement:** Work on a short-lived branch, preferably in small, reviewable increments. Agents read project instructions and existing code first. Any team member may deploy a completed change; an agent may perform the deployment on a named team member's instruction using appropriately scoped access. Agents do not change mandatory policies by themselves.
4. **Verify:** Run checks relevant to the change and report what actually ran. A human may choose a proportionate exception and note its material risk. A green AI message is not test evidence.
5. **Review:** For meaningful work, use a PR with a short explanation, checks and any material exceptions. Ask another human to review when helpful and available. CI is recommended; configure branch rules for the team's needs instead of requiring a second reviewer or every checklist item before every merge.
6. **Release:** Every team member may deploy within their existing authority, including with a clearly recorded engineering exception; no case-by-case owner approval is required for a normal release. Record who deployed which revision and when, what was checked or skipped and the recovery path. An agent acts for its named team member and records the same evidence.
7. **Close:** Mark an issue delivered when the responsible human accepts the outcome, noting outstanding checks or follow-ups. An agent distinguishes shipped with an exception from fully verified and never labels merely generated code as tested.

Urgent incident changes can use an expedited path with a named human authorizer, recorded reason, retrospective PR/review and incident follow-up. An emergency is not a permanent exemption.

## 6. AI tools, model selection and cost controls

Do not make a premium model or a multi-agent chain the automatic default. Choose the cheapest *reliable* process, measured by total cost per accepted task, including retries, human rework, latency and security—not just input-token price.

| Task | Starting approach | Escalate when |
| --- | --- | --- |
| Clear small code or tests | Deterministic tooling plus a cost-effective coding agent/model (DeepSeek may be a pilot candidate) | Tests fail repeatedly, scope is unclear, or quality drops. |
| Architecture, ambiguous requirements and migration plans | Strong reasoning model for a bounded design pass plus a human decision | High impact or multiple viable designs demand deeper review. |
| Security-sensitive logic, database migrations, payment or cross-tenant access | Stronger model for targeted analysis plus responsible human judgement | Recommend a qualified second opinion when useful; the human may choose another path within their authority. |
| Formatting, linting, type checking, builds and ordinary tests | Automated tools, not model calls | Use AI only to investigate a nontrivial failure. |
| Simple support or status replies | Short context, inexpensive model if AI is needed | Escalate complex decisions or sensitive data. |

For each task: define an acceptance test, cap agent turns/time and spending, load only relevant files, summarize decisions once, stop repeated failed attempts and hand off a compact evidence-backed report. Track approximate cost and rework per *accepted issue*, not raw tokens alone. Run a small comparison on real tasks before adopting any model/provider as default. A ChatGPT/Codex subscription, API billing and an OpenRouter or DeepSeek account are distinct commercial arrangements: do not assume one covers the other.

**Owner's AI-data decision:** Private code, customer data and other project material **may be sent to any AI provider** to complete team work. Do not impose provider, geography or data-class restrictions on this permission. Share only what the task needs to reduce token use and accidental disclosure; never send authentication credentials, API keys, SSH keys or raw `.env` secrets in prompts or logs. Team members remain responsible for applicable customer agreements and mandatory legal duties. `MODELS.md` records economical model choices and optional provider notes, rather than restricting use of private code or customer data.

**Delegation:** when a tool supports sub-agents with a model choice, a stronger model may plan and delegate clear, testable implementation steps to a cheaper executor, then check the result. Delegation is optional and must reduce total cost per accepted task. Avoid sending entire database exports when a relevant sample will do. Agents cannot purchase services, create broad API tokens, or escalate their own privileges without explicit human authorization.

## 7. Single-VPS hosting: preferred starting point, not a guarantee

Start small on the existing VPS **after** inventorying its real CPU, RAM, disk, network, running services and open ports. Use a documented reverse proxy with TLS and an isolated deployment stack per product, for example separate Compose projects, databases/roles, secrets, volumes and resource limits. Prefer a subdomain per application and separate staging/test state from production data. Do not expose database ports to the public internet. Store persistent uploads and database data in named volumes and tell the owner which paths or volumes contain business data, so they can choose Hostinger backup coverage. Monitor disk, memory, uptime, TLS, errors and costs, using an uptime monitor hosted **outside** the VPS.

**Cloudflare edge:** proxy web records, use SSL/TLS mode Full (strict), and prefer a Cloudflare Tunnel so the VPS needs no open web ports. Alternatively, allow ports 80/443 only from Cloudflare's IP ranges. Put staging and admin interfaces behind Cloudflare Access. Do not host email on the VPS. Every domain has SPF, DKIM and DMARC records, and domains that send no mail publish `v=spf1 -all` and DMARC `p=reject`.

**Convenient secret entry:** Ulaş may enter OpenClaw credentials in its existing authenticated Control UI **Settings → Secrets** page. Choose a protected `secret` entry and SecretRef when the agent does not need the raw value. If a task needs an agent-readable `env` entry, a responsible human may choose one; explain once that OpenClaw permits the agent to print, send or save that value, and prefer a narrowly scoped, replaceable credential. No paid vault, compulsory SSH entry or compulsory hiding of all credentials. Never paste credentials into chat, commits or logs. Control UI access should use authentication and HTTPS or a trusted private connection. OpenClaw's shared SQLite secret store is not encrypted at rest; tell the owner where that store lives when selecting Hostinger backup coverage. The store serves OpenClaw, not automatically every unrelated production app; each app documents its own simple secret-entry and access method. [OpenClaw secret store](https://docs.openclaw.ai/gateway/secrets/secret-store-and-egress).

Prefer separate application credentials and scoped agent deployment access. Someone who can deploy arbitrary code can potentially make that code read app secrets even if the secrets are hidden from their prompt; do not promise isolation the deployment design cannot enforce. CI may run on GitHub-hosted runners. Avoid granting root, a production Docker socket or direct database writes solely for convenience; humans may make an informed engineering exception within their existing authority.

**The one-server trade-off:** If the VPS fails, every hosted application can be unavailable at once. Ulaş manages VPS backups through Hostinger and chooses the service, coverage, retention and restoration procedure. This repository does not prescribe or install a separate backup job, archive, Google Drive upload, monitoring schedule or recurring restore drill. Developers identify persistent data and tell Ulaş if a proposed migration or deletion could lose records; the responsible human chooses the recovery approach before an irreversible production change. GitHub source alone does not contain live application data.

**Customer and business records:** Each product holding valuable records should automatically keep a recoverable change history: reversible deletion when retention permits, actor and sponsoring human for agent actions, timestamp, affected IDs/count, and alerts for unexpected bulk deletion. Account for database changes outside the application where relevant. Do not require developers to type each action into a separate journal. Obsidian may contain readable summaries or incident notes; it is not the primary audit log or recovery system. See [data-change guidance](docs/DATA_CHANGE_RECOVERY.md). These are defaults a responsible human may adapt with a short note for material consequences.

## 8. Approval gates and policy improvement

The project owner retains decisions on new products, budgets, domains and account access. The technical lead can advise on architecture, production secret scope and migrations. A responsible human developer may accept an engineering exception and deploy within existing authority without another reviewer. Agents recommend applicable rules and material safeguards once, follow the authorized decision and report skipped checks accurately. Destructive production data changes, permission escalation, account takeover and new external costs still require authorization from someone empowered to approve them.

Propose refinements to this policy or the Universal Standard through a GitHub issue and PR. The proposal must state a concrete problem, evidence, affected projects, expected benefit, cost and migration plan. Agents may draft it; a human owner must approve changes to mandatory rules. Review both documents after incidents and on a regular cadence, deleting rules that are duplicative or cannot be tested.

## 9. Reusable instruction for any coding agent

Machines that ran the installer do not need this; `AGENT_BOOTSTRAP.md` loads automatically. Paste the following only into tools or sessions with no global configuration:

> Read this repository's `AGENTS.md` and the applicable engineering policy. Inspect the actual project and Git state; select relevant profiles and update `AGENTS.md` if needed. Implement a focused change, run relevant checks, and report what passed, failed or was skipped. Private code and customer data may go to any AI provider; keep credentials out of prompts and commits. OpenClaw's Secrets page is an acceptable entry route; a human may choose agent-readable access with awareness of the risk. Human developers may choose engineering exceptions within their authority: flag material risk once, follow their decision and briefly note material consequences. Any team member may deploy within their authority and log the revision and recovery approach. Use the cheapest reliable model. Never claim an unverified check passed.

**Important:** This is a template for *each real application repository*. The policies alone do not reveal an application's build commands, active profiles, current VPS configuration or secrets. Verify those per project before generating its `AGENTS.md` or deploying it.

## 10. First adoption steps

1. Verify Ulaş owns and can recover the `ulasnazim` GitHub account, Cloudflare and Hostinger VPS account. Enable MFA, document recovery contacts and access; sign appropriate IP-assignment and confidentiality agreements for team contributions and AI-assisted output.
2. Keep the owner-approved policy in GitHub; use branch checks that help without creating unwanted reviewer bottlenecks. Developers may run the optional installer or use equivalent tool instructions.
3. Use one small existing product as a pilot: let an agent generate its `AGENTS.md` and gap report, then add branch protection and minimal CI with the technical lead.
4. Inventory the current VPS and give Ulaş a concise list of the data paths and services to consider when configuring Hostinger backups.
5. Run one measured AI coding comparison on real, testable tasks; record a per-issue budget and candidate models in `MODELS.md`.
6. Trial Buzz separately with noncritical data; keep GitHub as the record of code, issues, PRs and releases until the pilot earns a broader role.

## Sources for product-specific claims

- GitHub [pull request standardization](https://docs.github.com/en/pull-requests/reference/managing-and-standardizing-pull-requests), [Projects](https://docs.github.com/en/issues/planning-and-tracking-with-projects) and [runner security](https://docs.github.com/en/actions/reference/security/secure-use).
- Cloudflare [scoped API token creation](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/), [Registrar registration](https://developers.cloudflare.com/registrar/get-started/register-domain/) and [supported TLDs](https://developers.cloudflare.com/registrar/top-level-domains/).
- GitHub [protected branches plan availability](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule) and [content ownership terms](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service).
- Claude Code [memory and instruction files](https://code.claude.com/docs/en/memory); OpenCode [rules](https://opencode.ai/docs/rules/); Codex [AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).
- Buzz [current capabilities](https://github.com/block/buzz/blob/main/README.md) and [VPS Compose deployment](https://github.com/block/buzz/blob/main/deploy/compose/README.md).
- OWASP [application audit logging](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html).
