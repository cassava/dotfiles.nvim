vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c" },
  callback = function()
    -- Continue Doxygen C++ comments automatically
    vim.opt_local.comments = "sO:* -,mO:*  ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://"
    vim.g.load_doxygen_syntax = 1
  end
})

return {
  { "neovim/nvim-lspconfig",
    opts = function(_, opts)
      vim.list_extend(opts.servers, {
        clangd = {},
      })
    end
  },

  { "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "cpp", "c", "cmake", "make", "ninja" })
      end
    end
  },

  { "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.clang_format,
      })
    end
  },

  { "ludovicchabant/vim-gutentags",
    about = "Automatically manages the tags for your projects.",
    event = "VeryLazy",
    cond = vim.fn.executable("ctags") ~= 1,
    build = "mkdir -p ~/.local/state/tags",
    init = function()
      vim.g.gutentags_cache_dir = "~/.local/state/tags"
    end,
  },
}
