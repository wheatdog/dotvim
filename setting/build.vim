"====== [My Build System]
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
