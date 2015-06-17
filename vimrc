" vimrc
" Author: Tim Liou (aka. wheatdog)
"
" Inspired by Steve Losh, Tim Pope and others.
"
" TODO: 
" Take a look of these awesome website
" (sjl's vimrc) https://bitbucket.org/sjl/dotfiles/src/e3f758e825299d9f92d4c13946002a38379579ab/vim/vimrc?at=default
" (learn vim the hard way) http://learnvimscriptthehardway.stevelosh.com/
" (tpopes plugin) https://github.com/tpope
" (tpope's config) https://www.youtube.com/watch?v=MGmIJyTf8pg

" NeoBundle --------------------------------------------------------------- {{{

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
" Gvim colorscheme {{{

NeoBundle 'sickill/vim-monokai'
NeoBundle 'Solarized'
NeoBundle 'sjl/badwolf'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'Zenburn'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'w0ng/vim-hybrid'

" }}}
" Fancy Airline {{{

NeoBundle 'bling/vim-airline'

" }}}
" Browse file easily {{{

NeoBundle 'kien/ctrlp.vim'
NeoBundle 'scrooloose/nerdtree'

" }}}
" Git {{{

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'
NeoBundle 'airblade/vim-gitgutter'

" }}}
" Compile-related {{{
NeoBundle 'tpope/vim-dispatch'

" }}}
" Note taking System {{{

NeoBundle 'vim-pandoc/vim-pandoc'
NeoBundle 'vim-pandoc/vim-pandoc-syntax'

" }}}
" Surroundings {{{

NeoBundle 'tpope/vim-surround'

" }}}
" Quick navigation {{{

NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'vasconcelloslf/vim-interestingwords'

" }}}

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" }}}
" General Setting --------------------------------------------------------- {{{

set encoding=utf-8
set smartindent
set autoindent
set tabstop=8                   " A tab is 8 spaces
set expandtab                   " Always uses spaces instead of tabs
set softtabstop=4               " Insert 4 spaces when tab is pressed
set shiftwidth=4                " An indent is 4 spaces
set shiftround                  " Round indent to nearest shiftwidth multiple
set nowrap
set sidescroll=5
set listchars+=extends:❯,precedes:❮
set autowrite
set autoread
set undodir=~/.vim/.vimundo
set undofile
set noswapfile
set incsearch
set nohlsearch
set number
set relativenumber
set splitright
set splitbelow
set autochdir
set wildmenu                    " Cmdmode auto-completion zsh-like
set wildmode=longest,list,full
set colorcolumn=+1
set background=dark

" Leader Key {{{

let mapleader = "\<Space>"

" }}}
" Color scheme {{{

syntax on
silent! colorscheme badwolf

" }}}
" System clipboard {{{

" Accessing the system clipboard, using [gvim -v] and unnamedplus on fedora
if (has("unix") && !has("win32unix") && has('unnamedplus')) || has('nvim')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" }}}
" Cursorline {{{

let uname = system("uname -s")
if uname[:4] ==? "linux"
    " Only show cursorline in the current window and in normal mode.
    augroup cline
        au!
        au WinLeave,InsertEnter * set nocursorline
        au WinEnter,InsertLeave * set cursorline
    augroup END
endif

"}}}
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}
" Autosave {{{

autocmd InsertLeave * :w

"}}}

function! DeleteBuffer() "{{{
    if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1))
        quit
    else
        bp|bd #
    endif
endfunction
" }}}

" }}}
" Plugin Settting --------------------------------------------------------- {{{

" Airline {{{

set laststatus=2
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'

" }}}
" Ctrp {{{

let g:ctrlp_map = '<Leader>p'
let g:ctrlp_working_path_mode = 'ra'

" }}}

" }}}
" Folding ----------------------------------------------------------------- {{{

" TODO: This should be file specific place.
au FileType vim setlocal foldmethod=marker

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldlevelstart=0
set foldtext=MyFoldText()

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

" "Focus" the current line.  Basically:
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
nnoremap <c-z> mzzMzvzz15<c-e>`z

" }}}
" Convenience mapping ----------------------------------------------------- {{{

" Vim edit shortcut {{{

function! VimSetting() "{{{
    edit ~/.vim/vimrc
    if has('nvim')
        edit ~/.nvim/nvimrc
    endif
endfunction

command! -nargs=0 Vset call VimSetting()
" }}}
nnoremap <silent> <leader>/ :Vset<cr>
if has('nvim')
    nnoremap <silent> <leader>. :source ~/.nvim/nvimrc<CR>  
else
    nnoremap <silent> <leader>. :source ~/.vim/vimrc<cr>  
endif

" }}}
" Esc alternative  {{{

" (inspired by spacemacs)
vnoremap <silent> fd <esc>
inoremap <silent> fd <esc>
cnoremap <silent> fd <c-c>

" }}}
" Line navigation {{{

" cursor moving in current line that is visible in screen
nnoremap <silent> gl g$
nnoremap <silent> gh ^

" }}}
" Splits navigation {{{

nnoremap <silent> vv :vsp<cr>
nnoremap <silent> ss :sp<cr>

if has('nvim')
    nnoremap <a-j> <c-w>j
    nnoremap <a-k> <c-w>k
    nnoremap <a-h> <c-w>h
    nnoremap <a-l> <c-w>l
else " terminal vim, alt not work
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-h> <c-w>h
    nnoremap <c-l> <c-w>l
endif

nnoremap <leader>r <c-w>r

" }}}
" Buffer navigation {{{

nnoremap <silent> tt :enew!<cr>
nnoremap <silent> th :bprevious!<cr>
nnoremap <silent> tl :bnext!<cr>
nnoremap <silent> tj :ls<cr> 
nnoremap <silent> tk :call DeleteBuffer()<cr>

" }}}
" Error navigation {{{ 

nnoremap <silent> <leader>j :cn<cr>
nnoremap <silent> <leader>k :cp<cr>
nnoremap <silent> <leader>l :ccl<cr>

" }}}
" File related command {{{

" (inspired by spacemacs)
nnoremap <silent> <leader>fs :w<cr>
nnoremap <silent> <leader>fS :wa<cr>
nnoremap <silent> <leader>qq :qa<cr>
nnoremap <silent> <leader>qQ :qa!<cr>
nnoremap <silent> <leader>qs :wqa!<cr>
nnoremap <silent> <leader>qd :q<cr>

" }}}
" Nerdtree {{{

" from tpope...maybe
map <silent> <c-n> :e .<cr>

" }}}
" Easy make {{{
nnoremap <leader>c :Make<cr>

" }}}
" Git related {{{

nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gk :Gpush<cr>
nnoremap <silent> <leader>gj :Gpull<cr>
" }}}

" }}}
" Mini-plugins ------------------------------------------------------------ {{{
 
" Build system check {{{
" Maybe not a perfect solution, but it work now...
" http://tuxion.com/2011/09/30/vim-makeprg.html

function! BuildSystemCheck()
    if has("win32unix") && filereadable("./build.bat")
        " Deal with Handmade Hero build system
        set makeprg=./build.bat
        set errorformat=\ %#%f(%l)\ :\ %m " From visual_studio.vim - g:visual_studio_quickfix_errorformat_cpp
    elseif uname[:4] ==? "linux"
        set makeprg
        set errorformat
    endif
endfunction

" Check Build System for every buffer
autocmd BufEnter * silent! call BuildSystemCheck()

" }}}

" }}}
