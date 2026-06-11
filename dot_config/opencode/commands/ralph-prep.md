---
description: Prepare a Linear implementation issue as outcome-focused sequential work items for ralph-linear
---

Prepare a Linear implementation issue so the `ralph-linear` shell function can work through it sequentially, one independently reviewable item at a time.

The only argument is the Linear issue identifier, for example `HE-1234` or `HE1234`:

`$ARGUMENTS`

Workflow:

1. Validate that `$ARGUMENTS` contains exactly one Linear issue identifier. Accept either hyphenated (`HE-1234`) or compact (`HE1234`) form, normalizing to the canonical hyphenated identifier when calling Linear tools. If it is missing or ambiguous, ask for the identifier and stop.
2. Read the Linear issue with its description using the available Linear tool (`linear_get_issue` with `description`, or the equivalent MCP tool).
3. Inspect the description:
   - If it already contains checkbox checklist items (`- [ ]`, `* [ ]`, `1. [ ]`, `[x]`, or `[X]`), do not rewrite it. Report that the issue is already prepared and summarize the existing open/completed counts.
   - If it does not contain checkbox checklist items, rewrite it into a plain-language, outcome-focused implementation plan.
4. When rewriting, replace the issue description with the prepared structure. Do not append a separate `Ralph work plan` section below the old prose. Preserve essential context by folding it into the rewritten description, prerequisites, out-of-scope notes, or work item wording.
5. Use this structure when relevant:
   - Brief context: one short paragraph describing the intended entity, outcome, behavior, or user/system effect.
   - `## Prerequisites`: branch requirements, dependency requirements, required upstream work, or other conditions that must be true before implementation starts.
   - `## Work plan`: the only section containing checkbox implementation items.
   - `## Verification`: focused tests and relevant build/typecheck/lint/unused-code checks should run after each work item.
   - `## Out of scope`: keep exclusions separate from the work plan.
6. The work plan must contain only independently doable implementation slices that leave the codebase working and are independently reviewable. Each item should describe a concrete outcome, not a broad phase.
7. Write work items in plain language. Prefer domain language: entities, outcomes, behavior, and user/system effects. Keep jargon low and avoid file names, function names, and code-level details unless essential for correctness.
8. Use Markdown checkboxes exactly like:
   - `- [ ] First outcome-focused implementation slice`
   - `- [ ] Second outcome-focused implementation slice`
9. Do not include broad validation/checking as a checklist item. Instead, add the separate `## Verification` section described above.
10. Move branch/dependency requirements into `## Prerequisites` rather than making them checklist items.
11. Move final PR preparation into the last work item, worded as: `Create a draft PR…`. Include PR-only tasks inside that final item, such as metrics confirmation, Rush change file, and PR body guidance.
12. Do not include vague items such as "clean up", "investigate", "handle edge cases", or "test everything" unless they are rewritten into concrete implementation outcomes.
13. Update the Linear issue description with only the preparation changes. Do not change issue state, assignee, labels, or post comments unless explicitly asked.
14. Final response must include:
   - Linear issue identifier
   - Whether it was already prepared or updated
   - Number of open checklist items
   - A concise preview of the checklist

Rules:

- This command prepares Linear only; do not edit repository files, run tests, or create commits while executing the command.
- Do not mark any newly-created checklist items complete.
- Preserve existing completed checkbox state if checkboxes already exist.
- If the description is too ambiguous to produce concrete sequential tasks, ask clarifying questions instead of writing a checklist.
