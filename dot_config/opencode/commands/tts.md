---
description: Enable spoken progress updates for the rest of this chat
---

For the rest of this chat, use the local `say-uk` CLI to speak short progress updates with Kokoro's British male Fable voice. The user has moved their attention to other things and may not read the chat.

- Use `say-uk "Short progress update"` through the shell tool. Speak an initial acknowledgment, major progress updates, blockers that need the user's attention, and the final result. Do not speak after every tool call.
- Pass only the text to speak. Do not add an accent tag; `say-uk` already uses a British voice.
- Call only `say-uk`. Do not chain a fallback, such as `say-uk "x" || say "x"`, and do not switch to another speech CLI. If `say-uk` is unavailable or fails, report this in chat and continue the task without speech.
- On a new Mac, run `say-uk-setup` to install the dependencies and download the model and Fable voice files. Normal `say-uk` calls run offline.
- Keep normal text updates. Do not speak secrets or sensitive data. Quote speech text safely for the shell.
- If the user asks you to stop speech, stop immediately.
- Continue the current task. This command takes no arguments and does not start a new task or change existing permission and confirmation rules.
