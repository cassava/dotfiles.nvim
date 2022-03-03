local map = vim.keymap.set

-- Don't lose selection when shifting sideways
map("x", "<", "<gv")
map("x", ">", ">gv")

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

-- Allow me to quickly edit and source my Vimrc.
map("n", "<leader>ve", ":vsplit $MYVIMRC<cr>")
map("n", "<leader>vs", ":source $MYVIMRC<cr>")

-- Quickly format current paragraph
map("n", "<leader>f", "gqip")

-- Search
map("n", "<leader>/<space>", ":Telescope<cr>")
map("n", "<leader>/h", ":Telescope help_tags<cr>")
map("n", "<leader>/g", ":Telescope git_files<cr>")

-- Git
map("n", "<leader>gf", ":Telescope git_files<cr>")
map("n", "<leader>gb", ":Telescope git_branches<cr>")
map("n", "<leader>gl", ":Telescope git_commits<cr>")
map("n", "<leader>gs", ":Telescope git_status<cr>")
map("n", "<leader>gt", ":Telescope git_stash<cr>")
map("n", "<leader>gC", ":Git commit<cr>")
