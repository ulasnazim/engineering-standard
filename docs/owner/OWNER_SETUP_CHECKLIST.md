# Owner Setup Checklist

For the project owner. Agents do not need to read this file.

## Once
- [ ] Ulaş retains ownership and recovery access to his `ulasnazim` GitHub account, repositories, Cloudflare account, VPS account and Google Drive backup folder. Enforce MFA for team accounts and document how to revoke access after a departure.
- [x] Publish this repository as `ulasnazim/engineering-standard` (public by Ulaş's decision). Use helpful branch checks without imposing a mandatory second human reviewer. Policy changes still require Ulaş's approval.
- [ ] Approve the initial policies and `MODELS.md`; fill in the per-person and per-issue spending budgets before paid automations run.
- [ ] Developer/contractor agreements: IP assignment including AI-assisted output, confidentiality, AI-tool and open-source clauses. Check the KKTC default rules on who owns software written by employees and contractors; rely on an express assignment either way.
- [ ] Cloudflare domain registration and DNS in Ulaş's account, with MFA and recoverable owner access.
- [ ] VPS inventory (CPU, RAM, disk, services including OpenClaw, open ports). Implement [the backup brief](VPS_BACKUP_AUTOMATION.md): automate **one encrypted file per backup run in Ulaş's Google Drive**, dated retention, key recovery, integrity/quota monitoring and an isolated restore where practical. Document what must be rebuilt.
- [ ] Every developer runs the installer: `bash install/install.sh` (macOS/Linux) or `.\install\install.ps1` (Windows).

## Per new project (no editing required)
1. Create a private repository under `ulasnazim`, retaining Ulaş's administrator access and individually assigned collaborator accounts.
2. Open any AI coding tool in it and give the task. The bootstrap makes the agent generate `AGENTS.md` and a gap report as its first PR.
3. A human reviews the adoption PR when useful; configure proportionate CI without a universal second-review gate. Any team member may deploy within existing authority, noting material engineering exceptions briefly.
4. Where the product stores valuable business records, implement [automatic audit and recovery](../DATA_CHANGE_RECOVERY.md) as part of that product. The policy repository alone does not turn on database logging.

## Recurring
- Monthly: AI spend per accepted issue; check automated backup and isolated restore results; access review.
- Quarterly: `MODELS.md`; policy review.
- After each policy release: developers re-run the installer.
