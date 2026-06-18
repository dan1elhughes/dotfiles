---
name: work-on-linear-issue
description: >
  Work on Linear issue <identifier>. Use when the user says "Work on Linear issue <x>"
  or asks to start work on a specific Linear ticket.
---

# Work on Linear Issue

Start work on exactly one Linear issue and prepare the local checkout for the implementation.

Input examples:

- `Work on Linear issue HE-123`
- `Work on Linear issue https://linear.app/enode/issue/HE-123/...`

## Workflow

1. Parse the Linear issue identifier from the user's request.
   - Accept a plain key like `HE-123` or a Linear issue URL containing the key.
   - If no issue identifier is present, ask the user for the Linear issue key.
2. Read the issue with the Linear tool:
   - Use `linear_get_issue` with the parsed identifier.
   - Include enough fields to understand the work, normally `description`, `comments`, `attachments`, `children`, `parent`, `project`, and `timestamps`, or `all` when useful.
3. Mark the Linear issue as started and owned by Dan:
   - Use `linear_update_issue` with `identifier: <issue>`, `state: "In Progress"`, and `assignee: "dan.hughes@enode.io"`.
   - If the exact in-progress workflow state is not accepted, inspect the error or available issue state names and retry with the repository/team's equivalent started state.
   - Do not change title, labels, priority, project, milestone, or description unless the user explicitly asks.
4. Ensure the git worktree is safe before changing branches:
   - Run `git status --short`.
   - Preserve unrelated user changes. Do not discard, overwrite, or stage them.
   - If local changes would be carried onto the new branch or block checkout, stop and ask for guidance.
5. Ensure the current branch reflects the Linear issue ticket number:
   - Inspect the current branch with `git branch --show-current`.
   - The branch name must contain the issue key lowercased, with the hyphen preserved, for example `he-123-fix-charger-status`.
   - If the current branch already contains the issue key, keep it.
   - Otherwise create and switch to a new branch from the current `HEAD` named from the issue key and a short slug from the issue title, for example `he-123-short-title`.
   - Keep branch names lowercase, use hyphens, and remove punctuation other than hyphens.
   - Do not rename or delete existing branches unless the user explicitly asks.
6. Summarise the starting point before implementation:
   - Linear issue identifier and title.
   - Assignee and state update result.
   - Current branch name.
   - Any blockers or notable context from the issue.

## Rules

- Always read the Linear issue before updating it.
- Always assign the issue to `dan.hughes@enode.io` when starting work.
- Always move the issue to an in-progress/started state when starting work.
- Always ensure the branch name reflects the Linear issue ticket number before implementing changes.
- Never post Linear comments unless the user explicitly asks.
- Never overwrite, stash, or discard unrelated worktree changes without explicit user consent.
