# Code Swarm Review - Initial Review

Reviewer: {{LABEL}} ({{SPEC}})

Write the complete markdown review as your only final answer. Do not write files.

{{TARGET_METADATA}}

## Instructions

- This is a static code review. Do not run linters, formatters, test suites,
  type checkers, builds, package installs, or application commands.
- Review only the code changes between the provided base and head target.
- You may run source-control read commands such as git diff, git show, git log,
  git status, and gh pr diff, and you may read affected files as needed.
- Do not post GitHub comments, create PR reviews, edit files, commit, or apply
  fixes.
- Focus on real bugs, behavior regressions, security issues, missing edge-case
  handling, and clearly harmful performance problems.
- For each actionable finding, include severity (high/medium/low), file, line,
  evidence, impact, and a suggested fix.
- If there are no actionable findings, say so explicitly.
- Do not expand the review beyond this target.

## Output format

# Initial Review - {{LABEL}}

## Findings

For each finding:

### [High|Medium|Low] Short title

Location: path:line

Evidence: ...

Impact: ...

Suggested fix: ...

If no findings, write: No actionable findings.
