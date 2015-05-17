" TODO: 
" -) Maybe I can take note by vim on class. Need to figure out vim notetaking
"    skill, espacially math related...
"    https://github.com/connermcd
"    http://www.reddit.com/r/vim/comments/2r24nm/note_taking_using_vim_and_pandocs/
"    http://www.reddit.com/r/vim/comments/2m2ibe/what_notetaking_plugins_do_you_usesuggest_for_vim/
"    http://endot.org/2014/07/05/my-note-taking-workflow/
" -) Cool stuff: http://bytefluent.com/vivify/
" -) Highlight some specific word in comment

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vundle Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Gvim colorscheme
Plugin 'sickill/vim-monokai'
Plugin 'Solarized'
Plugin 'sjl/badwolf'
Plugin 'nanotech/jellybeans.vim'
Plugin 'Zenburn'

" Fancy Airline
Plugin 'bling/vim-airline'

" Browse file easily
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

" Note taking System
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" General Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set smartindent

" Tab specific option
set tabstop=8                   " A tab is 8 spaces
set expandtab                   " Always uses spaces instead of tabs
set softtabstop=4               " Insert 4 spaces when tab is pressed
set shiftwidth=4                " An indent is 4 spaces
set shiftround                  " Round indent to nearest shiftwidth multiple

" NOTE: Fix stange color in tmux
" base on: http://reyhan.org/2013/12/colours-on-vim-and-tmux.html
set term=screen-256color

" Color 
set background=dark
set t_Co=256
colorscheme badwolf

" Syntax
syntax enable

let mapleader = "\<Space>"

if has("win32unix")
    set clipboard=unnamed
elseif has("unix") && !has("win32unix")
    " Accessing the system clipboard, using [gvim -v] and unnamedplus on fedora 21
    set clipboard=unnamedplus
    set cursorline                 " Slow in babun
endif

" Long line will not wrap and make scolling horizontally a bit more useful
set nowrap
set sidescroll=5
set listchars+=precedes:←,extends:→

" Improve search
set incsearch
set nohlsearch

" Show line number
set nu

" Airline setting
set laststatus=2
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'

set splitright " When splitting vertically, split to the right
set splitbelow " When splitting horizontally, split below

" NerdTree setting
let NERDTreeIgnore=['\.DAT*', '\~$']

" Set working directory to the current file
autocmd BufEnter * silent! lcd %:p:h

" Pandoc and Notes {{{1
command! -nargs=1 Ngrep vimgrep "<args>" $NOTEDIR/**/*.md 
nnoremap <leader>[ :Ngrep 

" Check whether QuickFix Window was open or not
function! QuickFixWindowExist()
    let currentID = winnr()
    let found = 0
    for i in range(1,  winnr("$"))
        if (&filetype == "qf")
            let found = 1
            break
        endif
        wincmd w
    endfor
    exe currentID  . "wincmd w"
    return found
endfunction

" Don't open too much window when QuickFix Window isn't open
function! OpenQuickFixList()
    if ((winnr("$") != 1) && !QuickFixWindowExist())
       wincmd o 
    endif
    call GenerateCustomQuickFixList()
endfunction

" Custom QuickFix Window
function! GenerateCustomQuickFixList()
     silent make | redraw! | vertical copen 60 | setlocal wrap linebreak | wincmd = | setlocal nonu | setlocal nobuflisted 
endfunction

" NOTE: To fix ^M ending problem on Windows, I combine following command:
" 
"   :setlocal ma<CR>    :%s/\r//g<CR>   :setlocal nomod<CR>   :setlocal noma<CR> 
"    set modifiable  /   substitution /   set nomodifiable  /  set nomodified
"
" nomodified -> Instead of closing the quickfix buffer by :qa, I can close it only by :q
function! WinFixNewLine()
    setlocal modifiable | %s/\r//g | setlocal nomodified | setlocal nomodifiable 
endfunction

" My Build System and Easy Compile
" http://tuxion.com/2011/09/30/vim-makeprg.html
function! BuildSystemCheck()
    if has("win32unix") && filereadable("./build.bat")
        " Deal with Handmade Hero build system
        set makeprg=./build.bat
        set errorformat=\ %#%f(%l)\ :\ %m " From visual_studio.vim - g:visual_studio_quickfix_errorformat_cpp
        nnoremap <silent> <leader>c :call OpenQuickFixList()\| :call WinFixNewLine()<CR> <c-w>p :cc<CR>
    elseif (has("unix") && !has("win32unix")) || (has("win32unix") && !filereadable("./build.bat"))
        " (has("unix") && !has("win32unix")) -> Linux
        " (has("win32unix"))                 -> Cygwin
        set makeprg=make
        set errorformat=%f:%l:%c:\ %m
        nnoremap <silent> <leader>c :call OpenQuickFixList()<CR> <c-w>p :cc<CR>
    endif
endfunction

" Check Build System for every buffer
autocmd BufEnter * silent! call BuildSystemCheck()

" Deal with buffer Delete issue
function! DeleteBuffer()
    if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1) || &filetype == "qf")
        quit
    else
        bp|bd #
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-n> :NERDTreeToggle<CR>

nnoremap <silent> <Leader>/ :e ~/.vim/vimrc<CR>
nnoremap <silent> <Leader>. :source ~/.vim/vimrc<CR>  

nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :qa<CR>
nnoremap <silent> <Leader>d :call DeleteBuffer()<CR>

" Splits related
nmap <silent> vv :vsp<CR>
nmap <silent> ss :sp<CR>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <Leader>r <c-w>R

" Buffer navigation
nmap <silent> tt :enew!<CR>
nmap <silent> th :bprevious!<CR>
nmap <silent> tl :bnext!<CR>
nmap <silent> tj :ls<CR> 
nmap <silent> tk :bd<CR>

" Error navigation
nmap <silent> <Leader>j :cn<CR>
nmap <silent> <Leader>k :cp<CR>
nmap <silent> <Leader>l :ccl<CR>

" Insert newline without entering insert mode: by press Enter
nmap <CR> o<Esc>
