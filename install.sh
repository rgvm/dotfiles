#!/bin/bash

echo "Installing xcode..."
xcode-select --install

echo "Installing Homebrew/Cask..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install caskroom/cask/brew-cask

echo "Installing iTerm2..."
brew cask install iterm2

echo "Installing git..."
brew install git

echo "Installing vim..."
brew install vim

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

echo "Pulling dotfiles..."
git clone https://github.com/rgvm/dotfiles.git ~/dotfiles
cd dotfiles

echo "Setting up symlinks..."
source ./symlinks.sh

echo "Installing vim plugins..."
vim +PlugInstall +qall
