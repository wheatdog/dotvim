#Install & Upgrade

1.Install git & vim

```
sudo apt-get install git vim 
```

2.Clone my setting & Set up Vundle

```
git clone https://github.com/wheatdog/dotvim.git ~/.vim
```

```
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

3.Link .vimrc

```
ln -s ~/.vim/vimrc ~/.vimrc
```

4.Happy vimming!

---

#Problem Shooting

If there is some problem, check .vimrc

```vim
set rtp+=~/.vim/bundle/Vundle.vim
```

Then open vim, and run

```
:PluginInstall
```
---

#Reference

[Vundle](https://github.com/gmarik/Vundle.vim)

[Vgod's vimrc](https://github.com/vgod/vimrc)

[我怎麼用 github 與 Vundle 管理 Vim 的設定](http://aknow-work.blogspot.tw/2013/05/github-vundle-vim.html)

[symlink .vimrc](http://superuser.com/questions/438343/put-vimrc-into-the-vim-folder)

