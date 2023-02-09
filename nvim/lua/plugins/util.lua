return {
  { "dstein64/vim-startuptime",
    desc = "Measure startup time.",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },

  { "nvim-lua/plenary.nvim",
    desc = "Library used by other plugins.",
    lazy = true
  },

  { "tpope/vim-repeat",
    desc = "Extend repeat command . to mappings and plugins.",
    event = "VeryLazy"
  },

  { "nvim-lua/popup.nvim",
    desc = "Popup API implmentation is a plugin until merged into neovim.",
    lazy = true
  },

  { "echasnovski/mini.misc",
    desc = "Miscellaneous useful functions.",
    lazy = true
  },
}
