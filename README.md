# Michael's `dotfiles`

This repo contains everything I need to replicate my workstation.

- `.Brewfile` - Homebrew installed applications and App Store packages
- `.gitconfig` - My `git` settings and aliases
- `.vimrc` - Vim settings and plugins
- `.zshrc` - Zsh settings and aliases
- `Sauce.terminal` - My Terminal.app default window settings
- `init.sh` - Installation script to set up soft links and install everything in the correct order

Periodically and before installing on a new workstation, run the following to generate an updated `.Brewfile`:

```
brew bundle dump --global -f
```
