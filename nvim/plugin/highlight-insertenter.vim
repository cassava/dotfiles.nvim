" When going into insert mode it is handy to highlight the current line
" differently
"

highlight CursorLine ctermbg=235
augroup cassava_highlight_insertenter
  autocmd!
  au InsertEnter * set cursorline
  au InsertLeave * set nocursorline
augroup END
