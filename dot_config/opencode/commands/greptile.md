---
description: Run Greptile CLI review, propose fixes, then commit approved changes
---

Use the Greptile CLI to review the current branch, propose fixes, and commit only the approved changes.

Steps:

1. Check the worktree with `git status --short`. Preserve unrelated user changes.
2. Run Greptile from the repository root using the latest CLI and agent output:
   - Default: `npx greptile@latest review --agent`
   - If a base branch is supplied in `$ARGUMENTS`, pass it with `--branch <branch>`.
   - If Greptile reports that login is required, stop and tell the user to run `npx greptile@latest login`.
3. Read the Greptile findings and decide which ones are actionable.
4. Before editing anything, propose the exact plan to the user:
   - Findings to fix
   - Files likely to change
   - Verification you plan to run
   - Commit strategy
5. Ask for confirmation and wait. Do not edit files before confirmation.
6. After confirmation, make only the approved fixes. Do not expand scope without asking again.
7. Run targeted verification for the changed code.
8. Review the final diff with `git diff` and summarize it.
9. Stage only the files you changed for the approved Greptile fixes.
10. Commit the fixes with a concise message.
11. Final summary: Greptile command used, fixes committed, commit SHA, verification run, and any skipped findings.

Rules:

- Always invoke Greptile as `npx greptile@latest ...`.
- Always include the `--agent` flag when running `greptile review`.
- Do not push.
- Do not edit files, stage files, or commit before the user approves the proposed changes.
- Do not overwrite or stage unrelated user changes.
- If there are no actionable findings, do not create a commit.

$ARGUMENTS
