# Dotfiles

Installation:

```sh
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply dan1elhughes
```

[Read more about Chezmoi](https://www.chezmoi.io)

## OpenCode Cursor models

After updating the OpenCode config, sync the Cursor/OpenCode model list with:

```sh
npx -y @rama_nigg/open-cursor@latest sync-models \
  --config ~/.config/opencode/opencode.json \
  --variants \
  --compact
```

Verify the models are available:

```sh
opencode models | grep cursor-acp
```

If this is a new machine/session, authenticate Cursor first:

```sh
cursor-agent login
```
