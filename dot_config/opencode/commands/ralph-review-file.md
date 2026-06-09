---
description: Iteratively fix REVIEW.md
---

Work from REVIEW.md. Pick exactly one unresolved, code-actionable review item.

Before editing:

1. Tell me which item you picked.
2. Explain the issue in plain language.
3. Propose a concrete fix with pseudocode or a step-by-step implementation plan.
4. Wait for my confirmation.

After I confirm:

1. Read the relevant source files and neighboring tests first; follow local conventions.
2. Implement the smallest clean fix that fully addresses the selected review item.
3. Remove only that addressed item from REVIEW.md; leave unrelated review items intact.
4. Run validation in this order:
   - From repo root: `npm run format`
   - From repo root: `npm run lint`
   - For tests, identify the most relevant test file touched or nearest to the change.
     - If it is under `webserver/`, run from repo root:
       `cd webserver && npm run mocha -- path/from/webserver/root/to/testfile.ts`
       Example: `cd webserver && npm run mocha -- src/flex/hem-system-policies/route.test.ts`
     - If it is not under `webserver/`, inspect that package’s `package.json` scripts and run the narrowest equivalent test command for the touched test file.
   - If the command the user requested is not literally available at repo root, use the package-local equivalent and mention that in the final summary.
5. If validation fails, fix and rerun the same validation sequence until it passes, or clearly explain the blocker.
6. Commit the code changes and REVIEW.md change together in exactly one commit with a descriptive message.
7. Report the commit hash and validation commands run.

Constraints:

- Do not address multiple review items.
- Do not remove broader sections from REVIEW.md unless the selected item was the only content there.
- Do not post or reply to GitHub/Linear/Slack without explicit permission.
- Prefer tests that prove the behavior would fail without the fix, not just superficial count/status assertions.
