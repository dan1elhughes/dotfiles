---
description: Prepare a Linear issue description as sequential checkbox work items for ralph-linear
---

Prepare a Linear issue so `/ralph-linear` can work through it sequentially.

The only argument is the Linear issue identifier, for example `HE-1234` or `HE1234`:

`$ARGUMENTS`

Workflow:

1. Validate that `$ARGUMENTS` contains exactly one Linear issue identifier. Accept either hyphenated (`HE-1234`) or compact (`HE1234`) form, normalizing to the canonical hyphenated identifier when calling Linear tools. If it is missing or ambiguous, ask for the identifier and stop.
2. Read the Linear issue with its description using the available Linear tool (`linear_get_issue` with `description`, or the equivalent MCP tool).
3. Inspect the description:
   - If it already contains checkbox checklist items (`- [ ]`, `* [ ]`, `1. [ ]`, `[x]`, or `[X]`), do not rewrite it. Report that the issue is already prepared and summarize the existing open/completed counts.
   - If it does not contain checkbox checklist items, convert the requested work into a clear sequential checklist.
4. When creating a checklist, rewrite the issue description into the sequential checkbox work plan. Do not append a separate `Ralph work plan` section below the old prose. Preserve any essential context by folding it into the rewritten description or into the checklist item wording.
5. The checklist must be made of small, code-actionable, ordered items that `/ralph-linear` can implement one at a time. Use Markdown checkboxes exactly like:
   - `- [ ] First concrete implementation step`
   - `- [ ] Second concrete implementation step`
6. Include verification as part of the relevant implementation items, or as a final checklist item only when it is genuinely separate and code-actionable.
7. Do not include vague items such as "clean up", "investigate", "handle edge cases", or "test everything" unless they are rewritten into concrete implementation work.
8. Update the Linear issue description with only the preparation changes. Do not change issue state, assignee, labels, or post comments unless explicitly asked.
9. Final response must include:
   - Linear issue identifier
   - Whether it was already prepared or updated
   - Number of open checklist items
   - A concise preview of the checklist

Rules:

- This command prepares Linear only; do not edit repository files, run tests, or create commits.
- Do not mark any newly-created checklist items complete.
- Preserve existing completed checkbox state if checkboxes already exist.
- If the description is too ambiguous to produce concrete sequential tasks, ask clarifying questions instead of writing a checklist.
