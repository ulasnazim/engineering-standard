# Universal Software Engineering Standard

**Version:** 2.0
**Updated:** 2026-09-23  
**Audience:** Human developers, AI coding agents, coding assistants, reviewers and deployment tools  
**Scope:** All software projects, regardless of language, framework, platform or provider

## Purpose

This document is the permanent, tool-neutral engineering standard for every authorised software project.

Its goals are to produce software that is:

- Correct and useful.
- Secure and reliable.
- Easy for humans to read, review, test and change.
- Accessible and responsive where it has a user interface.
- Traceable from requirement to deployment.
- Safe for AI agents and automation to modify.
- Simple enough for the actual needs of the project.

This standard is not permission to redesign or refactor an entire project. Apply it incrementally and preserve working behaviour.

## Requirement levels

- **MUST** and **MUST NOT** describe the default instructions for agents and tools. A responsible human developer may choose a task-specific engineering exception within their existing authority.
- **SHOULD** and **SHOULD NOT** are recommendations that humans may adapt to the project.
- **MAY** is optional.

For a material exception affecting security, customer records, availability or cost, the human developer leaves a short note with the decision, likely consequence and affected scope in the issue, PR or release record. Routine choices need no exception paperwork or additional approver. Agents flag a material concern once, suggest a practical alternative, then follow the authorized human's decision without an approval loop. No exception grants account ownership, additional access or spending authority, or waives legal or customer obligations. An agent must never claim a skipped check passed.

When rules conflict, use this priority:

1. Safety, security and data integrity.
2. Explicit user requirements and acceptance criteria.
3. Existing project-specific instructions.
4. This universal standard.
5. Tool or framework conventions.

Material changes to security and data-integrity defaults should be visible in the release record; they do not need a separate technical-lead sign-off when the human task owner already has authority.

## How every tool and agent must use this standard

Before making changes, every contributor MUST:

1. Read the repository's `AGENTS.md` or equivalent instruction file.
2. Identify the adopted version of this standard.
3. Load only the relevant project profiles listed by the repository.
4. Inspect the repository structure, current implementation, tests and Git status.
5. Understand the requested outcome, acceptance criteria and important non-goals.
6. Identify security, data, compatibility and deployment risks.
7. Plan a small, reversible change.

An agent MUST NOT claim completion merely because code was generated. Report the **Definition of Done** evidence and human-accepted exceptions accurately.

## Core engineering defaults

Apply these defaults to every project unless a responsible human chooses an exception as described above:

1. Understand before changing.
2. Preserve existing user work and working behaviour.
3. Prefer the simplest maintainable solution.
4. Make small, focused and reversible changes.
5. Keep code readable by a competent human developer.
6. Validate all untrusted input at system boundaries.
7. Enforce authentication and authorization on the server or trusted boundary.
8. Never commit or expose secrets.
9. Add or update tests when behaviour changes.
10. Run relevant tests, type checks, linting and builds.
11. Keep database changes explicit, reviewed and recoverable.
12. Make failures visible and actionable.
13. Keep important changes traceable to their requirement or issue.
14. Make user interfaces usable, responsive and accessible.
15. Do not perform destructive production actions without explicit authorization.
16. Do not declare success without verification evidence.

## 1. Product requirements and traceability

### 1.1 Product truth

- Each change MUST have a clear user or operational outcome.
- Important work MUST state acceptance criteria before implementation.
- Assumptions, constraints and non-goals SHOULD be recorded.
- Existing behaviour MUST be inspected rather than guessed.
- If ambiguity materially affects behaviour, security, cost or irreversible design, the contributor MUST ask for a decision.
- Routine implementation details SHOULD be resolved autonomously from repository evidence and established conventions.

### 1.2 Traceability chain

Significant work MUST be traceable through:

```text
Requirement or issue
        -> design decision when needed
        -> branch, commit or pull request
        -> implementation
        -> tests and verification
        -> release or deployment
```

- Pull requests or change reports SHOULD link to the relevant issue or requirement.
- Tests SHOULD identify the behaviour or regression they protect.
- Important production deployments SHOULD identify the exact commit or release.
- A change report MUST distinguish implemented, verified, deferred and blocked work.

## 2. Change management and Git

