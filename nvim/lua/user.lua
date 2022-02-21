vim.cmd [[
  " netrw preview opens on the left
  let g:netrw_preview=1

  autocmd FileType help wincmd L

  " Neovide
  let g:neovide_cursor_animation_length=0.02

  function! ToggleBackground()
    if &background ==? 'dark'
      set background=light
    else
      set background=dark
    endif
  endfunction
  nnoremap <silent> <leader>s :call ToggleBackground()<cr>
]]
