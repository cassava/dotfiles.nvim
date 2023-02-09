require("config.options")
require("util").bootstrap()
require("lazy").setup({
  spec = {
    { "folke/lazy.nvim", version = "*" },
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
