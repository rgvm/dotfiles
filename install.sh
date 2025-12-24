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

echo "Installing Powerline fonts..."
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Installing Base16 Shell..."
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell

echo "Configuring Neovim..."
mkdir -p ~/.config/nvim
# install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Setting up symlinks..."
source ./symlinks.sh

echo "Installing vim plugins..."
nvim +PlugInstall +qall