- Inspect Git status before editing.
- Preserve unrelated and uncommitted user changes.
- One change SHOULD address one coherent concern.
- Refactoring SHOULD be separated from behavioural changes when practical.
- Large work MUST be divided into deployable, reviewable increments.
- Each meaningful commit SHOULD build and pass its relevant checks.
- Shared history MUST NOT be rewritten without explicit authorization.
- Generated files and dependency lockfiles MUST be reviewed when they change.
- Commits SHOULD follow Conventional Commits:

```text
feat(scope): add capability
fix(scope): correct behaviour
refactor(scope): restructure without intended behaviour change
test(scope): add or repair tests
docs(scope): update documentation
chore(scope): maintenance
```

- Breaking changes MUST be clearly identified.
- Releases SHOULD use Semantic Versioning when the product has public versions or consumers.
- Every repository MUST have a `.gitignore` appropriate to its stack.
- Credentials, runtime data, database dumps and local environment files MUST NOT be committed.

## 3. Clean Code and human readability

Code MUST be written primarily for humans to understand and safely change.

- Use names that communicate intent and domain meaning.
- Keep functions, classes and modules focused on one responsibility.
- Prefer straightforward control flow over clever or compressed code.
- Make side effects explicit.
- Avoid unexplained global state.
- Use types, schemas or contracts where supported.
- Handle errors explicitly; never silently swallow them.
- Avoid unnecessary duplication, but do not create premature abstractions.
- Comments MUST explain why, constraints or non-obvious decisions—not restate syntax.
- Public APIs and complex behaviour SHOULD have concise documentation.
- Replace magic values with named constants or configuration when meaning matters.
- Remove dead code, obsolete feature flags, debugging output and unused dependencies.
- TODO comments MUST include a reason or linked work item when they represent real deferred work.
- Formatting and lint rules MUST be automated rather than debated repeatedly.
- A new contributor SHOULD be able to locate the entry point, business logic, data access and tests without reverse engineering the entire repository.

## 4. Architecture and dependency control

### 4.1 Default architecture

- Prefer a modular monolith unless separate services solve a demonstrated scaling, isolation, deployment or ownership problem.
- Organise substantial systems by business capability or feature.
- Keep business rules independent from UI frameworks, databases and external providers where the separation provides real value.
- Dependencies SHOULD point toward stable business rules.
- Infrastructure MAY depend on application and domain contracts; domain logic MUST NOT depend on infrastructure.

Example:

```text
presentation -> application -> domain
                       ^
                       |
                infrastructure adapter
```

### 4.2 Practical boundaries

- UI and transport handlers SHOULD validate input and invoke application behaviour.
- Core business rules SHOULD NOT live inside UI components, route handlers or database queries.
- Database and external-service access SHOULD be isolated behind focused modules or adapters.
- Do not create an interface, factory, service or repository merely to satisfy a pattern.
- Trivial features MAY remain simple when they contain no important business rules or replaceable boundaries.
- Cross-module access SHOULD use an intentional public interface.
- Circular dependencies MUST be removed.
- Significant architecture decisions MUST be recorded as Architecture Decision Records (ADRs).

## 5. Testing and quality strategy

Testing MUST be proportional to risk, not performed only to increase coverage numbers.

### 5.1 Required test layers

- Unit tests SHOULD cover important rules, calculations and edge cases.
- Integration tests SHOULD cover databases, queues, filesystems and external-service adapters.
- End-to-end tests SHOULD cover the smallest set of critical user journeys.
- A bug fix MUST include a regression test when reasonably possible.
- Refactoring MUST be protected by existing or newly added tests.

### 5.2 Test quality

- Tests MUST be deterministic, isolated and repeatable.
- Tests MUST NOT depend unnecessarily on execution order, live production data or uncontrolled external services.
- Test names SHOULD describe behaviour and expected outcome.
- Tests SHOULD verify externally meaningful behaviour rather than private implementation details.
- Flaky tests MUST be fixed or quarantined with a tracked reason; they MUST NOT be routinely ignored.
- Test fixtures MUST NOT contain real secrets or sensitive production data.
- Coverage MAY inform risk analysis but MUST NOT replace thoughtful testing.

### 5.3 Automated quality gates

Use relevant automated checks where supported. Projects may enforce them in branch settings, but a responsible human may consciously ship with an unmet engineering check and record what remains unverified. Suggested checks:

