#!/bin/bash

export SCRIPT_DIR
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing Homebrew packages from Brewfile..."
brew bundle

# change shell to zsh
chsh -s /bin/zsh

echo "Configuring iTerm2 preferences..."
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$SCRIPT_DIR/iterm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "Configuring Neovim..."
mkdir -p ~/.config/nvim

echo "Setting up symlinks..."
source ./symlinks.sh
