" restore-position.vim
"
" Have Vim jump to the last position when reopening a file
"

augroup cassava_restore_position
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
augroup END
