" Debug Macro
let @d = 'o#ifdef DEBUGo#endifko'

" Clean the debug code
" http://vim.1045645.n5.nabble.com/How-to-find-delete-block-between-matching-lines-td5013041.html
function! CleanDebugMessage()
    silent g/#ifdef DEBUG/;/#endif/d
    echo "Clean up debug messages!"
endfunction

