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
"" Setting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plugin setting
source ~/.vim/plugin.vim
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

" Cmdmode auto-completion zsh-like
set wildmenu
set wildmode=longest,list,full

" Omni completion 
" http://vim.wikia.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

" Split default
set splitright " When splitting vertically, split to the right
set splitbelow " When splitting horizontally, split below

" Set working directory to the current file
set autochdir

" Accessing the system clipboard, using [gvim -v] and unnamedplus on fedora
if has("win32unix")
    set clipboard=unnamed
elseif has("unix") && !has("win32unix") && has('unnamedplus')
    set clipboard=unnamedplus
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
nnoremap <silent> <Leader>/ :e ~/.vim/vimrc<CR>
nnoremap <silent> <Leader>. :source ~/.vim/vimrc<CR>  

" Cursor moving in current line that is visible in screen
nmap <silent> gl g$
nmap <silent> gh ^

" Esc alternative (inspired by Spacemacs)
map <silent> fd <esc>
inoremap <silent> fd <esc>

" Splits navigation
nmap <silent> vv :vsp<CR>
nmap <silent> ss :sp<CR>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <Leader>r <c-w>R

" File navigation (inspired by Spacemacs)
nnoremap <silent> <Leader>fs :w<CR>
nnoremap <silent> <Leader>fS :wa<CR>
nnoremap <silent> <Leader>qq :qa<CR>
nnoremap <silent> <Leader>qQ :qa!<CR>
nnoremap <silent> <Leader>qs :wqa!<CR>
nnoremap <silent> <Leader>qz :q<CR>

" Buffer navigation
nmap <silent> tt :enew!<CR>
nmap <silent> th :bprevious!<CR>
nmap <silent> tl :bnext!<CR>
nmap <silent> tj :ls<CR> 
nmap <silent> tk :call DeleteBuffer()<CR>

" Error navigation
nmap <silent> <Leader>j :cn<CR>
nmap <silent> <Leader>k :cp<CR>
nmap <silent> <Leader>l :ccl<CR>

" NerdTree
map <silent> <c-n> :call CustomNERDTreeToggle()<CR>

" Easy make
nnoremap <leader>c :Make<CR>

" Git related
nnoremap <silent> <Leader>g :Gstatus<CR>
nnoremap <silent> <Leader>u :Gpush<CR>
nnoremap <silent> <Leader>i :Gpull<CR>
