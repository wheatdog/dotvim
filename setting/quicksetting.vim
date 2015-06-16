function! VimSetting()
    edit ~/.vim/vimrc
    if has('nvim')
        edit ~/.nvim/nvimrc
    endif
endfunction

command! -nargs=0 Vset call VimSetting()
