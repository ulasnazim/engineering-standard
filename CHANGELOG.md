# Changelog

Versioning: bundle `MAJOR.MINOR.PATCH`. MAJOR = a MUST/MUST NOT rule added, removed or changed (owner approval required). MINOR = new guidance, templates or tools. PATCH = wording and fixes.

## 3.0.0 (2026-09-23)

- Owner-directed change: remove the mandatory VPS backup archive, Google Drive upload, retention and restore schedule. Ulaş manages backups through Hostinger outside this repository; product audit history, reversible deletion and safe production-change decisions remain.
- Make this repository the top-level team policy. Other playbooks define narrower agent workflows; project `AGENTS.md` records local facts, adopted version and applicable profiles. Agents flag conflicts instead of silently replacing the approved policy.
- Add CI for policy links/version consistency and both installers. After CI passes on `main`, CD publishes a versioned GitHub Release with a clean ZIP of tracked policy files. No workflow connects to the VPS.

Historical entries below describe the policy as it existed at that version; the v3.0.0 rules supersede them.

## 2.0.0 (2026-09-23)

- Owner-approved engineering defaults permit a responsible human developer to make task-specific exceptions without a separate reviewer or technical approval gate; agents flag material risks once and report skipped checks honestly.
- OpenClaw Settings → Secrets is documented as a convenient credential entry path. Protected and agent-readable entries are both allowed by informed human choice; the shared store's unencrypted-at-rest limitation and backup implications are explicit.
- Added an implementation brief for automated, dated, encrypted single-file VPS backups to Ulaş's Google Drive, automatic failure/integrity checks and isolated restore verification. Publication of this policy does not implement the job on the VPS.
- Added data-change recovery guidance for reversible deletion, automatic audit history (including agent/human attribution), bulk-delete alerts, offsite audit retention and tested recovery. Obsidian is optional for summaries, not the authoritative audit store.
- Made the PR template a short relevant self-review prompt and refreshed agent instructions and owner setup guidance.

## 1.0.0 (2026-09-23, initial release)

- Universal Software Engineering Standard 1.0 included as the general quality baseline.
- Team Development Operating Policy 1.0 records the owner's decisions: GitHub repositories and service accounts controlled by Ulaş Nazım; any human team member may deploy completed work; private code and customer data may be sent to any AI provider; one dated encrypted file per VPS backup run is retained in Ulaş's Google Drive.
- Project adoption through a short `AGENT_BOOTSTRAP.md`, repo-specific `AGENTS.md` template, `MODELS.md` for measurable spending, and optional installer instructions for supported local tools.
- Added a root `AGENTS.md` so contributors know how to review and verify changes to this policy repository.
- Optional Claude helper agents remain examples and are not copied to users' global agent directories by the installer.
- No existing Git history from the uploaded ZIP is intended to be published with the clean repository files.
