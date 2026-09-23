# Owner Setup Checklist

For the project owner. Agents do not need to read this file.

## Once
- [ ] Ulaş retains ownership and recovery access to his `ulasnazim` GitHub account, repositories, Cloudflare account, VPS account and Google Drive backup folder. Enforce MFA for team accounts and document how to revoke access after a departure.
- [ ] Publish this repository privately as `ulasnazim/engineering-standard` (without the ZIP's embedded `.git` folder). Select GitHub Pro or another compatible paid plan if enforced branch protection is required for a private personal repository; on Free, follow the PR/checks process manually.
- [ ] Approve the initial policies and `MODELS.md`; fill in the per-person and per-issue spending budgets before paid automations run.
- [ ] Developer/contractor agreements: IP assignment including AI-assisted output, confidentiality, AI-tool and open-source clauses. Check the KKTC default rules on who owns software written by employees and contractors; rely on an express assignment either way.
- [ ] Cloudflare domain registration and DNS in Ulaş's account, with MFA and recoverable owner access.
- [ ] VPS inventory (CPU, RAM, disk, services including OpenClaw, open ports). Configure **one encrypted file per backup run in Ulaş's Google Drive** with dated retention, key recovery, quota and upload monitoring; complete a full test restore. Document what must be rebuilt rather than restored from the archive.
- [ ] Every developer runs the installer: `bash install/install.sh` (macOS/Linux) or `.\install\install.ps1` (Windows).

## Per new project (no editing required)
1. Create a private repository under `ulasnazim`, retaining Ulaş's administrator access and individually assigned collaborator accounts.
2. Open any AI coding tool in it and give the task. The bootstrap makes the agent generate `AGENTS.md` and a gap report as its first PR.
3. The technical lead or project owner reviews the adoption PR, then configures CI and any private-repository branch protection available on the owner's GitHub plan. Any team member may deploy after the DoD.

## Recurring
- Monthly: AI spend per accepted issue; backup restore test; access review.
- Quarterly: `MODELS.md`; policy review.
- After each policy release: developers re-run the installer.
