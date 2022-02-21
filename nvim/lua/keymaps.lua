vim.cmd [[
  " Write the file with sudo
  cnoremap w!! execute 'silent! write !sudo /usr/bin/tee % >/dev/null' <bar> edit!

  " Close the quicklist and location list
  nnoremap <silent> <leader>c :cclose<cr>:lclose<cr>

  " Easier yanking and pasting from the clipboard
  xnoremap <leader>y "+y
  xnoremap <leader>Y "+Y
  nnoremap <leader>p "+p
  nnoremap <leader>P "+P

  " Saner Ctrl+L
  nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

  " Open help in a vertical split
  nnoremap <leader>h :vert h<space>

  " Don't lose selection when shifting sideways
  xnoremap < <gv
  xnoremap > >gv

  " Allow me to quickly edit and source my Vimrc.
  nnoremap <leader>ve :vsplit $MYVIMRC<cr>
  nnoremap <leader>vs :source $MYVIMRC<cr>

  " Quickly format current paragraph
  nnoremap <leader>f gqip
]]
