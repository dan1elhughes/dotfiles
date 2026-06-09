---
description: Read CI workflow failures for the current branch and resolve them
---

Use the GitHub CLI to read workflow failures for the current branch, then fix the issues.

Steps:
1. Get the current branch name
2. Use `gh run list --branch <branch> --status failure` (or similar) to list failed workflow runs
3. For each failed run, use `gh run view <run-id>` and `gh run view <run-id> --log-failed` to inspect the failure
4. Identify the cause of each failure and fix the code or configuration

Focus on the failed jobs and their logs. Resolve lint errors, test failures, or build errors as indicated by the CI output. Do NOT rerun the workflow or push. Create commits for your fixes and report when ready.
