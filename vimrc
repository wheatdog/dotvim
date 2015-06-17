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
"" mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim edit shortcut
nnoremap <silent> <leader>/ :vset<cr>
nnoremap <silent> <leader>. :source ~/.vim/vimrc<cr>  

" cursor moving in current line that is visible in screen
nnoremap <silent> gl g$
nnoremap <silent> gh ^

" esc alternative (inspired by spacemacs)
vnoremap <silent> fd <esc>
inoremap <silent> fd <esc>
cnoremap <silent> fd <c-c>

" splits navigation
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

" file navigation (inspired by spacemacs)
nnoremap <silent> <leader>fs :w<cr>
nnoremap <silent> <leader>fS :wa<cr>
nnoremap <silent> <leader>qq :qa<cr>
nnoremap <silent> <leader>qQ :qa!<cr>
nnoremap <silent> <leader>qs :wqa!<cr>
nnoremap <silent> <leader>qd :q<cr>

" buffer navigation
nnoremap <silent> tt :enew!<cr>
nnoremap <silent> th :bprevious!<cr>
nnoremap <silent> tl :bnext!<cr>
nnoremap <silent> tj :ls<cr> 
nnoremap <silent> tk :call Deletebuffer()<cr>

" error navigation
nnoremap <silent> <leader>j :cn<cr>
nnoremap <silent> <leader>k :cp<cr>
nnoremap <silent> <leader>l :ccl<cr>

" nerdtree
map <silent> <c-n> :call Customnerdtreetoggle()<cr>

" easy make
nnoremap <leader>c :Make<cr>

" git related
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gk :Gpush<cr>
nnoremap <silent> <leader>gj :Gpull<cr>
