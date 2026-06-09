---
description: Work from Linear
---

Prepare to work from a Linear issue.

Arguments:
- My email: $1
- Linear issue ID: $2
- Branch name to use: $3

If any argument is missing, ask for it before taking action.

Steps:
1. Read the Linear issue, including comments and linked context.
2. Ensure the issue is assigned to me (`$1`) and moved to an in-progress state.
3. Inspect the current git branch and worktree. Do not overwrite unrelated user changes.
4. Use branch `$3`; create it if needed, but do not switch branches until the plan is confirmed.
5. Produce a concise implementation plan and wait for confirmation before implementing or switching branches.