- Formatting or linting.
- Type checking or compilation.
- Automated tests.
- Build or packaging.
- Security and dependency scanning.
- Migration validation when database changes exist.
- Accessibility checks when UI changes exist.

## 6. Security baseline

Security MUST be designed into development rather than added only before release.

- Apply secure defaults and least privilege.
- Authenticate identities and authorize every protected action at the trusted boundary.
- Never rely solely on hiding UI controls for authorization.
- Validate untrusted input using allowlists, schemas and size limits where practical.
- Use parameterized database queries.
- Encode output for its destination context.
- Protect browser applications against relevant injection, request-forgery and cross-origin risks.
- Use secure session, cookie and token settings.
- Rate-limit sensitive or abuse-prone operations.
- Do not log passwords, secret tokens, private keys or complete sensitive payloads.
- Store secrets using the platform's secret-management mechanism, never source control.
- A trusted, authenticated web form that writes directly to a server-side secret store is an acceptable way for a human to provide a credential. Where an agent must read or use a credential, choose that access deliberately and prefer scoped credentials; do not impose a paid vault or an SSH-only entry process.
- Use maintained cryptographic libraries; do not invent cryptographic protocols.
- Dependencies MUST be reviewed, minimized and monitored for vulnerabilities.
- Security controls MUST NOT be disabled merely to make a test pass.
- A proportionate threat assessment SHOULD be performed for authentication, payments, uploads, external integrations, admin functions and sensitive data.
- Internet-facing web applications SHOULD use an applicable subset of OWASP ASVS.
- Security findings MUST include severity, affected scope, evidence and remediation status.

## 7. Data and database safety

- Collect and retain only data that the product genuinely needs.
- The purpose, owner, sensitivity and retention of important data SHOULD be documented.
- Access to sensitive data MUST follow least privilege.
- Sensitive values SHOULD be redacted or omitted from logs, analytics, test fixtures and support exports.
- Data sent to external services, including AI providers, MUST be limited to what the operation requires.
- Export, correction and deletion behaviour SHOULD be designed deliberately when users create or own data.
- Analytics and telemetry SHOULD avoid identifying users unless identification is necessary and disclosed by the product.
- Data ownership and lifecycle MUST be understood before storage is designed.
- Database constraints SHOULD enforce important invariants in addition to application checks.
- Related changes requiring atomicity MUST use transactions.
- Schema changes MUST use versioned migrations.
- Applied migrations MUST NOT be edited silently; use a new corrective migration.
- Production migrations MUST be reviewed for locking, duration, compatibility and rollback or forward-recovery strategy.
- Backups MUST exist before destructive or high-risk migrations.
- Backups are not considered reliable until restoration is tested.
- Deletion, archival and retention behaviour MUST be explicit.
- For valuable business records, default to reversible deletion where retention allows it. Automatically record material creations, edits and deletions with time, affected record IDs/count, actor and human sponsor for an agent action, and a request or job identifier. Capture enough history to investigate and recover a mistake without placing passwords or unnecessary personal data in logs. An application event log should be complemented by database-level coverage for relevant direct SQL, bulk operations and schema changes where feasible.
- Keep audit history difficult for ordinary app/deployment roles to alter, retain or export a protected copy off the VPS, and alert on unusual bulk deletion. Test a deletion and recovery path. Audit history reveals what happened; backups or retained versions recover the values. If the project's recovery objective needs a point between snapshots, evaluate database point-in-time recovery.
- Time MUST be stored with an unambiguous timezone strategy, normally UTC internally.
- Units, currencies and precision MUST be explicit.
- Identifiers MUST remain stable and must not expose avoidable internal information.
- Development and test environments MUST NOT use sensitive production data unless it is properly minimized and sanitized.
- Import, migration and background jobs SHOULD be resumable and idempotent.

## 8. APIs and external integrations

- API contracts MUST be explicit and consistently validated.
- Public or shared APIs MUST have a compatibility and versioning strategy.
- Error responses SHOULD be stable, structured and useful without exposing internals.
- Network calls MUST use explicit timeouts.
- Retries MUST be limited, use backoff and apply only to safe or idempotent operations.
- Operations vulnerable to duplication SHOULD support idempotency keys or equivalent protection.
- List endpoints SHOULD support bounded pagination.
- Rate limits and provider quotas MUST be handled deliberately.
- External-provider failures SHOULD degrade gracefully where possible.
- Provider-specific code SHOULD remain inside an adapter when replacement is a realistic requirement.
- Webhooks MUST be authenticated, validated, replay-resistant where necessary and safely repeatable.
- Correlation or request identifiers SHOULD connect related events across boundaries.
- Integrations MUST have test doubles or sandbox strategies; automated tests MUST NOT accidentally call paid or production services.

