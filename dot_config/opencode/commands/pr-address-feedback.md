---
description: Read GitHub PR feedback and address one comment/thread per commit
---

Use `gh` to read PR feedback. Fix one actionable comment/thread per commit.

Steps:
1. Find PR: use provided number/URL, else `gh pr view --json number,url,headRefName,baseRefName,title`. Ask if ambiguous.
2. Check worktree: `git status --short`. Preserve unrelated user changes.
3. Read feedback:
   - `gh pr view <pr> --json number,title,url,reviewDecision,comments,reviews`
   - `gh api repos/:owner/:repo/pulls/<number>/comments --paginate`
   - `gh api repos/:owner/:repo/issues/<number>/comments --paginate`
   - For threads, use GraphQL. Do not request `reviewThreads` from `gh pr view --json`; it is unsupported.
4. Make a checklist of actionable unresolved comments/threads. Skip praise/non-actionable/already resolved items; mention skipped items later.
5. For each item, one at a time: change only what it needs, run targeted verification, review `git diff`, stage related files only, commit before the next item.
6. Final summary: PR processed, items fixed with commit hashes, checks run, skipped/blocked items.

Rules:
- One comment/thread = one commit.
- Do not force-push or resolve GitHub threads unless asked.
- Do not post replies or comments on GitHub (PR reviews, issue comments, thread replies) without explicit user consent.
- Do not overwrite user changes.
- Ask before expanding scope beyond the current comment/thread.
