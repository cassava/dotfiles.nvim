return {
  { "b0o/incline.nvim",
    event = "BufReadPre",
    opts = {
      hide = {
        cursorline = true,
      }
    },
    init = function()
      vim.opt.laststatus = 3
    end
  },

  { "anuvyklack/pretty-fold.nvim",
    -- ABOUT: Improve folding appearance.
    -- HELP: https://github.com/anuvyklack/pretty-fold.nvim
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

  { "echasnovski/mini.indentscope",
    name = "mini.indentscope",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.indentscope").setup({
        draw = {
          delay = 250,
          animation = require("mini.indentscope").gen_animation.none()
        },
      })
    end,
  },

  { "petertriho/nvim-scrollbar",
    config = true,
  },

  { "kevinhwang91/nvim-hlslens",
    config = function()
      require("scrollbar.handlers.search").setup({
        -- hlslens config overrides
      })
    end
  },

  { "nvim-tree/nvim-web-devicons",
    lazy = true
  },
}