## 9. UI, UX and ease of use

This section is mandatory for products with a user interface.

### 9.1 User-centred design

- Design decisions MUST begin with identified user needs and important tasks.
- The interface SHOULD prioritize the user's most common and consequential actions.
- Use familiar patterns and existing design-system components before inventing new ones.
- Navigation, labels and actions MUST use clear, consistent language.
- Every screen SHOULD make its purpose and next available actions understandable.
- Complexity SHOULD be progressively disclosed rather than presented all at once.
- Destructive actions MUST be clearly identified and protected by confirmation, undo or another proportionate safeguard.
- Users MUST receive meaningful feedback after actions.
- Forms SHOULD prevent errors where possible and explain how to correct them.
- Error messages MUST be specific, respectful and actionable.
- Do not use dark patterns, misleading defaults or forced urgency.
- User testing SHOULD be performed for important workflows; agent assumptions are not evidence of usability.

### 9.2 Required interface states

Interactive features MUST deliberately handle:

- Initial state.
- Loading state.
- Empty state.
- Success state.
- Validation state.
- Recoverable error state.
- Permission-denied state.
- Offline or degraded state where relevant.

### 9.3 Responsive behaviour

- Interfaces MUST adapt to relevant mobile, tablet and desktop sizes.
- Content MUST remain usable without horizontal scrolling except where the content inherently requires it.
- Touch targets MUST be usable on touch devices.
- Important actions MUST remain discoverable on small screens.
- Tables and dense data views MUST have an intentional small-screen strategy.
- Layouts SHOULD be tested on real or accurately emulated devices, not only by resizing a desktop browser.
- Orientation changes, zoom and long translated text MUST NOT break essential workflows.

### 9.4 Design-system discipline

- Use shared design tokens for colour, spacing, typography, radius, elevation and motion.
- Reuse accessible components rather than copying similar markup repeatedly.
- Components MUST document supported variants and states.
- Visual consistency MUST NOT override clarity or accessibility.
- Dark and light themes, when supported, MUST preserve contrast and meaning.
- Meaning MUST NOT depend on colour alone.

## 10. Accessibility

User-facing web applications SHOULD target **WCAG 2.2 Level AA** unless a stricter project profile applies.

- Use semantic HTML or equivalent native platform semantics.
- All functionality MUST be operable by keyboard where the platform supports keyboard input.
- Focus order and visible focus MUST be logical.
- Form fields MUST have programmatically associated labels and understandable errors.
- Images with meaning MUST have useful alternatives; decorative images SHOULD be ignored by assistive technology.
- Text and interactive controls MUST meet required colour contrast.
- Interfaces MUST support text resizing and reflow.
- Headings and landmarks MUST reflect the content structure.
- Dynamic changes SHOULD be announced appropriately to assistive technology.
- Captions or transcripts MUST be provided for meaningful media where applicable.
- Motion SHOULD respect reduced-motion preferences.
- Accessibility MUST be tested with automated tools and manual keyboard checks; automation alone is insufficient.
- Critical journeys SHOULD receive screen-reader testing.

## 11. Performance and efficiency

- Performance work MUST begin with measurement.
- Establish budgets for important user journeys where performance matters.
- Avoid unbounded queries, responses, loops, queues and memory growth.
- Large datasets MUST use pagination, streaming, batching or virtualization as appropriate.
- Avoid database N+1 patterns and unnecessary repeated network calls.
- Cache only when ownership, invalidation and failure behaviour are understood.
- Web applications SHOULD monitor Core Web Vitals or equivalent user-centred measures.
- Assets SHOULD be appropriately sized, compressed and cached.
- Background work SHOULD be separated from interactive requests when it would block the user.
- Do not sacrifice correctness, accessibility or maintainability for unmeasured micro-optimisation.
- Cost is a performance dimension: paid API, model, storage and compute use SHOULD be observable and bounded.

## 12. Reliability, observability and failure handling

