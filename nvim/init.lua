require("config.options")
require("util").bootstrap()
require("lazy").setup({
  spec = {
    { "folke/lazy.nvim",
      about = "Plugin manager.",
      version = "*",
      config = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "lazy" },
          callback = function()
            vim.opt_local.list = false
          end
        })
      end,
    },
    { import = "plugins" },
    { import = "plugins.lang" },
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
        "netrw",
        "netrwPlugin",
        "rplugin",
        "tohtml",
        "tutor",
      },
    },
  },
})
require("config.keymaps")
require("config.autocmds")
require("config.neovide")
