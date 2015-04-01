" TODO: 
" -) Maybe I can take note by vim on class. Need to figure out vim notetaking
"    skill, espacially math related...
"    https://github.com/connermcd
"    http://www.reddit.com/r/vim/comments/2r24nm/note_taking_using_vim_and_pandocs/
"    http://www.reddit.com/r/vim/comments/2m2ibe/what_notetaking_plugins_do_you_usesuggest_for_vim/
"    http://endot.org/2014/07/05/my-note-taking-workflow/
" -) :make on Windows and Unix, and handle ErrorFormat.
" -) Cool stuff: http://bytefluent.com/vivify/
" -) Try to detect how many spilts in my tab, I would like to fix the number on
"    2, or maybe I could startup my vim by default 2 vertical spilts.


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

" Strange swap files cannot be removed...
set nobackup
set nowritebackup

" Color 
set background=dark
"set cursorline                 " Slow...
colorscheme badwolf
set t_Co=256

" NOTE: Fix stange color in tmux
" base on: http://reyhan.org/2013/12/colours-on-vim-and-tmux.html
set term=screen-256color

" Syntax
syntax enable

let mapleader = "\<Space>"

" Accessing the system clipboard
set clipboard=unnamed

" Long line will not wrap and make scolling horizontally a bit more useful
set nowrap
set sidescroll=5
set listchars+=precedes:←,extends:→

" Improve search
set incsearch

" Show line number
set nu

" GVim font
set guifont=Liberation\ Mono:h14

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

" My Build System
set makeprg=./build.bat
set errorformat=\ %#%f(%l)\ :\ %m " From visual_studio.vim - g:visual_studio_quickfix_errorformat_cpp

" Pandoc and Notes {{{1
command! -nargs=1 Ngrep lvimgrep "<args>" $NOTEDIR/**/*.md
nnoremap <leader>[ :Ngrep 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-n> :NERDTreeToggle<CR>

nnoremap <Leader>/ :e ~/.vim/vimrc<CR>
nnoremap <Leader>. :source ~/.vim/vimrc<CR>  

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :qa<CR>

" Splits related
nmap <silent> vv :vsp<CR><c-n>
nmap <silent> ss :sp<CR><c-n>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Buffer navigation
nmap <silent> tt :enew!<CR>
nmap <silent> th :bprevious!<CR>
nmap <silent> tl :bnext!<CR>
nmap <silent> tj :ls<CR> 
nmap <silent> tk :bd<CR>

" Tab navigation
"nmap <silent> <Leader>l :tabnext<CR>
"nmap <silent> <Leader>h :tabprevious<CR>
"nmap <silent> <Leader>n :tabnew<CR>

" Easy Compile 
" NOTE: To fix ^M ending problem on Windows, I combine following command:
" 
"   :setlocal ma<CR>    :%s/\r//g<CR>   :setlocal nomod<CR>   :setlocal noma<CR> 
"    set modifiable  /   substitution /   set nomodifiable  /  set nomodified
"
" nomodified -> Instead of closing the quickfix buffer by :qa, I can close it only by :q
nnoremap <silent> <leader>c :silent make\|redraw!\|vertical copen 60\|setlocal wrap linebreak\|<CR> <c-w>= :setlocal nonu<CR> :setlocal ma<CR> :%s/\r//g<CR> :setlocal nomod<CR> :setlocal noma<CR> <c-w>h :cc<CR>
nmap <silent> <Leader>j :cn<CR>
nmap <silent> <Leader>k :cp<CR>
nmap <silent> <Leader>l :ccl<CR>

" Insert newline without entering insert mode: by press Enter
nmap <CR> o<Esc>
