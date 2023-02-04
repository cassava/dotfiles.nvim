return {
  { "nvim-telescope/telescope.nvim",
    -- ABOUT: Universal fuzzy finder.
    -- USAGE: Run :Telescope and check out the auto-complete.
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end
      },
      { "debugloop/telescope-undo.nvim",
        keys = { "<leader>u" },
        config = function()
          require("telescope").load_extension("undo")
        end
      },
    }
  },
}
