# Repository instructions

This repository is managed by chezmoi. Files named with chezmoi source-state
conventions, such as `dot_zshrc`, `dot_config/...`, and `*.tmpl`, map to files
in the user's home directory when applied.

When modifying files that affect the rendered home-directory state, always use
the `question` tool after making edits to ask whether to run:

```sh
chezmoi apply
```

Do not run `chezmoi apply` automatically unless the user asks or clearly agrees,
because it writes the repository state into the live home directory.