- Applications MUST expose meaningful health or readiness checks where operationally relevant.
- Logs SHOULD be structured, timestamped and include correlation identifiers.
- Logs MUST provide diagnostic value without exposing secrets or unnecessary sensitive data.
- For systems holding valuable records, distinguish operational logs from an automatically recorded change/audit history. A note in Obsidian may summarize an incident but is not the authoritative audit trail.
- Important systems SHOULD produce suitable metrics, logs and traces.
- Monitor user-visible failures, latency, traffic and resource saturation.
- Alerts MUST be actionable and tied to a documented response.
- Expected failures MUST produce controlled behaviour rather than crashes or corrupted state.
- Critical external calls SHOULD use timeouts and proportionate resilience patterns.
- Background jobs SHOULD record state, attempts and terminal failure.
- Systems SHOULD fail safely and support graceful degradation where possible.
- Important services MUST have restart, recovery and troubleshooting instructions.
- Significant incidents SHOULD produce a blameless record of impact, cause, recovery and preventive action.

## 13. Deployment, configuration and rollback

- Build and deployment processes SHOULD be automated and repeatable.
- The deployed version MUST be identifiable by commit or release.
- Runtime configuration MUST be separated from code.
- Secrets MUST be injected securely and must not appear in images, repositories or build logs.
- Development, test and production environments MUST be clearly distinguished.
- Deployments MUST run relevant pre-deployment checks.
- Deployments SHOULD include automated health checks and critical smoke tests.
- High-risk changes SHOULD use staged rollout, feature flags or another controlled-release method.
- Every material release MUST have a practical rollback or forward-recovery plan.
- A rollback MUST account for database compatibility.
- Manual production changes MUST be minimized and documented.
- Deployment success means the intended user journey works—not merely that a process is running.

## 14. Dependencies and software supply chain

- Add dependencies only when their value exceeds their maintenance and security cost.
- Prefer actively maintained, appropriately licensed and well-understood dependencies.
- Lock dependency versions using the ecosystem's supported lock mechanism.
- Automated dependency updates SHOULD be enabled with tests and review.
- Remove unused dependencies.
- Build and CI workflows MUST use least-privilege permissions.
- Third-party actions and build tools SHOULD be version-pinned where practical.
- Repositories SHOULD use secret scanning, dependency scanning and static analysis appropriate to their risk.
- OpenSSF Scorecard checks MAY be used to assess repository and dependency hygiene.
- SLSA provenance and signed release practices SHOULD be considered for distributed or high-assurance software.

## 15. Documentation and decision records

Every maintained project MUST document:

- What the software does and who it serves.
- How to install and run it.
- Required configuration without secret values.
- How to test, build and deploy it.
- Repository structure and important module boundaries.
- Data stores and external integrations.
- Backup, restore and rollback procedures where relevant.
- Common failure modes and troubleshooting steps.

Additional rules:

- Documentation MUST change with the behaviour it describes.
- Important, long-lived technical decisions MUST use ADRs recording context, decision, alternatives and consequences.
- Prefer one authoritative source for each fact; link to it instead of copying stale values.
- Diagrams SHOULD be used when relationships or flows are materially clearer visually.
- Generated documentation MUST be reproducible.
- Instructions MUST be executable and periodically verified.

## 16. AI coding-agent conduct

These rules apply to every AI agent and coding tool.

### 16.1 Before acting

- Read the applicable instructions and project profile.
- Inspect existing code and documentation before proposing replacements.
- Check Git status and preserve unrelated work.
- Confirm actual command, API and dependency behaviour from local evidence or primary documentation when uncertain.
- State material assumptions.

### 16.2 While working

- One agent or process MUST own a task at a time unless work is explicitly divided.
- Agents MUST NOT duplicate work or enter approval loops with other agents.
- Recommend applicable defaults and flag material risks once. Follow a responsible human's engineering exception within their existing authority, note material consequences briefly, and never silently reverse the decision or falsify evidence.
- Use the least costly model and tool capable of completing the task reliably.
- Token, time and paid-service use SHOULD be bounded.
- Prefer targeted inspection over repeatedly loading entire repositories or histories.
- Do not invent APIs, commands, tests, files or successful results.
- Do not weaken tests, validation or security controls simply to produce a green result.
- Do not make unrelated improvements without authorization.
- Do not expose authentication credentials in prompts, logs, commits or reports. The owner permits private code and customer data with any AI provider for team work; avoid irrelevant material and honor applicable customer and legal duties.
- Destructive operations, production data changes, payments, external communications and expanded permissions require explicit authorization unless already clearly granted for the task.

