---
description: Address GitHub PR feedback one thread per commit, then push/reply/resolve after confirmation
---

Use `gh` to address PR feedback: one actionable unresolved comment/thread per commit. Never push, reply, or resolve threads before explicit confirmation. Never force-push unless asked. Never overwrite unrelated user changes. Ask before expanding scope beyond the current item.

1. **Find PR**: use provided number/URL, else `gh pr view --json number,url,headRefName,baseRefName,title`. Ask if ambiguous.
2. **Check worktree**: `git status --short`; note unrelated changes to preserve.
3. **Read feedback**:
   - `gh pr view <pr> --json number,title,url,reviewDecision,comments,reviews`
   - `gh api repos/:owner/:repo/pulls/<number>/comments --paginate`
   - `gh api repos/:owner/:repo/issues/<number>/comments --paginate`
   - Threads: GraphQL only (`reviewThreads` is unsupported in `gh pr view --json`).
4. **Checklist**: actionable items only; record skips (praise, non-actionable, already resolved) to report later.
5. **Per item**: minimal change → targeted verification → review `git diff` → stage only related files → commit. Commit body must quote or clearly summarize the reviewer's request when review context exists.
6. **Track**: thread/comment ID → short SHA → reply text `Resolved in <short SHA>`. For swarm reviews, also record the exact review item title.
7. **Confirm**: show push target, item→SHA map, threads to resolve, verification results, skips/blocks. Wait for approval.
8. **Execute** (post-approval only): push branch; post each tracked reply verbatim; resolve fixed threads where possible. Swarm reviews: for each fixed item, prefix its title with ✅ and add `Resolved in <short SHA>` directly beneath the title, within the expandable section — preserve the rest of the body unchanged.
9. **Summarize**: branch pushed, replies/resolutions, commits, verification, skips/blocks.
