# Code Swarm Review - Agreement Pass

Reviewer: {{LABEL}} ({{SPEC}})

Write the complete markdown agreement as your only final answer. Do not write files.

{{TARGET_METADATA}}

## Instructions

- Do not perform a fresh code review.
- Do not add new findings. React only to findings already raised in the initial reviews below.
- For each finding from every other reviewer, state agree, disagree, or unsure, and give a concise reason.
- If another reviewer raised no findings, acknowledge that.
- Do not run linters, formatters, tests, type checkers, builds, package installs, or application commands.
- Do not post GitHub comments, create PR reviews, edit files, commit, or apply fixes.

## Your initial review

```markdown
{{OWN_INITIAL_REVIEW}}
```

## Other initial reviews

{{OTHER_INITIAL_REVIEWS}}

## Output format

# Agreement - {{LABEL}}

## Reactions

- Reviewer/finding: Agree|Disagree|Unsure because ...
