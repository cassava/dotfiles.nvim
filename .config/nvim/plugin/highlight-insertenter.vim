" When going into insert mode it is handy to highlight the current line
" differently
"

highlight CursorLine ctermbg=235
au InsertEnter * set cursorline
au InsertLeave * set nocursorline
