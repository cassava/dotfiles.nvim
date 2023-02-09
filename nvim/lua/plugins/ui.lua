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

  { "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      render = "compact",
    },
    config = function(_, opts)
      require("notify").setup(opts)
      require("telescope").load_extension("notify")
      vim.notify = require("notify")
      vim.keymap.set("n", "<leader>nn", "<cmd>Telescope notify<cr>", { desc = "View notifications "})
      vim.keymap.set("n", "<leader>nl",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        { desc = "Clear all notifications" }
      )
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
    version = false,
    event = "VeryLazy",
    opts = function()
      return {
        draw = {
          delay = 250,
          animation = require("mini.indentscope").gen_animation.none()
        },
      }
    end,
    config = function(_, opts) require("mini.indentscope").setup(opts) end,
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
