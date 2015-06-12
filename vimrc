" TODO: 
" -) Maybe I can take note by vim on class. Need to figure out vim notetaking
"    skill, espacially math related...
"    https://github.com/connermcd
"    http://www.reddit.com/r/vim/comments/2r24nm/note_taking_using_vim_and_pandocs/
"    http://www.reddit.com/r/vim/comments/2m2ibe/what_notetaking_plugins_do_you_usesuggest_for_vim/
"    http://endot.org/2014/07/05/my-note-taking-workflow/
" -) Cool stuff: http://bytefluent.com/vivify/
" -) Compile relate: https://github.com/tpope/vim-dispatch
"    http://tilvim.com/2014/03/13/dispatch.html

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NeoBundle Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" Gvim colorscheme
NeoBundle 'sickill/vim-monokai'
NeoBundle 'Solarized'
NeoBundle 'sjl/badwolf'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'Zenburn'

" Fancy Airline
NeoBundle 'bling/vim-airline'

" Browse file easily
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'

" Git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'airblade/vim-gitgutter'

" Compile-related
NeoBundle 'tpope/vim-dispatch'

" Note taking System
NeoBundle 'vim-pandoc/vim-pandoc'
NeoBundle 'vim-pandoc/vim-pandoc-syntax'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.vim/general.vim

