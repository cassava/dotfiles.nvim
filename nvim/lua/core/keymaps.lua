local ok, key = pcall(require, "which-key")
if not ok then
  print("Warning: user mappings require which-key plugin.")
  return false
end

local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.localmapleader = "\\"

-- Replacements: -------------------------------------------------------------

-- Don't lose selection when shifting sideways
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Vim [v] -------------------------------------------------------------------
key.register({
  ["<leader>v"] = {
    name = "vim",
    c = { "<cmd>source $MYVIMRC<cr><cmd>PackerSync<cr>", "Source config and sync" },
    e = { "<cmd>vsplit $MYVIMRC<cr>", "Edit config" },
    f = { "<cmd>Telescope find_files cwd=~/.config/nvim<cr>", "Find files in config" },
    h = { "<cmd>Telescope help_tags<cr>", "Search help tags" },
    s = { "<cmd>source $MYVIMRC<cr>", "Source Vim configuration" },
    x = { "<cmd>w<cr><cmd>source %<cr>", "Write and source this file" },
  },
})

-- Search [/] ----------------------------------------------------------------
map("n", "<leader>/<space>", ":Telescope<cr>")
map("n", "<leader>/g", ":Telescope git_files<cr>")
map("n", "<leader>*", function()
  require("telescope.builtin").grep_string({ 
    cwd = require"core.utils".project_dir()
  })
end)
map("v", "<leader>*", function()
  require("telescope.builtin").grep_string({
    search = require"core.utils".get_visual_selection(),
    cwd = require"core.utils".project_dir(),
  })
end)
map("n", "<leader>a", function()
  require("telescope.builtin").live_grep({
    cwd = require"core.utils".project_dir()
  })
end)

-- Git [g] -------------------------------------------------------------------
key.register({
  ["<leader>g"] = {
    name = "git",
    f = { ":Telescope git_files<cr>", "Search files" },
    b = { ":Telescope git_branches<cr>", "Search branches" },
    l = { ":Telescope git_commits<cr>", "Search commits" },
    s = { ":Telescope git_status<cr>", "View status" },
    t = { ":Telescope git_stash<cr>", "View stash" },

    -- Actions
    A = { ":Git commit --amend", "Amend commit" },
    C = { ":Git commit<cr>", "Create commit" },
    F = { ":Git commit --fixup", "Create fixup! commit" },
    R = { ":Git rebase -i ", "Rebase (interactive)" },
  }
})

-- Miscellaneous -------------------------------------------------------------
key.register({
  ["<leader>"] = {
    c = { "<cmd>cclose<cr><cmd>lclose<cr>", "Close quicklist" },
    f = { "gqip", "Format paragraph" },
  }
})

return true
