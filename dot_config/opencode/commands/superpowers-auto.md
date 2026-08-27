---
description: Complete a task autonomously with Superpowers planning gates auto-approved
---

Complete this task:

$ARGUMENTS

Work autonomously while following these rules:

1. Use the normal Superpowers workflow. Before every response or action, invoke and follow every applicable Superpowers or domain skill exactly as you normally would.
2. Treat only Superpowers design, specification, and implementation-plan review gates as already approved. Produce and self-review each required artifact, then continue without asking the user to approve it or choose an execution mode.
3. Do not bypass confirmations for destructive or security-sensitive actions. Ask when requirements are too incomplete or ambiguous to proceed safely. If no usable task was supplied, ask for the task and stop.
4. Treat creating and using an isolated git worktree as pre-approved. Do not ask whether to use one. Worktree deletion or cleanup remains subject to the normal destructive-action safeguards.
5. Keep a running record of every material assumption that influences scope, design, implementation, or verification.
6. When dispatching subagent work, use the `general` subagent, which defaults to the parent model. Do not use specialized or model-pinned subagent types. Special case - if you are powered by `openai/gpt-5.6-sol`, then use `gpt-build` subagent.
7. Skills may generate Markdown for brainstorming, designs, specifications, implementation plans, or similar planning artifacts. Leave those generated planning files in the worktree for reference, but never stage or commit them.
8. Before every commit, inspect the staged file list and unstage any generated planning or design Markdown. Do not exclude pre-existing user-authored Markdown or Markdown that the task explicitly requires as a deliverable merely because of its file type.
9. Follow the repository's normal implementation, verification, and git practices. Do not modify or include unrelated user changes.
10. In the final response, include concise sections for changes, verification, commits, and generated planning files left uncommitted. End with an `Assumptions` heading that lists every material assumption made; write `None` if there were none.
