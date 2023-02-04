
require("config.options")
require("util").bootstrap()
require("lazy").setup({
  spec = {
    { "folke/lazy.nvim", version = "*" },
    { "echasnovski/mini.basics",
      priority = 1000,
      version = false,
      opts = {
       options = {
          basic = true,
          extra_ui = true,
          win_borders = "single",
        },
        mappings = {
          basic = true,
          option_toggle_prefix = "",
        }
      },
      config = function(_, opts)
        vim.opt.cursorline = false
        vim.opt.smartindent = false
        vim.opt.cindent = false

        require("mini.basics").setup(opts)
      end
    },
    { import = "plugins" },
  },
  defaults = {
    lazy = false
  },
  install = {
    colorscheme = { "nordfox", "slate" }
  },
  ui = {
    border = "rounded"
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
require("config.keymaps")
require("config.autocmds")
require("config.neovide")
