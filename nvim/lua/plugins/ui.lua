return {
  { "b0o/incline.nvim",
    event = "BufReadPre",
    config = true,
    init = function()
      vim.opt.laststatus = 3
    end
  },

  { "anuvyklack/pretty-fold.nvim",
    -- ABOUT: Improve folding appearance.
    -- HELP: https://github.com/anuvyklack/pretty-fold.nvim
    event = "BufReadPost",
    config = true,
    dependencies = {
      "anuvyklack/keymap-amend.nvim",
    }
  },

  { "anuvyklack/fold-preview.nvim",
    -- ABOUT: Preview folds.
    event = "VeryLazy",
    config = true,
    dependencies = {
      "anuvyklack/keymap-amend.nvim",
    }
  },

  { "nvim-lualine/lualine.nvim",
    -- About: Fancy status line with information from various sources.
    config = function()
      require("lualine").setup({
        sections = {
          lualine_c = {
            { 'filename', path=1 }
          }
        }
      })
    end,
  },

  { "akinsho/bufferline.nvim",
    -- ABOUT: Show buffers on the top as tabs.
    -- HELP: bufferline.txt
    enabled = false,
    config = function()
      require("bufferline").setup{}
    end,
  },
}
