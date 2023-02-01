return {

  -- measure startuptime
  { "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  { "tpope/vim-repeat",
    -- ABOUT: Extend repeat command . to mappings.
    --
    -- This plugin is required by several other plugins to also provide sane repeat behavior.
    --
    -- HELP: https://github.com/tpope/vim-repeat
    event = "VeryLazy"
  },

  -- Popup API implementation is a plugin until merged into neovim.
  { "nvim-lua/popup.nvim", lazy = true },

  -- Fancy developer icons used in many other plugins.
  { "nvim-tree/nvim-web-devicons", lazy = true },

}
