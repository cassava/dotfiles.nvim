return {
  { "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "json", "json5", "jsonc", "jq", "jsonnet", "hjson" })
      end
    end
  },

  { "jose-elias-alvarez/null-ls.nvim",
    enabled = false,
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.code_actions.gitsigns,
      })
    end
  },

  { "lewis6991/gitsigns.nvim",
    about = "Git signs for the gutter and LSP code actions.",
    opts = {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm = {
        enable = false
      },
    },
  },

  { "tpope/vim-fugitive",
    about = "Classy Git integration for Vim.",
  },

  { "junegunn/gv.vim",
    -- ABOUT: Fast Git commit browser.
    -- USAGE:
    --   :GV     | Open commit browser. You can pass git log options to the command,
    --           | e.g. :GV -S foobar -- plugins. Also works on lines in visual mode.
    --   :GV!    | List commits that affected the current file.
    --   :GV?    | Fill the location list with the revisions of the current file.
    --           | Also works on lines in visual mode.
    --
    -- MAPPINGS:
    --   o       | Display commit contents or diff
    --   O       | Opens a new tab instead
    --   gb      | Launches :Gbrowse
    --   ]]      | Move to next commit
    --   [[      | Move to previous commit
    --   .       | Start command-line with :Git [CURSOR] SHA à la fugitive
    --   q       | to close
    cmd = "GV",
  },

  { "sindrets/diffview.nvim" },

  { "andrewradev/linediff.vim",
    about = [[
      Diff multiple blocks (lines) of text, instead of files.
      If you want to diff files, you can use the internal :diffthis command on
      multiple files. This plugin allows the same for lines.

      Use :LineDiff with multiple selections of lines.
    ]],
    cmd = "LineDiff",
  },
}
