# Dotfiles

Installation:

```sh
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply dan1elhughes
```

[Read more about Chezmoi](https://www.chezmoi.io)

## Updating Homebrew bundle

```sh
brew bundle dump -f --file=$CHEZMOI_SOURCE_DIR/lib/Brewfile
```
