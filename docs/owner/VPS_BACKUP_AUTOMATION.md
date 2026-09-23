# VPS backup automation: implementation brief

This is a build brief for the real VPS operator, not evidence that a backup job is running. Inspect the current VPS, databases, container volumes, uploads, OpenClaw state and Google Drive destination before choosing commands or scheduling a job. Do not put credentials or a decryption key in this public repository.

## Desired result

- At each scheduled run, produce **one dated encrypted archive file** with a manifest and hashes for the included database-consistent exports, uploads, necessary configuration and other selected persistent data. Retain multiple recovery points in a folder controlled by Ulaş in Google Drive. The encryption key must remain recoverable by Ulaş separately from the VPS and the Drive files. Record the archive name, time, encrypted checksum and destination.
- Make the job fail visibly if an export, encryption, upload or remote verification fails. Check the most recent successful archive's age, Drive quota and dated retention automatically; alert Ulaş on failure or staleness. Prevent overlapping jobs and avoid leaving readable temporary exports behind.
- On a schedule, download an actual remote archive, verify its encrypted checksum, decrypt it in a restricted temporary location and check the internal manifest. An untested local copy is not enough.
- At least monthly, restore a downloaded archive into an isolated test environment when practical. Check that the database opens and a representative application record or critical user path works. Never overwrite production during a drill. Keep a concise success/failure record and notify on failure. If an isolated restore cannot yet be automated, track the manual drill and its result; do not label a checksum check a full restore.
- Choose backup frequency, retention and whether PostgreSQL base backups plus archived WAL are needed from the project's maximum acceptable data loss. A single daily SQL dump cannot restore the minute before an afternoon deletion. For WAL-based recovery, test the base-backup/WAL chain; `pg_dump` alone is not a base backup for that purpose. Periodic WAL batches may be packaged into their own dated encrypted archive per run.

## Before declaring it operational

1. Inventory and list exactly which services, data stores, volumes and configuration files the job captures. Test consistent snapshots, not copies of a live database directory made without a database-aware method.
2. Document the backup identity's access to Drive, local storage limits, a second way for Ulaş to recover the decryption key, and how the VPS is rebuilt after disk loss.
3. Run one end-to-end upload and one isolated restore. Record the date, duration, test outcome, data gaps and how alerts reach the owner.
4. Monitor scheduled results. If a drill or upload fails, retain earlier recovery points and report the failure; do not silently mark the system protected.

Keep this mechanism unattended in routine operation. A human developer may change the approach within their authority, recording material recovery consequences briefly. Publishing this brief does not configure the VPS or connect Google Drive.

References: [PostgreSQL continuous archiving](https://www.postgresql.org/docs/current/continuous-archiving.html), [OWASP backup recovery guidance](https://cornucopia.owasp.org/cards/DVO6).
