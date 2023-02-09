return {
  { "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_ensure_installed({ "go", "gomod", "gosum", "gowork" })
      end
    end
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
