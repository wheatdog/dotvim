function! VimSetting()
    edit ~/.vim/vimrc
    if has('nvim')
        edit ~/.nvim/nvimrc
    endif
endfunction

function! GutterInfoToggle()
    windo set number!
    windo set relativenumber!
    GitGutterSignsToggle
endfunction

command! -nargs=0 Vset call VimSetting()
command! -nargs=0 Ginfo call GutterInfoToggle()
