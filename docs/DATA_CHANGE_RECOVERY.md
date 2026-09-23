# Valuable records: change history and recovery

Use this guide for products such as a CRM that store records a user would notice losing. Adapt the design to the actual database, retention duties and the human developer's risk decision. This policy repository does not change any running product.

## A practical default

1. Make ordinary user deletion reversible where lawful and appropriate: mark the record deleted, show a restricted "Recently deleted" view and provide a tested restore path. Define how long records stay recoverable and how related rows/files are handled. If hard deletion is required, tell the owner what cannot be restored through the product and agree the risk before the change.
2. Automatically write a change event for relevant create, update, delete, restore and bulk operations. Include event time, product/tenant, object type, record ID, operation, affected row count, authenticated actor, sponsoring human for an agent action, and request/job/release reference. Keep the event in the same transaction as the business change when feasible. Do not require a developer to type each event manually.
3. For changes outside the application (scripts, agent jobs, direct SQL and migrations), include database-level audit/trigger coverage or an equivalent mechanism. A normal application log can miss direct SQL. Check whether the chosen method also covers bulk `TRUNCATE`, schema changes and actions by privileged roles. If every process shares a database login, database logs alone may not reveal which human acted; pass verified request identity through the application or use distinguishable operator accounts.
4. Allow the owner to see which records changed and to investigate a bulk deletion. Alert on unexpected high counts; choose thresholds for the product so routine maintenance does not cause noise.
5. Keep audit events difficult for the ordinary app role to erase. A database administrator or agent with root-equivalent access could still disable local logging; describe that limitation honestly. Restrict access to any before/after values and never log passwords, tokens or unnecessary personal data. Inform the owner where audit data lives for their Hostinger backup decisions.
6. Verify with a small real test: create, edit, delete and restore a test record; identify its actor, count and request ID; exercise a bulk operation and check its alert. If an application cannot restore a deleted record, state that limit and defer to the owner-selected recovery approach; do not claim that logging by itself restores data.

Example: if an agent deletes 30 contacts, the record history shows the actor, sponsoring human, affected IDs, count and time; an alert draws attention to the bulk action; the contacts can be restored from the product's reversible-delete area if that path was implemented and tested. A summary in Obsidian is optional and is not the audit source.

Human developers can select a lighter design for a lower-risk product. A material decision that weakens recovery or attribution gets a short risk note, not a new approval committee. Owner account authority, legal duties and truthful reporting still apply.

References: [OWASP logging guidance](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html), [pgAudit](https://github.com/pgaudit/pgaudit).
