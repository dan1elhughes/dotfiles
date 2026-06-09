---
description: Address GitHub PR feedback one thread per commit, then push/reply/resolve after confirmation
---

Use `gh` to read PR feedback. Fix one actionable unresolved comment/thread per commit.

Steps:
1. Find PR: use provided number/URL, else `gh pr view --json number,url,headRefName,baseRefName,title`. Ask if ambiguous.
2. Check worktree: `git status --short`. Preserve unrelated user changes.
3. Read feedback:
   - `gh pr view <pr> --json number,title,url,reviewDecision,comments,reviews`
   - `gh api repos/:owner/:repo/pulls/<number>/comments --paginate`
   - `gh api repos/:owner/:repo/issues/<number>/comments --paginate`
   - For threads, use GraphQL. Do not request `reviewThreads` from `gh pr view --json`; it is unsupported.
4. Build a checklist. Skip praise/non-actionable/already resolved items; mention skips later.
5. For each item: make only needed changes, run targeted verification, review `git diff`, stage related files only, commit before moving on.
6. Track each fixed item as: thread/comment ID -> short commit SHA -> `Resolved in <short SHA>`.
7. Before network writes, show: push target, fixed-item map, threads to resolve, checks, skips/blocks. Ask for confirmation.
8. After confirmation only: push branch, post each reply exactly as tracked, and resolve fixed review threads when possible.
9. Final summary: pushed branch, replies/resolutions, commits, checks, skips/blocks.

Rules:
- One comment/thread = one commit.
- No force-push unless explicitly asked.
- No push, GitHub reply/comment, or thread resolution before confirmation.
- Do not overwrite user changes.
- Ask before expanding scope beyond the current item.
