#! /bin/zsh

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# softlink dotfiles
ln -sf ~/Dropbox/dotfiles/.vimrc ~/.vimrc
ln -sf ~/Dropbox/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/Dropbox/dotfiles/.zshrc ~/.zshrc
ln -sf ~/Dropbox/dotfiles/.Brewfile ~/.Brewfile

# install all homebrew applications
brew bundle --global

# install fzf
$(brew --prefix)/opt/fzf/install

# restore terminal settings
open Sauce.terminal

# restore cron jobs
crontab .cronjobs

# install vim plugins
vim

# configure some other mac prefs
echo "Set Terminal Settings as default. Terminal > Shell > Use Settings as Default"
echo "Hide Terminal Brackets. Terminal > Edit > Marks > Automatically Mark Prompt Lines (OFF)"
echo "Hide Scrollbar. System Preferences > General > Show scroll bars > When scrolling"
