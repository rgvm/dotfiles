SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

ln -fs $SCRIPT_DIR/bash/bash_profile ~/.bash_profile
ln -fs $SCRIPT_DIR/bash/bashrc ~/.bashrc

ln -fs $SCRIPT_DIR/git/gitconfig ~/.gitconfig
ln -fs $SCRIPT_DIR/git/gitignore_global ~/.gitignore_global

ln -fs $SCRIPT_DIR/tmux/tmux.conf ~/.tmux.conf

ln -fs $SCRIPT_DIR/vim/vimrc ~/.vimrc

ln -fs $SCRIPT_DIR/zsh/zsh_aliases ~/.zsh_aliases
ln -fs $SCRIPT_DIR/zsh/zshrc ~/.zshrc