### 16.3 Completion reporting

Agent reports MUST separate:

- What changed.
- What was verified and by which commands or evidence.
- What was not verified.
- Known risks or limitations.
- Deployment status.
- Commit, branch or pull-request references when available.
- Decisions still requiring human input.
- If production records were created, changed or deleted: affected entity/record IDs and counts (where permitted), the audit-event or job reference, and anything that could not be verified. A policy instruction is not a substitute for automatic server/database audit events.

An agent MUST NOT describe planned, attempted or partially completed work as complete.

## 17. Definition of Done

A change fully meets this standard when all applicable items are satisfied. A responsible human may release with a disclosed exception within their authority; report skipped checks and call the release "shipped with an exception" rather than "fully verified":

### Requirements

- [ ] Acceptance criteria are met.
- [ ] Important assumptions and non-goals are recorded.
- [ ] The change is linked to its issue or requirement where applicable.

### Implementation

- [ ] Code follows project structure and this standard.
- [ ] The change is focused and contains no unexplained unrelated edits.
- [ ] Error, loading, empty and permission states are handled where relevant.
- [ ] Documentation is updated.

### Quality

- [ ] Relevant automated tests pass.
- [ ] Regression tests were added for corrected defects where practical.
- [ ] Formatting, linting, type checking and build pass.
- [ ] No debugging output, dead code or unexplained TODOs remain.

### Security and data

- [ ] Input validation and authorization were reviewed.
- [ ] No secrets or sensitive data were added to code, fixtures or logs.
- [ ] Dependencies and security findings were reviewed.
- [ ] Database migrations and recovery implications were reviewed.
- [ ] For valuable records, change/deletion history and recovery were checked when the change affects them.

### UI and accessibility

- [ ] Critical workflows were tested at relevant screen sizes.
- [ ] Keyboard operation, focus, labels and contrast were checked.
- [ ] Required states and actionable error messages were verified.

### Deployment

- [ ] Deployment or packaging succeeded where requested.
- [ ] Health checks and critical smoke tests passed.
- [ ] The deployed revision is identifiable.
- [ ] Rollback or forward recovery is understood.

Report any unchecked applicable item honestly, including when a human elected to ship with that exception. Do not describe work or tests as verified when they were not.

## 18. Project profiles

The universal core applies everywhere. Each repository MUST select only the profiles relevant to it.

### 18.1 Web application profile

Adds:

- WCAG 2.2 AA target.
- Responsive mobile, tablet and desktop verification.
- Browser compatibility target.
- Core Web Vitals or equivalent performance monitoring.
- Secure headers, cookies, CORS and request-forgery protection.
- End-to-end tests for critical journeys.

### 18.2 Mobile application profile

Adds:

- Supported OS and device versions.
- Platform accessibility semantics.
- Offline and interrupted-network behaviour.
- Permission minimization.
- Deep-link and notification validation.
- Store-release and rollback strategy.

### 18.3 API or backend profile

Adds:

- Versioned contracts and machine-readable schema where practical.
- Authentication, authorization and rate limits.
- Idempotency and replay handling.
- Bounded pagination and request sizes.
- Integration, load and failure-path testing.

### 18.4 Database-heavy profile

Adds:

- Schema ownership and documented invariants.
- Migration rehearsal and recovery plan.
- Transaction and concurrency testing.
- Backup and restore verification.
- Change/deletion audit and recovery checks for valuable records.
- Query plans and performance checks for critical paths.

### 18.5 Realtime, IoT, telemetry or vehicle-tracking profile

Adds:

- Device identity and authentication.
- Timestamp, timezone, sequence and unit definitions.
- Duplicate, delayed, missing and out-of-order event handling.
- Offline buffering and reconnection behaviour.
- Accuracy, freshness and confidence representation.
- Retention and aggregation rules for high-volume telemetry.
- Geofence edge-case and false-alert testing where applicable.
- Explicit degraded behaviour when devices or networks fail.

### 18.6 AI-enabled software profile

Adds:

