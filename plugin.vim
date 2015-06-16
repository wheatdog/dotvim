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

" Surroundings
NeoBundle 'tpope/vim-surround'

" Quick navigation
NeoBundle 'tpope/vim-unimpaired'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
