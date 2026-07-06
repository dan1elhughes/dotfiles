---
name: remember-that
description: >
  Use when the user says "remember that", "remember this", "remember: ...", or otherwise
  asks you to store a fact, preference, or instruction for future sessions. Persists the
  information by amending the relevant AGENTS.md file.
---

# Remember That

Persist a durable instruction the user wants future agent sessions to follow, by amending
the relevant `AGENTS.md` file.

## Trigger

The user says "remember that ...", "remember this ...", "remember: ...", "note that ...
going forward", or otherwise signals a fact that should outlive this conversation.

## Workflow

1. Identify what the user wants remembered. If the instruction is ambiguous, ask one
   clarifying question — do not guess.
2. Locate the target `AGENTS.md`, in this order:
   1. The `AGENTS.md` at the root of the current git workspace (`git rev-parse --show-toplevel`/AGENTS.md).
   2. The global opencode instructions file at `~/.config/opencode/AGENTS.md`.
   3. If none exists, create one at the workspace root.
3. Read the existing `AGENTS.md` to see where the new instruction fits and match its style
   (heading level, bullets vs. prose, tone).
4. Append the instruction in the appropriate section, or add a new short section if none fits.
   Keep it concise — one line or a few bullets. Do not reformat unrelated content.
5. Confirm to the user in one line: what was remembered, and which file holds it.

## What to Remember

Record durable preferences, conventions, and decisions — not transient facts about this
session's work. If unsure whether something is "remember"-worthy, ask.

Examples worth remembering:

- "Remember that this repo uses pnpm, never npm."
- "Remember that PR titles go in imperative mood."
- "Remember: never commit the `.env.local` file."

Examples NOT worth remembering (just do the task):

- "Remember to fix the typo on line 42." (one-off, not a convention)
- "Remember what we decided in this meeting." (record in the task/issue, not AGENTS.md)

## Common Mistakes

- Rewriting or reflowing the whole `AGENTS.md` → append surgically; preserve unrelated lines.
- Recording a one-off task as a durable rule → clutters the instructions file.
