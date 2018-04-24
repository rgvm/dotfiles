#!/bin/bash

export SCRIPT_DIR
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing Homebrew packages from Brewfile..."
brew bundle

# change shell to zsh
chsh -s /bin/zsh

# set iTerm2 preferences load directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$SCRIPT_DIR/iterm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "Installing Powerline fonts..."
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Installing Base16 Shell..."
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

echo "Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Setting up symlinks..."
source ./symlinks.sh

echo "Installing vim plugins..."
vim +PlugInstall +qall
