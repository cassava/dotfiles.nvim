-- vim: set ts=2 sw=2 fdm=expr:
--

local core = require "core"

core.bootstrap()
core.init_impatient()
core.init_options()

require("packer").startup {
  function(use)
    use { "wbthomason/packer.nvim",
      -- ABOUT: Plugin manager should manage itself.
      config = function()
        -- Whenever we edit this file, update the packer_compiled.lua file
        -- so that the changes take effect next time we run nvim.
        vim.cmd [[
          augroup packer_user_config
            autocmd!
            autocmd BufWritePost $MYVIMRC source <afile> | PackerCompile
          augroup end
        ]]
      end
    }

    use { "lewis6991/impatient.nvim",
      -- ABOUT: Compiles and caches lua code to improve startup speed by a factor of ~10.
    }

    use { "nvim-lua/plenary.nvim",
      -- ABOUT: Lua functions that you and other plugins may need.
    }

    use { "nvim-lua/popup.nvim",
      -- ABOUT: Popup API implementation is a plugin until merged into neovim.
    }

    use { "nathom/filetype.nvim",
      -- ABOUT: Boost startup time
      config = function()
        vim.g.did_load_filetypes = 1
      end,
    }

    use { "antoinemadec/FixCursorHold.nvim",
      -- ABOUT: Cursorhold performance fix until merged into neovim.
      -- ISSUE: https://github.com/neovim/neovim/issues/12587
      config = function()
        vim.g.cursorhold_updatetime = 100
      end,
    }

    use { "kyazdani42/nvim-web-devicons",
      -- ABOUT: Fancy developer icons used in many other plugins.
    }

    use { "nvim-lualine/lualine.nvim",
      -- About: Fancy status line with information from various sources.
      config = function()
        require("lualine").setup()
      end,
    }

    use { "karb94/neoscroll.nvim",
      -- ABOUT: Scroll smoothly when using keyboard shortcuts that move the
      -- screen.
      --
      -- This can be problematic when connected via SSH, so maybe we should
      -- consider diabling it then.
      config = function()
        require("neoscroll").setup()
      end
    }

    use { "akinsho/bufferline.nvim",
      -- ABOUT: Show buffers on the top as tabs.
      -- HELP: bufferline.txt
      disable = true,
      config = function()
        require("bufferline").setup{}
      end,
    }

    use { "folke/trouble.nvim",
      -- ABOUT: Error and warnings list.
      after = "nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }

    use { "nvim-treesitter/nvim-treesitter",
      -- ABOUT: Provide fast and accurate language parsing.
      --        This can be used for syntax highlighting among other things.
      event = "BufRead",
      run = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = "all",
          sync_install = false,
          ignore_install = { "javascript" },
          context_commentstring = {
            enable = true
          },
          highlight = {
            enable = true,
            disable = {},
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = true,
            disable = { "yaml" },
          },
          pairs = {
            enable = true,
            disable = {},
            highlight_pair_events = {"CursorMoved"}, -- when to highlight the pairs, use {} to deactivate highlighting
            highlight_self = true, -- whether to highlight also the part of the pair under cursor (or only the partner)
            goto_right_end = false, -- whether to go to the xend of the right partner or the beginning
            fallback_cmd_normal = "call matchit#Match_wrapper('',1,'n')", -- What command to issue when we can't find a pair (e.g. "normal! %")
            keymaps = {
              goto_partner = "<leader>%",
              delete_balanced = "X",
            },
            delete_balanced = {
              only_on_first_char = false, -- whether to trigger balanced delete when on first character of a pair
              fallback_cmd_normal = nil, -- fallback command when no pair found, can be nil
              longest_partner = false, -- whether to delete the longest or the shortest pair when multiple found.
                                      -- E.g. whether to delete the angle bracket or whole tag in  <pair> </pair>
            }
          },
          rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
          },
          refactor = {
            highlight_definitions = {
              enable = true,
              clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~100.
            },
          },
          textobjects = {
            swap = {
              enable = true,
              swap_next = {
                ["g>"] = "@parameter.inner",
              },
              swap_previous = {
                ["g<"] = "@parameter.inner",
              },
            },
          },
        }
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      end,
      requires = {
        {
          -- Manipulate text objects
          "nvim-treesitter/nvim-treesitter-textobjects",
          after = "nvim-treesitter",
        },
        {
          "nvim-treesitter/nvim-treesitter-refactor",
          after = "nvim-treesitter",
        },
        {
          -- Parenthesis highlighting
          "p00f/nvim-ts-rainbow",
          after = "nvim-treesitter",
        },
        {
          -- Context based commenting
          "JoosepAlviste/nvim-ts-context-commentstring",
          after = "nvim-treesitter",
        },
        {
          -- Provide language-specific % pairs
          "theHamsta/nvim-treesitter-pairs",
          after = "nvim-treesitter",
        },
      }
    }

    use { "lewis6991/gitsigns.nvim",
      -- ABOUT: Git integration.
      config = function()
        require("gitsigns").setup {
          signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
          },
        }
      end,
      requires = {
        "nvim-lua/plenary.nvim"
      },
    }

    use { "anuvyklack/pretty-fold.nvim",
      -- ABOUT: Improve folding appearance.
      -- HELP: https://github.com/anuvyklack/pretty-fold.nvim
      config = function()
        require("pretty-fold").setup{}
        require("pretty-fold.preview").setup()
      end,
      requires = {
        "anuvyklack/nvim-keymap-amend",
      }
    }

    use { "editorconfig/editorconfig-vim",
      -- ABOUT: Support editorconfig.org configurations
      -- HELP: editorconfig.txt
      setup = function()
        vim.g.EditorConfig_exclude_patterns = {"fugitive://.*"}
      end,
    }

    use { "L3MON4D3/LuaSnip",
      -- ABOUT: Snippet engine
      -- HELP: luasnip.txt
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
      requires = {
        -- Snippet collections
        "rafamadriz/friendly-snippets",
      },
    }

    use { "hrsh7th/nvim-cmp",
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
      requires = {
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-calc", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      }
    }

    use { "neovim/nvim-lspconfig",
      -- ABOUT: Built-in LSP configuration mechanism.
      -- NOTE: We can configure this, or we can use nvim-lsp-installer.
    }

    use { "williamboman/nvim-lsp-installer",
      -- ABOUT: LSP manager, so you don't have to do it yourself with nvim-lspconfig.
      config = function()
        local lsp_installer = require("nvim-lsp-installer")
        local on_attach = function(_, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

          require("core").keymapper().register({
            -- Replace Vim standard keybindings to use LSP:
            ["gD"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Goto declaration [lsp]" },
            ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto definition [lsp]" },
            ["gi"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Goto implementation [lsp]" },
            ["gr"] = { "<cmd>lua vim.lsp.buf.references()<cr>", "Show references [lsp]" },
            ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover entity [lsp]" },
            ["<C-k>"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help [lsp]" },
            ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic [lsp]" },
            ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic [lsp]" },

            ["<leader>e"] = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open diagnostics [lsp]" },
            ["<leader>q"] = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Send diagnostics to QuickList [lsp]" },
            ["<leader>wa"] = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add workspace folder [lsp]" },
            ["<leader>wr"] = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove workspace folder [lsp]" },
            ["<leader>wl"] = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "Show workspace folders [lsp]" },
            ["<leader>D"] = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Goto type definition [lsp]" },
            ["<leader>rn"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename entity [lsp]" },
            ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code actions [lsp]" },
            ["<leader>so"] = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", "Search symbols [lsp]" },
          })

          vim.cmd [[ command! LspFormat execute 'lua vim.lsp.buf.formatting()' ]]
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        if ok then
          capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
        else
          print("Warning: cannot load cmp_nvim_lsp, reduced completion capabilities")
        end

        -- Define :Format command to use LSP formatter.
        lsp_installer.on_server_ready(function(server)
          local opts = server:get_default_options()
          opts.on_attach = on_attach
          opts.capabilities = capabilities
          opts.flags = {
            debounce_text_changes = 150,
          }

          if server.name == "rust_analyzer" then
            -- Initialize the LSP via rust-tools instead
            local ok, rust_tools = pcall(require, "rust-tools")
            if ok then
              rust_tools.setup {
                -- The "server" property provided in rust-tools setup function are the
                -- settings rust-tools will provide to lspconfig during init.
                -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
                -- with the user's own settings (opts).
                tools = { -- rust-tools options
                  autoSetHints = true,
                  hover_with_actions = true,
                  inlay_hints = {
                    show_parameter_hints = false,
                    parameter_hints_prefix = "",
                    other_hints_prefix = "",
                  },
                },
                server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
              }
              server:attach_buffers()
              -- Only if standalone support is needed
              rust_tools.start_standalone_if_required()
            else
              server:setup(opts)
            end
          elseif server.name == "sumneko_lua" then
            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            opts.settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT',
                  path = runtime_path,
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = {'vim'},
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = {
                  enable = false,
                },
              }
            }
            server:setup(opts)
          else
            server:setup(opts)
          end
        end)
      end,
    }

    use { "onsails/lspkind-nvim",
      -- ABOUT: Provide fancy icons for LSP information, in particular for nvim-cmp.
    }

    use { "tami5/lspsaga.nvim",
      -- LSP enhancer
      disable = true,
      config = function()
        require("lspsaga").setup()
      end,
    }

    use { "jose-elias-alvarez/null-ls.nvim",
      -- ABOUT: Provide LSP diagnostics, formatting, and other code actions via
      -- nvim lua plugins.
      config = function()
        local null_ls = require "null-ls"
        null_ls.setup{
          sources = {
            -- YAML
            null_ls.builtins.diagnostics.actionlint,
          }
        }
      end,
    }

    use { "folke/which-key.nvim",
      -- ABOUT: Provides popup reference for your keybindings.
      config = function()
        require("which-key").setup {
          plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
              enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
              suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
              operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
              motions = true, -- adds help for motions
              text_objects = true, -- help for text objects triggered after entering an operator
              windows = true, -- default bindings on <c-w>
              nav = true, -- misc bindings to work with windows
              z = true, -- bindings for folds, spelling and others prefixed with z
              g = true, -- bindings for prefixed with g
            },
          },
          -- add operators that will trigger motion and text object completion
          -- to enable all native operators, set the preset / operators plugin above
          operators = { gc = "Comments" },
          key_labels = {
            ["<space>"] = "SPC",
            ["<cr>"] = "RET",
            ["<tab>"] = "TAB",
          },
          icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
          },
          popup_mappings = {
            scroll_down = '<c-d>', -- binding to scroll down inside the popup
            scroll_up = '<c-u>', -- binding to scroll up inside the popup
          },
          window = {
            border = "none", -- none, single, double, shadow
            position = "top", -- bottom, top
            margin = { 0, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0
          },
          layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
          },
          ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
          hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "<cr>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
          show_help = true, -- show help message on the command line when the popup is visible
          triggers = "auto", -- automatically setup triggers
          -- triggers = {"<leader>"} -- or specify a list manually
          triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
          },
        }
      end,
    }

    use { "natecraddock/sessions.nvim",
      -- ABOUT: Makes using sesions easier
      -- USAGE:
      --    :SaveSession .session
      --    :LoadSession .session
      -- HELP: sessions.txt
      config = function()
        require("sessions").setup()
      end
    }

    use { "tpope/vim-unimpaired",
      -- ABOUT: Pairs of handy bracket mappings
      config = function()
        local key = require("core").keymapper()

        -- Next and Previous builtins
        key.register({
          ["[a"]     = ":previous",
          ["]a"]     = ":next",
          ["[A"]     = ":first",
          ["]A"]     = ":last",
          ["[b"]     = ":bprevious",
          ["]b"]     = ":bnext",
          ["[B"]     = ":bfirst",
          ["]B"]     = ":blast",
          ["[l"]     = ":lprevious",
          ["]l"]     = ":lnext",
          ["[L"]     = ":lfirst",
          ["]L"]     = ":llast",
          ["[<C-L>"] = ":lpfile",
          ["]<C-L>"] = ":lnfile",
          ["[q"]     = ":cprevious",
          ["]q"]     = ":cnext",
          ["[Q"]     = ":cfirst",
          ["]Q"]     = ":clast",
          ["[t"]     = ":tprevious",
          ["]t"]     = ":tnext",
          ["[T"]     = ":tfirst",
          ["]T"]     = ":tlast",
          ["[<C-T>"] = ":ptprevious",
          ["]<C-T>"] = ":ptnext",
        }, { preset = true })

        key.register({
          ["[f"] = "Previous file",
          ["]f"] = "Next file",
          ["[n"] = "Previous SCM conflict",
          ["]n"] = "Next SCM conflict",
        }, { preset = true })

        -- Line operations:
        key.register({
          ["[<space>"] = "Add [count] blank lines above",
          ["]<space>"] = "Add [count] blank lines below",

          ["[e"] = "Exchange line with [count] lines above",
          ["]e"] = "Exchange line with [count] lines below",
        }, { preset = true })

        -- Option toggling:
        key.register({
          ["yo"] = {
            name = "toggle options",
            b = "Toggle background",
            c = "Toggle cursorline",
            d = "Toggle diff",
            h = "Toggle hlsearch",
            i = "Toggle ignorecase",
            l = "Toggle list",
            n = "Toggle number",
            r = "Toggle relativenumber",
            p = "Toggle paste",
            u = "Toggle cursorcolumn",
            v = "Toggle virtualedit",
            w = "Toggle wrap",
            x = "Toggle cursorline + cursorcolumn",
          }
        }, { preset = true })

        -- Encoding and decoding:
        local encoding_maps = {
          ["[x"] = "XML encode",
          ["]x"] = "XML decode",
          ["[u"] = "URL encode",
          ["]u"] = "URL decode",
          ["[y"] = "C-String encode",
          ["]y"] = "C-String decode",
          ["[C"] = "C-String encode",
          ["]C"] = "C-String decode",
        }
        key.register(encoding_maps, { mode = "n", preset = true })
        key.register(encoding_maps, { mode = "x", preset = true })

        -- Personal
        key.register({
          ["<m-,>"] = { "[q", "Previous issue" },
          ["<m-.>"] = { "]q", "Next issue" },
        })
      end
    }

    use { "nvim-telescope/telescope.nvim",
      -- ABOUT: Universal fuzzy finder.
      -- USAGE: Run :Telescope and check out the auto-complete.
      config = function()
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("packer")
      end,
      requires = {
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
        },
        {
          "nvim-telescope/telescope-packer.nvim",
        }
      }
    }

    use { "mhinz/vim-startify",
      -- ABOUT: Start screen to show when no file is opened.
      -- HELP: startify.txt
    }

    -------------------------------------------------------------------------------------
    -- Colorschemes {{{

    use { "EdenEast/nightfox.nvim" }

    --[[
    use { "altercation/vim-colors-solarized" }
    use { "ayu-theme/ayu-vim",
      setup = function()
        vim.g.ayucolor = "light"
      end,
    }
    use { "dracula/vim", as = "dracula" }
    use { "endel/vim-github-colorscheme" }
    use { "jacoborus/tender.vim" }
    use { "jnurmine/zenburn" }
    use { "mjlbach/onedark.nvim" }
    use { "morhetz/gruvbox",
      setup = function()
        vim.g.gruvbox_italic = 1
        vim.g.gruvbox_contrast_dark = "hard"
        vim.g.gruvbox_contrast_light = "hard"
        vim.g.gruvbox_invert_selection = 0
      end,
    }
    use { "nanotech/jellybeans.vim" }
    use { "sjl/badwolf" }
    use { "tomasr/molokai" }
    --]]

    -------------------------------------------------------------------------------------

    use { "numToStr/Comment.nvim",
      -- ABOUT: Provides ability to comment out and in sections in code.
      -- MAPPINGS:
      --    `gcc`                Toggles the current line using linewise comment.
      --    `gbc`                Toggles the current line using blockwise comment.
      --    `[count]gcc`         Toggles the number of line given as a prefix-count using linewise.
      --    `[count]gbc`         Toggles the number of line given as a prefix-count using blockwise.
      --    `gc[count]{motion}`  (Op-pending) Toggles the region using linewise comment.
      --    `gb[count]{motion}`  (Op-pending) Toggles the region using blockwise comment.
      -- HELP: https://github.com/numToStr/Comment.nvim
      config = function()
        require("Comment").setup {
          pre_hook = function(ctx)
            -- Only calculate commentstring for tsx filetypes
            if vim.bo.filetype == 'typescriptreact' then
              local U = require('Comment.utils')

              -- Detemine whether to use linewise or blockwise commentstring
              local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'

              -- Determine the location where to calculate commentstring from
              local location = nil
              if ctx.ctype == U.ctype.block then
                location = require('ts_context_commentstring.utils').get_cursor_location()
              elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                location = require('ts_context_commentstring.utils').get_visual_start_location()
              end

              return require('ts_context_commentstring.internal').calculate_commentstring({
                key = type,
                location = location,
              })
            end
          end,
        }
      end
    }

    use { "tpope/vim-fugitive",
      -- ABOUT: Git integration for Vim.
      -- HELP: fugitive.txt"
    }

    use { "junegunn/gv.vim",
      -- ABOUT: Fast Git commit browser.
      -- USAGE:
      --   :GV     | Open commit browser. You can pass git log options to the command,
      --           | e.g. :GV -S foobar -- plugins. Also works on lines in visual mode.
      --   :GV!    | List commits that affected the current file.
      --   :GV?    | Fill the location list with the revisions of the current file.
      --           | Also works on lines in visual mode.
      --
      -- MAPPINGS:
      --   o       | Display commit contents or diff
      --   O       | Opens a new tab instead
      --   gb      | Launches :Gbrowse
      --   ]]      | Move to next commit
      --   [[      | Move to previous commit
      --   .       | Start command-line with :Git [CURSOR] SHA à la fugitive
      --   q       | to close
    }

    use { "tpope/vim-eunuch",
      -- ABOUT: Sugar for the UNIX shell commands that need it most.
      cmd = {
        "Delete",    -- Delete current file from disk
        "Delete!",
        "Unlink",    -- Delete current file from disk and reload buffer
        "Unlink!",
        "Remove",    -- Alias for :Unlink
        "Remove!",
        "Move",      -- Like :saveas, but delete the old file afterwards
        "Move!",
        "Rename",    -- Like :Move, but relative to current file directory
        "Rename!",
        "Chmod",     -- Change permissions of current file
        "Mkdir",     -- Create directory [with -p]
        "Mkdir!",
        "SudoEdit",  -- Edit a file using sudo
        "SudoWrite", -- Write current file using sudo, uses :SudoEdit
      }
    }

    use { "justinmk/vim-dirvish",
      -- ABOUT: Minimalist directory viewer.
      --
      -- Dirvish basically dumps a list of paths into a Vim buffer and provides
      -- some sugar to work with those paths.
      --
      -- It's totally fine to slice, dice, and smash any Dirvish buffer: it
      -- will never modify the filesystem. If you edit the buffer, Dirvish
      -- automatically disables conceal so you can see the full text.
      --
      -- MAPPINGS:
      --   -    | Open the [count]th parent directory
      --   <cr> | Open selected file(s)
      --   o    | Open file in new window
      --   K    | Show file info
      --   p    | Preview file at cursor
      --   c-n  | Preview next file
      --   c-p  | Preview previous file
      -- HELP: dirvish.txt
      --
      setup = function()
        vim.g.dirvish_mode = ":sort i@^.*[/]@"
      end,
    }

    use { "qpkorr/vim-renamer",
      -- ABOUT: Rename files in the system with vim.
      --
      -- Best way to start it is:
      --
      --    nvim +Ren
      --
      -- HELP: renamer.txt
      cmd = {
        "Renamer",
      },
    }

    use { "tpope/vim-dispatch",
      -- ABOUT: Run commands asynchronously.
      -- USAGE:
      --   :Make[!] [arguments]
      --   :Dispatch[!] [options] {program} [arguments]
      --   :Start[!]
      -- HELP: dispatch.txt
      -- ALTERNATIVES: neomake
      --
      requires = {
        {
          "radenling/vim-dispatch-neovim",
          after = "vim-dispatch",
        },
      }
    }

    use { "tpope/vim-repeat",
      -- ABOUT: Extend repeat command . to mappings.
      --
      -- This plugin is required by several other plugins to also provide sane repeat behavior.
      --
      -- HELP: https://github.com/tpope/vim-repeat
    }

    use { "tpope/vim-surround",
      -- ABOUT: Tool for dealing with pairs of surroundings.
      -- MAPPINGS:
      --   ds{char}            | Delete surrounding given by {char}
      --   cs{char}{char}      | Change first surround {char} to second {char}
      --   ys{motion}{char}    | Surround text object or motion with {char}
      --   S{char}             | In visual mode, surround selection with {char}
      -- HELP: surround.txt
      after = "vim-repeat",
    }

    use { "mg979/vim-visual-multi",
      -- ABOUT: Mutliple cursors.
      -- HELP: visual-multi.txt
      setup = function()
        vim.g.VM_leader = "\\"
        vim.g.VM_mouse_mappings = 1
      end,
    }

    use { "embear/vim-localvimrc",
      -- ABOUT: Load workspace specific settings.
      -- HELP: localvimrc.txt
      setup = function()
        vim.g.localvimrc_sandbox = 0
        vim.g.localvimrc_ask = 0
      end,
    }

    use { "mbbill/undotree",
      -- ABOUT: Provides a graphical representation of the vim undo tree.
      -- USAGE:
      --   :UndotreeToggle | Show or close the undo-tree panel
      -- MAPPINGS:
      --   ?               | Show quick help in undotree window
      -- HELP: undotree.txt
      setup = function()
        vim.keymap.set("n", "<leader>u", ":UndotreeToggle<cr>")
      end,
    }

    use { "andrewradev/linediff.vim",
      -- ABOUT: Diff multiple blocks (lines) of text, instead of files.
      -- If you want to diff files, you can use the internal :diffthis command on
      -- multiple files. This plugin allows the same for lines.
      --
      -- USAGE: Use :LineDiff with multiple selections of lines.
      -- HELP: linediff.txt
    }

    use { "thinca/vim-visualstar",
      -- ABOUT: Extend * and # to also work with visual selections.
      -- USAGE: automatic
      -- HELP: visualstar.txt
    }

    use { "ludovicchabant/vim-gutentags",
      -- ABOUT: This automatically manages the tags for your projects.
      -- You may have to create the directory below.
      -- USAGE: Automatic.
      -- HELP: gutentags.txt
      disable = vim.fn.executable("ctags") ~= 1,
      setup = function()
        vim.g.gutentags_cache_dir = "~/.cache/tags"
      end,
    }

    use { "liuchengxu/vista.vim",
      -- ABOUT: View and search LSP symbols, tags in Vim/NeoVim.
    }

    use { "raghur/vim-ghost",
      -- ABOUT: Bi-directionally edit text content in the browser with Vim.
      -- REQUIREMENTS:
      --  * python3 neovim API
      --  * browser addon
      -- HELP: ghost.txt
      run = function()
        vim.fn.system "python3 -m pip install --user --upgrade neovim"
        vim.cmd "GhostInstall"
      end,
      cmd = {
        "GhostStart",
        "GhostInstall",
      },
      setup = function()
        vim.g.ghost_autostart = 0
      end
    }

    ----------------------------------------------------------------------------------

    use { "sheerun/vim-polyglot",
      -- ABOUT: Collection of extra file-type plugins.
      setup = function()
        vim.g.polyglot_disabled = {
          "go",
          "rust",
        }
      end
    }

    use { "rust-lang/rust.vim",
      disable = true,
      setup = function()
        vim.g.rustfmt_autosave = 0
      end
    }

    use { "simrat39/rust-tools.nvim",
      -- ABOUT: Advanced rust tooling.
      -- after = "rust.vim",
    }

    use { "fatih/vim-go",
      setup = function()
        vim.g.go_highlight_trailing_whitespace_error = 0
        vim.g.go_auto_type_info = 1
        vim.g.go_fmt_command = "goimports"
        vim.g.go_fmt_experimental = 1
      end
    }

    core.init_packer()
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
    },
    auto_clean = true,
    compile_on_sync = true,
  },
}

core.init_colorscheme("nordfox", "slate")
core.init_keymaps()
core.init_user()
