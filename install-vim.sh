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

# Install neobundle
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

vim +NeoBundleInstall +qall

ln -fs ~/.vim/vimrc ~/.vimrc
