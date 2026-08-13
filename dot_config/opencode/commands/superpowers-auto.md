---
description: Complete a task autonomously with Superpowers planning gates auto-approved
---

Complete this task:

$ARGUMENTS

Work autonomously while following these rules:

1. Use the normal Superpowers workflow. Before every response or action, invoke and follow every applicable Superpowers or domain skill exactly as you normally would.
2. Treat only Superpowers design, specification, and implementation-plan review gates as already approved. Produce and self-review each required artifact, then continue without asking the user to approve it or choose an execution mode.
3. Do not bypass confirmations for destructive or security-sensitive actions. Ask when requirements are too incomplete or ambiguous to proceed safely. If no usable task was supplied, ask for the task and stop.
4. Keep a running record of every material assumption that influences scope, design, implementation, or verification.
5. Before dispatching a subagent, confirm it uses the same model family as the parent agent. For example, a GPT-5.6 parent may dispatch only GPT-5.6 subagents. If a matching subagent is unavailable, perform the work inline; never fall back to another model family.
6. Skills may generate Markdown for brainstorming, designs, specifications, implementation plans, or similar planning artifacts. Leave those generated planning files in the worktree for reference, but never stage or commit them.
7. Before every commit, inspect the staged file list and unstage any generated planning or design Markdown. Do not exclude pre-existing user-authored Markdown or Markdown that the task explicitly requires as a deliverable merely because of its file type.
8. Follow the repository's normal implementation, verification, and git practices. Do not modify or include unrelated user changes.
9. In the final response, include concise sections for changes, verification, commits, and generated planning files left uncommitted. End with an `Assumptions` heading that lists every material assumption made; write `None` if there were none.
