" When going into insert mode it is handy to highlight the current line
" differently
"

augroup cassava_highlight_insertenter
  autocmd!
  au InsertEnter * set cursorline
  au InsertLeave * set nocursorline
augroup END
