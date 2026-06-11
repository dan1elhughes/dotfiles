# Code Swarm Review - Final Synthesis and Delivery

Write the final report as your only final answer.
Do not write files.

{{TARGET_METADATA}}

## Hard boundary

Do not perform a code review. Do not inspect code to form new defect opinions.
Use only the initial reviews and agreement passes embedded below. You may
mechanically use gh/git metadata commands only when needed to post PR comments or
anchor reviewer-provided findings.

## Summarising model

Identify the model doing this final synthesis yourself. Use the exact model
identifier if available; otherwise use the most specific identifier you know.

## Reviewers

{{REVIEWERS_BLOCK}}

{{REVIEWER_FAILURES_BLOCK}}

## Initial reviews

{{INITIAL_REVIEWS_BLOCK}}

## Agreement passes

{{AGREEMENT_PASSES_BLOCK}}

## Final report requirements

Organize by finding, not by model. Merge duplicate findings only when reviewers
clearly described the same underlying issue. Do not invent findings, evidence,
severity, locations, or fixes beyond reviewer text.

Use this format:

# 🐝 Swarm review

<reviewer count> reviewers; <finding count> findings.

## Models used

- Summariser - `<your model identifier>`
- Reviewer: `<model id>`
- Reviewer: `<model id>`
- (Repeat as appropriate, list every reviewer)

## Findings

<details>
<summary>1. [High|Medium|Low] <short finding title></summary>

<br>

Location: `<file>:<line>`

<Raising reviewer> thinks <concise issue, evidence, impact, and suggested fix>. (<N> of <M> agree)

Interpretation: <summarize the issue across all reviewers' interpretations,
including any important nuance from disagreeing reviewers. Do not list
reviewer-by-reviewer rationales here.>

Agree: `<model>`, `<model>`, `<model>`

Disagree:
`<model>`: <concise explanation>
`<model>`: <concise explanation>

</details>

If there are no actionable findings, still include Target, Summary, Models used,
Findings, and No actionable findings. In Findings, write: No actionable
findings.

Include these sections only when non-empty:

## No actionable findings

## Reviewer failures

## Output rules

- Do not post anywhere. The caller handles delivery.
- Return the final report only.
- Always format model identifiers like `model/id` in backticks everywhere in the
  final report, including Models used, Agree, Disagree, and reviewer failures.
- Never resolve threads, submit PR reviews, edit files, commit, or apply fixes.

{{PR_DELIVERY_METADATA_BLOCK}}
