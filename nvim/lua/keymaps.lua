local map = vim.keymap.set

-- Write the file with sudo
map("c", "w!!", "execute 'silent! write !sudo /usr/bin/tee % >/dev/null' <bar> edit!")

-- Close the quicklist and location list
map("n", "<silent>", "<leader>c :cclose<cr>:lclose<cr>")

-- Easier yanking and pasting from the clipboard
map("x", "<leader>y", "\"+y")
map("x", "<leader>Y", "\"+Y")
map("n", "<leader>p", "\"+p")
map("n", "<leader>P", "\"+P")

-- Saner Ctrl+L
map("n", "<leader>l", ":nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>")

-- Open help in a vertical split
map("n", "<leader>h", ":vert h<space>")

-- Don't lose selection when shifting sideways
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Allow me to quickly edit and source my Vimrc.
map("n", "<leader>ve", ":vsplit $MYVIMRC<cr>")
map("n", "<leader>vs", ":source $MYVIMRC<cr>")

-- Quickly format current paragraph
map("n", "<leader>f", "gqip")
