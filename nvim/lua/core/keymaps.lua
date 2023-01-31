local key = require("core").keymapper()
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

-- Vim Windows [c-w] ---------------------------------------------------------
key.register({
  ["<c-w>"] = {
    -- Add to help
    ["_"] = { "<c-w>_", "Max out height" },
    ["*"] = { "<c-w>_<c-w>|", "Max out width & height" },
  }
})

-- Search [/] ----------------------------------------------------------------
key.register({
  ["<leader>/"] = {
    name = "Search",
    ["/"] = { "<cmd>Telescope<cr>", "Telescope" },
    ["g"] = { "<cmd>Telescope git_files<cr>", "Git files" },
  }
})
key.register({
  ["<leader>*"] = {
    function()
      require("telescope.builtin").grep_string({
        cwd = require"core.utils".project_dir()
      })
    end,
    "Search project for <CWORD>"
  },
  ["<leader>a"] = {
    function()
      require("telescope.builtin").live_grep({
        cwd = require"core.utils".project_dir()
      })
    end,
    "Search project"
  },
})
key.register({
  ["<leader>*"] = {
    function()
      require("telescope.builtin").grep_string({
        search = require"core.utils".get_visual_selection(),
        cwd = require"core.utils".project_dir(),
      })
    end,
    "Search project for selection"
  },
}, { mode = "v" })

-- Git [g] -------------------------------------------------------------------
key.register({
  -- Jump between hunks
  ["]g"] = { map=[[&diff ? ']g' : '<cmd>Gitsigns next_hunk<cr>']], opts={expr=true} },
  ["[g"] = { map=[[&diff ? '[g' : '<cmd>Gitsigns prev_hunk<cr>']], opts={expr=true} },

  ["<leader>g"] = {
    name = "git",

    -- Search
    ["/"] = {
      name = "search",
      f = { "<cmd>Telescope git_files<cr>", "Search files" },
      b = { "<cmd>Telescope git_branches<cr>", "Search branches" },
      l = { "<cmd>Telescope git_commits<cr>", "Search commits" },
      s = { "<cmd>Telescope git_status<cr>", "View status" },
      t = { "<cmd>Telescope git_stash<cr>", "View stash" },
    },

    -- Actions
    A = { "<cmd>Git commit --amend<cr>", "Amend commit" },
    B = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle blame" },
    F = { ":Git commit --fixup", "Create fixup! commit" },
    R = { ":Git rebase -i ", "Rebase (interactive)" },

    -- Popup what's changed in a hunk under cursor
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview hunk" },

    -- Stage/reset individual hunks under cursor in a file
    s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset hunk" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo stage hunk" },

    -- Stage/reset all hunks in a file
    S = { "<cmd>Gitsigns stage_buffer<cr>", "Stage buffer" },
    U = { "<cmd>Gitsigns reset_buffer_index<cr>", "Reset buffer index" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset buffer" },

    -- Open git status in interative window (similar to lazygit)
    g = { "<cmd>Git<cr>", "Status" },

    -- Open commit window (creates commit after writing and saving commit msg)
    C = { "<cmd>Git commit | startinsert<cr>", "Commit" },

    -- Other tools from fugitive
    d = { "<cmd>Git difftool<cr>", "Open difftool" },
    m = { "<cmd>Git mergetool<cr>", "Open mergetool" },
    ['|'] = { "<cmd>Gvdiffsplit<cr>", "Diff this vertical" },
    ['_'] = { "<cmd>Gdiffsplit<cr>", "Diff this horizontal" },

    -- Misc
    c = {
      function()
        local fid = vim.fn.expand("%:p:h")
        local cwd = require"core.utils".project_dir(fid)
        vim.cmd("lcd "..cwd.."")
      end,
      "Cd to project directory"
    },
  }
})

-- Options [o] ---------------------------------------------------------------
key.register({
  ["<leader>o"] = {
    name = "editor",
    c = {
      function()
        local def_width = 80
        if vim.o.colorcolumn == "" then
          if vim.o.textwidth ~= 0 then
            vim.opt.colorcolumn = { vim.o.textwidth }
          else
            vim.opt.colorcolumn = { def_width }
            vim.opt.textwidth = def_width
          end
        else
          vim.opt.colorcolumn = {}
        end
      end,
      "Toggle colorcolumn"
    },
    w = { function() vim.opt.wrap = not vim.o.wrap end, "Toggle wrap" },
    n = { function() vim.opt.number = not vim.o.number end, "Toggle number" },
    r = { function() vim.opt.relativenumber = not vim.o.relativenumber end, "Toggle relativenumber" },
    t = { function() vim.opt.expandtab = not vim.o.expandtab end, "Toggle expandtab" },
    ["<char-62>"] = { -- character '>'
      function()
        vim.opt.tabstop = vim.o.tabstop + 2
        vim.opt.shiftwidth = vim.o.tabstop
      end,
      "Increase tab width by 2"
    },
    ["<char-60>"] = { -- character '<'
      function()
        if vim.o.tabstop >= 2 then
          vim.opt.tabstop = vim.o.tabstop - 2
          vim.opt.shiftwidth = vim.o.tabstop
        end
      end,
      "Reduce tab width by 2",
    },
  }
})

-- Miscellaneous -------------------------------------------------------------
key.register({
  ["<leader>"] = {
    b = { "<cmd>Telescope buffers<cr>", "Search buffers" },
    c = { "<cmd>cclose<cr><cmd>lclose<cr>", "Close quicklist" },
    d = { "<cmd>lcd %:p:h<cr><cmd>pwd<cr>", "Cd to file directory" },
    f = { "gqip", "Format paragraph" },
    h = { "<cmd>Telescope help_tags<cr>", "Search Vim help tags" },
    u = { "<cmd>Telescope undo<cr>", "Undo history" },
  }
}, { silent = false })

return true
