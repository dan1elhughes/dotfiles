if which o >/dev/null 2>&1; then
	unalias o
fi

if which oc >/dev/null 2>&1; then
	unalias oc
fi

alias o="opencode"
alias oc="opencode --continue"

ralph-linear() {
	if [ "$#" -ne 1 ]; then
		echo "usage: ralph-linear <LINEAR_ID>"
		return 2
	fi

	local linear_id="$1"
	local output_file opencode_status iteration prompt
	iteration=1
	prompt=$(cat <<'RALPH_LINEAR_PROMPT'
Implement exactly one sequential checklist item from a Linear issue.

Workflow:

1. Validate that the Linear issue identifier provided at the end of this prompt contains exactly one Linear issue identifier. Accept either hyphenated (`HE-1234`) or compact (`HE1234`) form, normalizing to the canonical hyphenated identifier when calling Linear tools. If it is missing or ambiguous, print `=== BLOCKED ===`, ask for the identifier, and stop.
2. Read the Linear issue with its description using the available Linear tool (`linear_get_issue` with `description`, or the equivalent MCP tool).
3. Inspect the description for checkbox checklist items. If the description contains no checkbox checklist items at all, print `=== BLOCKED ===`, tell the user to run `/ralph-prep <issue-id>` first, and stop. Do not infer tasks from prose in this command.
4. Find the first uncompleted checklist item in the issue description, in document order. Treat these as uncompleted:
   - `- [ ] item`
   - `* [ ] item`
   - `1. [ ] item`
   Treat `[x]` and `[X]` as completed.
5. If checkbox checklist items exist but all are completed, print `=== ALL TASKS COMPLETE ===`, stop, and report that the Linear issue is already complete.
6. Restate the selected checklist item, then implement only that item. Do not work on later checklist items or adjacent cleanup.
7. Before editing, check `git status --short` and preserve unrelated user changes. Do not overwrite or stage unrelated changes.
8. Read the relevant code and tests, follow local conventions, and make the smallest clean change that fully satisfies the selected item.
9. Run suitable verification for the touched code:
   - Format: use the repository's formatter command if available.
   - Lint: use the repository's lint command if available.
   - Tests: run the narrowest relevant test command that covers the change; if no narrow test exists, run the smallest practical test suite.
   - If a standard command is unavailable, inspect package scripts/build files and use the closest local equivalent.
   - If verification fails, fix and rerun until it passes, or stop with a clear blocker.
10. If code/config/doc changes were needed, review `git diff`, stage only files changed for this checklist item, and commit with a concise descriptive message. Do not push.
11. If no code/config/doc changes were needed because the selected checklist item is already fully implemented, verify it with the narrowest relevant command. If verification passes, do not create an empty commit; continue to the Linear checkbox update and report `Commit hash: none — existing implementation verified`. Include evidence: exact implementation symbols/files, exact test names/files, and the passing verification command.
12. After the commit succeeds, or after an already-implemented item is verified, update the Linear issue description to mark exactly the selected checklist item complete by changing only that item's checkbox to `[x]`. Preserve all other description text and checklist state. When sending the Linear update, do not include a `parent` field unless intentionally changing the parent; if the tool requires a parent value, preserve the issue's existing parent exactly. Never set an issue as its own parent.
13. If the Linear description update fails, do not amend any code commit. Print `=== BLOCKED ===`, report the failure, and include the exact checklist item that still needs to be marked complete.
14. After updating Linear, read or reason over the updated description. If there are no remaining uncompleted checklist items, print `=== ALL TASKS COMPLETE ===`. If more uncompleted checklist items remain, print `=== CONTINUE ===`.
15. For any blocker that prevents completing the selected item, print `=== BLOCKED ===` and explain the blocker. Blockers include missing required context, failing verification that cannot be fixed safely, dirty worktree conflicts with user changes, unavailable Linear write access, or a Linear description that has not been prepared with checkboxes.
16. Final response must include:
    - Linear issue identifier
    - Checklist item completed or verified
    - Commit hash
    - Verification commands run
    - Whether the Linear checkbox update succeeded

Rules:

- Exactly one checklist item per invocation.
- Do not mark the Linear item complete before verification has succeeded and either a commit has been created or the existing implementation has been verified.
- Do not create a commit if there are no code/config/doc changes needed for the selected item; verify the existing implementation and mark the Linear item complete instead.
- Do not push.
- Do not post Linear comments unless explicitly asked; the required Linear write is only the description checkbox update.
- Preserve unrelated worktree changes and unrelated Linear description edits.
- Preserve Linear issue relationships during the checkbox update: omit relationship fields unless they must be supplied, and never rewrite the parent to the current issue.
- Semaphore contract for automation:
  - Print `=== ALL TASKS COMPLETE ===` only when the Linear issue has no remaining uncompleted checklist items.
  - Print `=== CONTINUE ===` after successfully completing or verifying exactly one checklist item when more uncompleted checklist items remain.
  - Print `=== BLOCKED ===` whenever the command cannot make forward progress.
  - Every invocation must print exactly one of these semaphores: `=== ALL TASKS COMPLETE ===`, `=== CONTINUE ===`, or `=== BLOCKED ===`.

Linear issue identifier:
RALPH_LINEAR_PROMPT
	)
	prompt="${prompt}
${linear_id}"

	while true; do
		echo "ralph-linear: iteration ${iteration} for ${linear_id}"
		output_file="$(mktemp -t ralph-linear.XXXXXX)" || return 1
		opencode run "$prompt" 2>&1 | tee "$output_file"
		opencode_status=$pipestatus[1]

		if grep -q '=== ALL TASKS COMPLETE ===' "$output_file"; then
			rm -f "$output_file"
			return 0
		fi

		if grep -q '=== BLOCKED ===' "$output_file"; then
			rm -f "$output_file"
			return 1
		fi

		if grep -q '=== CONTINUE ===' "$output_file"; then
			rm -f "$output_file"
			iteration=$((iteration + 1))
			continue
		fi

		rm -f "$output_file"

		if [ "$opencode_status" -ne 0 ]; then
			echo "ralph-linear: opencode exited with status ${opencode_status} before emitting a completion semaphore"
			return "$opencode_status"
		fi

		echo "ralph-linear: opencode exited without emitting a completion semaphore"
		return 1
	done
}
