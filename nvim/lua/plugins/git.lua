return {
    { "lewis6991/gitsigns.nvim",
      -- ABOUT: Git integration.
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
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },

    { "tpope/vim-fugitive",
      -- ABOUT: Git integration for Vim.
      -- HELP: fugitive.txt
    },

    { "sindrets/diffview.nvim"

      -- cmd = 
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
      cmd = { "GV" },
    },
}
