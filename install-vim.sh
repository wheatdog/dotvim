#!/bin/sh

cd ~

TARGET=vimrc;

if [ -e ".$TARGET" ] && [ ! -L ".$TARGET" ]; then
    mv ".$TARGET" ".$TARGET.old"
    echo "Backup your \"$TARGET\" to \"$HOME/.$TARGET.old\""
fi
if [ ! -L ".$TARGET" ]; then
    ln -s "$HOME/.vim/$TARGET" ".$TARGET"
    echo "Create a symbolic link \"$HOME/.vim/$TARGET\" to \"$HOME/.$TARGET\""
fi

VUNDLEDIR=~/.vim/bundle/Vundle.vim
if [ ! -d "$VUNDLEDIR" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

ln -fs ~/.vim/vimrc ~/.vimrc
