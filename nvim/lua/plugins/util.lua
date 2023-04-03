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

  { "stevearc/profile.nvim",
    lazy = false,
    config = function()
      local should_profile = os.getenv("NVIM_PROFILE")
      if should_profile then
        require("profile").instrument_autocmds()
        if should_profile:lower():match("^start") then
          require("profile").start("*")
        else
          require("profile").instrument("*")
        end
      end

      local function toggle_profile()
        local prof = require("profile")
        if prof.is_recording() then
          prof.stop()
          vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
            if filename then
              prof.export(filename)
              vim.notify(string.format("Wrote %s", filename))
            end
          end)
        else
          vim.notify("Start profiling...")
          prof.start("*")
        end
      end
      vim.keymap.set("", "<f1>", toggle_profile)
    end
  }
}
