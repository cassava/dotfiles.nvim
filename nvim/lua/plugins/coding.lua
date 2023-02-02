return {
  -- LSP / Completion / Linters / Formatters / Snippets Plugins:

  { "williamboman/mason.nvim",
    -- ABOUT: Manage external editor tooling such as LSP servers,
    -- DAP servers, linters, and formatters through a single interface.
    config = function()
      require("mason").setup()
    end
  },

  { "williamboman/mason-lspconfig.nvim",
    config = true
  },

  { "neovim/nvim-lspconfig",
    -- ABOUT: Built-in LSP configuration mechanism.
  },

  { "tami5/lspsaga.nvim",
    -- LSP enhancer
    disable = true,
    config = true
  },

  { "liuchengxu/vista.vim",
    -- ABOUT: View and search LSP symbols, tags in Vim/NeoVim.
    cmd = "Vista",
  },

  { "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    config = function()
      local cmp = require "cmp"
      local lspkind = require "lspkind"
      local luasnip = require "luasnip"

      cmp.setup {
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<c-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
              buffer = "[buffer]",
              nvim_lsp = "[lsp]",
              luasnip = "[snip]",
              calc = "[calc]",
              path = "[path]",
              cmdline = "[cmdline]",
            })
          }),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "path" },
          { name = "calc" },
          { name = "buffer", keyword_length = 5 },
        },
        enabled = function()
          -- While this function will cause it to be disabled in many cases,
          -- you can always still get completion by using <c-space>.
          local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
          if in_prompt then
            -- this will disable cmp in the Telescope window
            return false
          end
          local context = require("cmp.config.context")
          return not(context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
        end
      }

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end,
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-calc" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "saadparwaiz1/cmp_luasnip" },
    }
  },

  { "onsails/lspkind-nvim",
    -- ABOUT: Provide fancy icons for LSP information, in particular for nvim-cmp.
  },

  { "jose-elias-alvarez/null-ls.nvim",
    -- ABOUT: Provide LSP diagnostics, formatting, and other code actions via
    -- nvim lua plugins.
    -- after = "mason.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- JSON
          null_ls.builtins.formatting.jq,

          -- YAML
          null_ls.builtins.diagnostics.actionlint,
          null_ls.builtins.diagnostics.yamllint,

          -- Python
          null_ls.builtins.diagnostics.pylint,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.formatting.black,

          -- Git
          null_ls.builtins.code_actions.gitsigns,

          -- C++
          null_ls.builtins.formatting.clang_format,

          -- Lua
          null_ls.builtins.formatting.stylua,
        }
      })

      local key = require("util").keymapper()
      key.register({
        [",f"] = { ":lua vim.lsp.buf.format()", "Format file" }
      })
    end,
  },

  { "jayp0521/mason-null-ls.nvim",
    -- ABOUT: Install tools for null-ls automatically with Mason.
    -- after = "null-ls.nvim",
    config = function()
      require("mason-null-ls").setup()
    end,
  },

  { "mfussenegger/nvim-dap"
    -- ABOUT: Client for the Debug Adapter Protocol.
    -- HELP: dap-configuration.txt
  },

  { "L3MON4D3/LuaSnip",
    -- ABOUT: Snippet engine
    -- HELP: luasnip.txt
    event = "InsertEnter",
    config = function()
      local ls = require "luasnip"
      ls.config.set_config {
          history = true,
          updateevents = "TextChanged,TextChangedI",
      }

      -- <c-k> is my expansion key
      -- this will expand the current item or jump to the next item within the snippet.
      vim.keymap.set({"i", "s"}, "<c-k>", function()
          if ls.expand_or_jumpable() then
              ls.expand_or_jump()
          end
      end)

      -- <c-j> is my jump backwards key
      -- this will always move to the previous item within the snippet.
      vim.keymap.set({"i", "s"}, "<c-j>", function()
          if ls.jumpable(-1) then
              ls.jump(-1)
          end
      end)

      vim.keymap.set("i", "<c-l>", function()
          if ls.choice_active() then
              ls.change_choice(1)
          end
      end)

      vim.keymap.set({"n"}, "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<cr>")

      require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets"})
      vim.cmd [[
        command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()
      ]]
    end,
    dependencies = {
      -- Snippet collections
      "rafamadriz/friendly-snippets",
    },
  },

  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      hooks = {
        pre = function()
          require("ts_context_commentstring.internal").update_commentstring({})
        end,
      },
    },
    config = function(_, opts)
      require("mini.comment").setup(opts)
    end,
  },
}
