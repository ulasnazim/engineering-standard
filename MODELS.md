# Model Choices and Spending

**Owner:** Ulaş Nazım. The technical lead keeps the examples current and reviews results quarterly. This file records preferences; it does **not** limit which AI provider may receive private code or customer data. See Policy §6. Never submit authentication secrets or keys.

## Choosing a model

Choose the least expensive **reliable** model for a bounded task. Compare total spending, time to accepted PR, retries, human corrections and final quality on the same real issue. An inexpensive model that needs repeated rescue may cost more overall. Use deterministic tests, formatters and builds instead of model calls for checks.

| Task | Default experiment | Escalate when |
| --- | --- | --- |
| Architecture, unclear requirements, difficult debugging | A stronger reasoning model for one scoped plan | The design has multiple important trade-offs. |
| Small, well-specified implementation and tests | A lower-cost coding model (for example DeepSeek via a configured tool/provider account) | Two failed attempts, unclear requirements, or poor tests. |
| Security, authorization, migrations | A strong model for targeted review plus human judgment | A qualified second human opinion would reduce material risk. |
| Lint, types, build, standard tests | Deterministic local/CI tools | Only use a model to investigate a nontrivial failure. |

Claude Code, Codex, OpenClaw, Buzz, OpenRouter and DeepSeek are tools/routes, not automatically interchangeable model subscriptions. Confirm the exact provider and billable account, along with each tool's model-selection method, before forecasting costs.

**Initial budgets (owner to fill before enabling paid automations):** per-person monthly cap [amount and currency] · per-issue model budget [amount or turns] · billing owner Ulaş Nazım.

**Pilot record:** Issue [link] · task [description] · model A [name/version/provider] · model B [name/version/provider] · total model cost [amounts] · completed PR [link] · test/review outcome [result] · decision [reason].

**Provider data rule:** Ulaş permits private code and customer data to be sent to **any AI provider** when useful for team work. Reduce input to what the task needs, and keep passwords, tokens, SSH keys and `.env` secrets out of prompts and logs. A team member remains responsible for any contractual or legal duty that applies to their work.

For a tool that remaps model aliases (including compatibility API endpoints), verify which actual model each helper agent uses. Separate environments or profiles if a cheaper coding model should not silently replace the planning or review model. Never assume multiple agents reduce cost without measuring the accepted result.
