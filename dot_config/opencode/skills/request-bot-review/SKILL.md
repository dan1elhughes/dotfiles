---
name: request-bot-review
description: >
  Ask the review bot to review and approve GitHub PRs. Use when the user asks for a bot review
  or bot approval.
---

# Request Bot Review

Post one message to Slack channel `C0BKAFQHB50` with `slack_send_message`:

```
<@U0BA0FA8GJX> review and approve <url>. Respond only on the PR. Do not reply in Slack; add only a ✅ or ❌ reaction to this message.
```

- Use full PR URLs. Join more PRs with "and". If the user gives none, use `gh pr view --json url -q .url`.
- Do not request a reviewer on GitHub.

## Poll for the result

After you post, poll each PR until the bot approves it or requests changes:

```sh
gh pr view <url> --json reviewDecision,latestReviews
```

- Check about every 60 seconds. Stop after 15 minutes.
- Do not expect or process Slack thread replies. The bot should use reactions only in Slack.
- Tell the user the result for each PR. If the bot requests changes, give its comments.
