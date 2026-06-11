Implement exactly one checklist item from a Linear issue, then stop.

## Argument

The only argument is one Linear issue identifier, e.g. `HE-1234` or `HE1234` (normalize compact form to hyphenated before calling Linear tools):

`$ARGUMENTS`

If the argument is missing, ambiguous, or contains more than one identifier → BLOCKED (see Semaphores), ask for a single identifier, and stop.

## Select the item

1. Fetch the issue with its description (`linear_get_issue` with `description`, or equivalent MCP tool).
2. Scan the description for checkbox items. Uncompleted: `- [ ]`, `* [ ]`, `1. [ ]`. Completed: `[x]` or `[X]`.
   - No checkboxes at all → BLOCKED; tell the user to run `/ralph-prep <issue-id>` first. Never infer tasks from prose.
   - All checkboxes completed → print `=== ALL TASKS COMPLETE ===` and report the issue is already done.
3. Select the **first uncompleted item in document order**. Restate it. Implement only this item — no later items, no adjacent cleanup.

## Implement

4. Run `git status --short` first. Preserve unrelated user changes; never overwrite or stage them. Dirty-worktree conflicts with the selected item → BLOCKED.
5. Read the relevant code and tests, follow local conventions, and make the smallest clean change that fully satisfies the item.
6. Verify the touched code: run the repo's formatter and linter if available, plus the narrowest relevant test (or the smallest practical suite if no narrow test exists). If standard commands are missing, find the closest equivalent in package scripts/build files. Fix and rerun failures until green, or → BLOCKED if it cannot be fixed safely.

## Commit

7. **Changes were needed:** review `git diff`, stage only the files changed for this item, commit with a concise descriptive message. Do not push.
8. **Item already fully implemented (no changes needed):** verify it with the narrowest relevant command and do not create an empty commit. Report `Commit hash: none — existing implementation verified` with evidence: exact symbols/files implementing it, exact test names/files, and the passing verification command.

## Update Linear

Only after verification passed and step 7 or 8 succeeded:

9. Update the issue description, changing **only** the selected item's checkbox to `[x]`. Preserve all other text and checklist state.
   - Omit relationship fields (e.g. `parent`) unless the tool requires them; if required, pass the existing values unchanged. Never set an issue as its own parent.
   - If the update fails → BLOCKED; do not amend the commit; report which item still needs marking.
10. From the updated description, compute progress: total / completed / remaining checkbox counts, and the next uncompleted item if any.

## Semaphores (automation contract)

Print exactly one per invocation, and nothing that imitates them otherwise:

- `=== ALL TASKS COMPLETE ===` — no uncompleted checkbox items remain.
- `=== CONTINUE ===` — exactly one item was completed or verified and uncompleted items remain.
- `=== BLOCKED ===` — forward progress is impossible (missing/ambiguous identifier, unprepared description, dirty-worktree conflict, unfixable verification failure, no Linear write access, failed description update, or other missing required context). Always explain the blocker.

## Final report

Include: issue identifier; the item completed or verified; commit hash (or `none — existing implementation verified`); verification commands run; whether the Linear checkbox update succeeded; progress (completed/total, remaining count, next uncompleted item if any).

## Hard rules

- One checklist item per invocation. No pushes. No Linear comments unless explicitly asked — the only required write is the checkbox update.
- Never mark an item complete before verification has passed and a commit exists or the existing implementation is verified.
- Preserve unrelated worktree changes and unrelated description edits.
