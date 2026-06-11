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

7. **Changes were needed:** review `git diff`, stage only the files changed for this item, commit with a concise descriptive message.
8. **Item already fully implemented (no changes needed):** verify it with the narrowest relevant command and do not create an empty commit. Report `Commit hash: none — existing implementation verified` with evidence: exact symbols/files implementing it, exact test names/files, and the passing verification command.

## Draft PR exception

Pushing is forbidden **except** when the selected checklist item itself explicitly says to create a draft PR. In that case, after steps 4–8 have succeeded:

- Push the current branch only as far as needed to create or update the PR; do not push work from other checklist items.
- Open the PR **as a draft**, with a concise summary, the verification commands, and any PR-body guidance from the Linear item or issue description.
- The checklist item is not complete until the draft PR exists; if push or PR creation fails → BLOCKED.

## Update Linear

Only after verification passed, step 7 or 8 succeeded, and (if applicable) the draft PR exists:

9. Update the issue description, changing **only** the selected item's checkbox to `[x]`. Preserve all other text and checklist state.
   - `linear_update_issue` accepts relationship fields like `parent` — omit them unless the tool requires them. If a parent must be sent, fetch the issue's current parent first and pass that parent's identifier (e.g. `HE-2762`); never the current issue's own ID.
   - If the update fails → BLOCKED; do not amend the commit; report which item still needs marking.
10. From the updated description, compute progress: total / completed / remaining checkbox counts, and the next uncompleted item if any.

## Semaphores (automation contract)

Print exactly one per invocation, and nothing that imitates them otherwise:

- `=== ALL TASKS COMPLETE ===` — no uncompleted checkbox items remain.
- `=== CONTINUE ===` — exactly one item was completed or verified and uncompleted items remain.
- `=== BLOCKED ===` — forward progress is impossible (missing/ambiguous identifier, unprepared description, dirty-worktree conflict, unfixable verification failure, failed push or PR creation, no Linear write access, failed description update, or other missing required context). Always explain the blocker.

## Final report

Include: issue identifier; the item completed or verified; commit hash (or `none — existing implementation verified`); verification commands run; draft PR URL if one was created; whether the Linear checkbox update succeeded; progress (completed/total, remaining count, next uncompleted item if any).

## Hard rules

- One checklist item per invocation. No pushes outside the draft PR exception. No Linear comments unless explicitly asked — the only required Linear write is the checkbox update.
- Never mark an item complete before verification has passed and a commit exists or the existing implementation is verified.
- Preserve unrelated worktree changes and unrelated description edits.
