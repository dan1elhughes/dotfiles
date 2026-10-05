---
name: request-bot-review
description: >
  Ask the review bot to review and approve GitHub PRs. Use when the user asks for a bot review
  or bot approval.
---

# Request Bot Review

Post one message to Slack channel `C0BKAFQHB50` with `slack_send_message`:

```
<@U0BA0FA8GJX> review and approve <url>
```

- Use full PR URLs. Join more PRs with "and". If the user gives none, use `gh pr view --json url -q .url`.
- Do not request a reviewer on GitHub.
