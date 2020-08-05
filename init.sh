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

# install vim plugins
vim

# configure some other mac prefs
echo "\nMac Preferences"
echo "##################"
echo "Set Terminal Settings as default. Terminal > Shell > Use Settings as Default"
echo "Hide Terminal Brackets. Terminal > Edit > Marks > Automatically Mark Prompt Lines (OFF)"
echo "Hide Scrollbar. System Preferences > General > Show scroll bars > When scrolling"
echo "Invert Scroll. System Preferences > Trackpad > Scroll & Zoom > Natural (OFF)"

# SSH Key
echo "\nSSH Keys"
echo "##################"
ssh-keygen -t rsa -b 4096 -C "micneeley14@gmail.com"
echo "Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
ssh-add -K ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
echo "Public key has been copied into your clipboard"

# Misc
echo "\nOther stuff"
echo "##################"
echo "Homebrew has a bug..."
brew cask install adoptopenjdk/openjdk/adoptopenjdk8
