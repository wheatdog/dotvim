" NerdTree setting
let NERDTreeIgnore=['\.DAT*', '\~$']
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Sync NERDTree with current buffer
" NOTE: It is sad that ":NERDTreeToggle ." do not work...
function! CustomNERDTreeToggle()
    if (exists("b:NERDTreeType"))
        silent NERDTreeClose
    else
        silent NERDTree .
    endif
endfunction

