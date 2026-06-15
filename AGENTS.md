# Repository instructions

This repository is managed by chezmoi. Files named with chezmoi source-state
conventions, such as `dot_zshrc`, `dot_config/...`, and `*.tmpl`, map to files
in the user's home directory when applied.

When editing opencode config, prefer the chezmoi source files in this repo over
reading global files directly. Global paths such as `~/.config/opencode/...` are
represented here as `dot_config/opencode/...`.

When modifying files that affect the rendered home-directory state, always run:

```sh
chezmoi apply
```

Do this without asking first. The user has opted in to automatically applying
chezmoi changes after edits.