- Model purpose, cost and data-access boundaries.
- Versioned prompts and model configuration.
- Evaluation cases for quality and regression.
- Clear separation between deterministic rules and model judgement.
- Structured output validation.
- Protection against prompt injection and unsafe tool use.
- Human review for high-impact actions.
- Usage, latency and cost monitoring.
- Provider fallback that does not silently reduce safety or correctness.

### 18.7 Multi-tenant software profile

Adds:

- Explicit tenant ownership for data and operations.
- Server-side tenant isolation.
- Cross-tenant access tests.
- Tenant-aware caching, jobs, files, logs and search.
- Auditing for privileged or sensitive actions.

### 18.8 CLI, automation or background-worker profile

Adds:

- Idempotent and resumable execution where practical.
- Clear exit codes and machine-readable output modes.
- Dry-run support for destructive or broad operations.
- Bounded retries and concurrency.
- Locking or duplicate-execution protection.
- Audit logs for material actions.

## 19. Minimum project adoption file

Every repository SHOULD contain a short `AGENTS.md` or equivalent file similar to:

```markdown
# Project Instructions

This repository adopts Universal Software Engineering Standard version 2.0.

## Active profiles
- Web application
- API/backend

## Product purpose
[What the software does and who it serves]

## Important commands
- Install: `[command]`
- Develop: `[command]`
- Test: `[command]`
- Type-check: `[command]`
- Lint: `[command]`
- Build: `[command]`
- Smoke test: `[command]`

## Architecture
[Important modules and dependency rules]

## Deployment
[Target environment and safe deployment command]

## Project-specific MUST rules
[Only rules genuinely specific to this repository]

## Material human decisions and exceptions
[Default, decision maker, affected scope and likely consequence, if material]
```

The detailed standard MUST live in version control. A chat message or an agent's memory is not the authoritative copy.

## 20. Standard governance

- This standard MUST be versioned and maintain a changelog.
- Changes to the published policy's `MUST` or `MUST NOT` rules require Ulaş's approval through the policy repository's PR process. This differs from a human developer's task-specific engineering exception.
- Agents MAY propose changes through an issue or pull request with evidence, expected benefit and compatibility impact.
- Agents MUST NOT silently change mandatory policy.
- Rules SHOULD remain technology-neutral unless placed in a project profile.
- Duplicated or conflicting rules MUST be consolidated.
- Rules that cannot be understood or verified SHOULD be rewritten or removed.
- The standard SHOULD be reviewed periodically and after significant failures.
- New rules SHOULD address a repeated risk or measurable need, not one isolated preference.

## 21. Reference standards

This standard is a practical synthesis. When deeper guidance is required, consult the current version of the relevant primary source:

- AGENTS.md: <https://github.com/agentsmd/agents.md>
- NIST Secure Software Development Framework: <https://csrc.nist.gov/pubs/sp/800/218/final>
- OWASP Application Security Verification Standard: <https://github.com/OWASP/ASVS>
- OWASP Software Assurance Maturity Model: <https://owasp.org/projects/samm>
- OWASP AI Agent Security Cheat Sheet: <https://cheatsheetseries.owasp.org/cheatsheets/AI_Agent_Security_Cheat_Sheet.html>
- OpenSSF Scorecard: <https://github.com/ossf/scorecard>
- SLSA software supply-chain framework: <https://github.com/slsa-framework/slsa>
- WCAG 2.2 quick reference: <https://www.w3.org/WAI/WCAG22/quickref/>
- U.S. Web Design System principles: <https://designsystem.digital.gov/design-principles/>
- Microsoft REST API Guidelines: <https://github.com/microsoft/api-guidelines>
- Google engineering practices archive: <https://github.com/google/eng-practices>
- DORA software-delivery capabilities: <https://dora.dev/capabilities/>
- Google Site Reliability Engineering: <https://sre.google/sre-book/>
- OpenTelemetry: <https://opentelemetry.io/docs/>
- Conventional Commits: <https://www.conventionalcommits.org/>
- Semantic Versioning: <https://semver.org/>
- Architecture Decision Records: <https://github.com/joelparkerhenderson/architecture-decision-record>

## Final operating instruction

Apply this standard with judgement. Build the smallest solution that satisfies the real requirement while remaining secure, testable, accessible, understandable, traceable and recoverable.

The goal is not maximum process. The goal is dependable software and evidence that it works.
