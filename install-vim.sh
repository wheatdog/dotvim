#!/bin/sh

VUNDLEDIR=~/.vim/bundle/Vundle.vim
if [ ! -d "$VUNDLEDIR" ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

