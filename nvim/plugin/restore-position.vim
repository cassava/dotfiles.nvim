" restore-position.vim
"
" Have Vim jump to the last position when reopening a file
"

if !has("autocmd") || v:version < 600
  finish
endif

augroup cassava_restore_position
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
augroup END
