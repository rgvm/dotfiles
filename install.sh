#!/bin/bash

export SCRIPT_DIR
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing iTerm2..."
brew cask install iterm2
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$SCRIPT_DIR/iterm"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

echo "Installing vim..."
brew install macvim --with-override-system-vim

echo "Installing tmux..."
brew install tmux

echo "Installing pyenv..."
brew install pyenv

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Installing node..."
brew install node

echo "Installing vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Setting up symlinks..."
source ./symlinks.sh

echo "Installing vim plugins..."
brew install cmake # necessary for YouCompleteMe
vim +PlugInstall +qall
