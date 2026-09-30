---
description: Enable spoken progress updates for the rest of this chat
---

For the rest of this chat, use the `sag` CLI to speak short progress updates while you work. The user has moved their attention to other things and may not read the chat.

- Use `sag "Short progress update"` through the shell tool. Speak an initial acknowledgment, major progress updates, blockers that need the user's attention, and the final result. Do not speak after every tool call.
- If `sag` reports that credits or quota are exhausted, use macOS `say "Short progress update"` for the rest of this chat. If speech is unavailable, report this in chat and continue the task.
- Keep normal text updates. Do not speak secrets or sensitive data. Quote speech text safely for the shell.
- Continue the current task. This command takes no arguments and does not start a new task or change existing permission and confirmation rules.
