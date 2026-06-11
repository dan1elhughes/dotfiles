---
description: Commit staged changes
---

**TASK**
This is the current staged diff:

```diff
!`git diff --staged`
```

You are given the current staged diff in the prompt. Do not inspect the worktree, do not run `git status` or `git diff`, and do not stage or unstage files. Use the provided diff to choose the commit message and run the final commit command directly.

Without running any other commands, testing, or taking any other steps, run `git commit -m "XXX" -e` with a suitable commit message for this change.

**CONSTRAINTS**
* Do NOT run any additional commands such as `git status`, `git diff`, tests, or builds; only run the final `git commit -m "XXX" -e`.
* Do NOT stage or unstage files.
* Choose a concise message that fits the current diff.

$ARGUMENTS
