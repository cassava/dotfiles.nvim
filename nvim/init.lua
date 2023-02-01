-- vim: set ts=2 sw=2 fdm=expr:
--

local core = require "core"

core.bootstrap()
core.init_options()

require("lazy").setup({
  spec = {
    { "folke/lazy.nvim", version="*" },
    { import = "plugins" },
  },
  defaults = {
    lazy = false
  },
  install = {
    colorscheme = { "nordfox", "slate" }
  },
  checker = {
    enabled = true
  },
  ui = {
    border = "rounded"
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

core.init_keymaps()
core.init_user()
