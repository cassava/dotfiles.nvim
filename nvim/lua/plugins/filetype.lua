return {
  { "sheerun/vim-polyglot",
    -- ABOUT: Collection of extra file-type plugins.
    enabled = false,
    init = function()
      vim.g.polyglot_disabled = {
        "go",
        "rust",
      }
    end
  },
  { "rust-lang/rust.vim",
    enabled = false,
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 0
    end
  },

  { "simrat39/rust-tools.nvim",
    -- ABOUT: Advanced rust tooling.
    ft = "rust",
  },

  { "fatih/vim-go",
    ft = "go",
    init = function()
      vim.g.go_highlight_trailing_whitespace_error = 0
      vim.g.go_auto_type_info = 1
      vim.g.go_fmt_command = "goimports"
      vim.g.go_fmt_experimental = 1
    end
  },
}
