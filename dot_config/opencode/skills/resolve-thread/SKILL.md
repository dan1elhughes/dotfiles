---
name: resolve-thread
description: >
  Resolve a GitHub PR review thread/comment from a link. Use when the user asks to resolve a thread,
  resolve a GitHub review comment, address one PR thread, or provides a GitHub PR review-comment URL.
---

# Resolve GitHub Review Thread

Resolve exactly one GitHub PR review thread/comment from the link the user provides.

Input example: `https://github.com/enode/api/pull/12035/changes#r3389418076`

## Workflow

1. Parse the link into `owner`, `repo`, PR number, and review comment database ID from the `#r...` fragment.
   - If the link is missing or not a GitHub PR review-comment link, ask for a valid link.
2. Confirm the local checkout matches the linked repo with `gh repo view --json nameWithOwner` and inspect the worktree with `git status --short`.
   - Preserve unrelated user changes.
   - Do not stage unrelated changes.
   - If unrelated changes block the requested fix, stop and ask for guidance.
3. Read the linked review comment and thread context:
   - Use REST for the comment: `gh api repos/<owner>/<repo>/pulls/comments/<comment_id>`.
   - GitHub PR review comment URL fragments use `#r<database_id>`; strip the leading `r` to get the REST/GraphQL `databaseId`.
   - Use GraphQL to find the containing review thread for the PR by matching the review comment `databaseId` or `id` inside `reviewThreads(first: 100) { nodes { id isResolved comments(first: 100) { nodes { id databaseId body path line url author { login } } } } }`.
   - Paginate review threads if needed.
   - The containing thread ID is the parent `reviewThreads.nodes[].id` for the matched comment. This ID has the `PRRT_...` shape and is the value required by `addPullRequestReviewThreadReply` and `resolveReviewThread`.
   - Do not request `reviewThreads` from `gh pr view --json`; it is unsupported.
   - Include enough surrounding diff/file context to understand the requested change.
4. Decide whether the comment is actionable.
   - Check whether the requested fix has already been implemented in the current branch/worktree before editing.
   - If it is ambiguous, already fixed, or unsafe to change, stop and ask for guidance. Do not create a redundant commit.
5. Make only the changes needed to address this single comment/thread.
   - Do not broaden scope.
6. Run targeted verification appropriate to the changed files.
   - If no practical verification exists, explain that explicitly.
7. Review `git diff`, stage only files related to this resolution, and commit the fix.
   - Use a concise message specific to the change.
   - Do not include `Co-authored-by` trailers.
8. Capture the short commit SHA and prepare the exact reply body: `Resolved in <short SHA>`.
9. Before any network writes, show a confirmation summary containing:
   - linked PR/comment URL
   - thread ID to resolve
   - commit SHA and message
   - reply body
   - push target branch/remote
   - verification run and result
   - Ask for explicit confirmation to push, comment, and resolve.
10. After confirmation only:
    - Push the current branch. Do not force-push unless explicitly requested.
    - Post the prepared reply with GraphQL `addPullRequestReviewThreadReply(input: { pullRequestReviewThreadId: <thread-id>, body: <reply-body> })`.
    - Resolve the thread with GraphQL `resolveReviewThread(input: { threadId: <thread-id> })`.
    - If push succeeds but comment or resolve fails, do not retry with changed content or alternate mutations unless you have inspected the API error. Report exactly which step failed and the error.
11. Final summary: pushed branch, comment posted, thread resolved, commit, and verification.

## Rules

- One linked comment/thread = one commit.
- No push, GitHub reply/comment, or thread resolution before confirmation.
- Do not overwrite or stage unrelated user changes.
- If GitHub API details are missing, inspect with `gh api` or GraphQL rather than guessing.
- If the thread cannot be resolved via API, still push and comment after confirmation, then explain the blocker.
