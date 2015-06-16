" TODO: Make vim rock

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugin manager setup
source ~/.vim/plugin.vim

" Plugin setup
source ~/.vim/settings.vim

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

" Color 
set background=dark
set t_Co=256
silent! colorscheme badwolf

" Syntax
syntax enable

" Undo
if has('persistent_undo')
  set undodir=~/.vim/.vimundo
  set undofile
endif

" Disable .swp
set noswapfile

" Leader Key
let mapleader = "\<Space>"

" Long line will not wrap and make scolling horizontally a bit more useful
set nowrap
set sidescroll=5
set listchars+=precedes:←,extends:→

" Improve search
set incsearch
set nohlsearch

" Show line number
set number
set relativenumber

" Cmdmode auto-completion zsh-like
set wildmenu
set wildmode=longest,list,full

" Omni completion 
" http://vim.wikia.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

" Split default
set splitright
set splitbelow

" Set working directory to the current file
set autochdir

" Accessing the system clipboard, using [gvim -v] and unnamedplus on fedora
if (has("unix") && !has("win32unix") && has('unnamedplus')) || has('nvim')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Somehow cursorline slow in babun
if uname[:4] ==? "linux"
    set cursorline      
endif

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

" Vim edit shortcut
nnoremap <silent> <Leader>/ :Vset<CR>
nnoremap <silent> <Leader>. :source ~/.vim/vimrc<CR>  

" Cursor moving in current line that is visible in screen
nnoremap <silent> gl g$
nnoremap <silent> gh ^

" Block navigation
nnoremap <silent> <C-j> }
nnoremap <silent> <C-k> {

" Esc alternative (inspired by Spacemacs)
vnoremap <silent> fd <esc>
inoremap <silent> fd <esc>
cnoremap <silent> fd <esc>

" Splits navigation
nnoremap <silent> vv :vsp<CR>
nnoremap <silent> ss :sp<CR>
if has('nvim')
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-h> <C-w>h
    nnoremap <A-l> <C-w>l
else " terminal vim, alt not work
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-h> <C-w>h
    nnoremap <C-l> <C-w>l
endif
nnoremap <Leader>r <c-w>R

" File navigation (inspired by Spacemacs)
nnoremap <silent> <Leader>fs :w<CR>
nnoremap <silent> <Leader>fS :wa<CR>
nnoremap <silent> <Leader>qq :qa<CR>
nnoremap <silent> <Leader>qQ :qa!<CR>
nnoremap <silent> <Leader>qs :wqa!<CR>
nnoremap <silent> <Leader>qz :q<CR>
nnoremap <silent> <Leader>qd :call DeleteBuffer()<CR>

" Buffer navigation
nnoremap <silent> tt :enew!<CR>
nnoremap <silent> th :bprevious!<CR>
nnoremap <silent> tl :bnext!<CR>
nnoremap <silent> tj :ls<CR> 
nnoremap <silent> tk :call DeleteBuffer()<CR>

" Error navigation
nnoremap <silent> <Leader>j :cn<CR>
nnoremap <silent> <Leader>k :cp<CR>
nnoremap <silent> <Leader>l :ccl<CR>

" NerdTree
map <silent> <c-n> :call CustomNERDTreeToggle()<CR>

" Easy make
nnoremap <Leader>c :Make<CR>

" Git related
nnoremap <silent> <Leader>g :Gstatus<CR>
nnoremap <silent> <Leader>u :Gpush<CR>
nnoremap <silent> <Leader>i :Gpull<CR>
