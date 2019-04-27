" nocindent.vim
"
" In some filetypes, vim indents after comma, which is frustrating.
" Here, we specify for which file types we do not want this behavior.
"

augroup plaintext
  autocmd!
  au FileType text      setlocal nocindent
  au FileType gitcommit setlocal nocindent
augroup END
