-- vim: set ts=2 sw=2 fdm=expr:
--

local core = require "core"

core.bootstrap()
core.impatient()
core.options()

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
      event = "BufRead",
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
      run = ":TSUpdate",
      event = "BufRead",
      cmd = {
        "TSInstall",
        "TSInstallInfo",
        "TSInstallSync",
        "TSUninstall",
        "TSUpdate",
        "TSUpdateSync",
        "TSDisableAll",
        "TSEnableAll",
      },
      config = function()
        require("nvim-treesitter.configs").setup {
          ensure_installed = "maintained",
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
      event = "BufRead",
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
      end
    }

    use { "junegunn/vim-peekaboo",
      -- ABOUT:
      -- Peekaboo will show you the contents of the registers on the sidebar when you
      -- hit " or @ in normal mode or <CTRL-R> in insert mode. The sidebar is
      -- automatically closed on subsequent key strokes.
      --
      -- USAGE:
      -- You can toggle fullscreen mode by pressing spacebar.
      --
      -- Config                 Default         Description
      -- ---------------------  --------------  --------------------------------------
      -- g:peekaboo_window      vert bo 30new   Command for creating Peekaboo window
      -- g:peekaboo_delay       0 (ms)          Delay opening of Peekaboo window
      -- g:peekaboo_compact     0 (boolean)     Compact display
      -- g:peekaboo_prefix      Empty (string)  Prefix for key mapping (e.g. <leader>)
      -- g:peekaboo_ins_prefix  Empty (string)  Prefix for insert mode key mapping
      --                                        (e.g. <c-x>)
      setup = function()
        vim.g.peekaboo_delay = 500
      end
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
        ls = require "luasnip"
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
      end,
      requires = {
        -- Snippet collections
        "rafamadriz/friendly-snippets",
      },
    }

    use { "saadparwaiz1/cmp_luasnip" }

    use { "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require "cmp"
        local lspkind = require "lspkind"
        local luasnip = require "luasnip"

        cmp.setup {
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
          documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          },
          mapping = {
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
          sources = {
            { name = "buffer" }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          sources = cmp.config.sources({
            { name = "path" }
          }, {
            { name = "cmdline" }
          })
        })
      end,
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-calc" },
        { "hrsh7th/cmp-nvim-lsp-signature-help" },
        { "onsails/lspkind-nvim" },
      }
    }

    use { "williamboman/nvim-lsp-installer",
      -- LSP manager
      event = "BufRead",
      cmd = {
        "LspInstall",
        "LspInstallInfo",
        "LspPrintInstalled",
        "LspRestart",
        "LspStart",
        "LspStop",
        "LspUninstall",
        "LspUninstallAll",
      },
    }

    use { "neovim/nvim-lspconfig",
      -- Built-in LSP
      config = function()
        -- nvim-cmp supports additional completion capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

        local lspconfig = require "lspconfig"
        local on_attach = function(_, bufnr)
          local opts = { noremap = true, silent = true }
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
          vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
        end

        local servers = { 'clangd', 'rust_analyzer', 'pyright', }
        for _, lsp in ipairs(servers) do
          lspconfig[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end
      end,
    }

    use { "sheerun/vim-polyglot" }

    --[[

    use { "tami5/lspsaga.nvim",
      -- LSP enhancer
      event = "BufRead",
      config = function()
        -- require("configs.lsp.lspsaga").config()
      end,
    }

    use { "simrat39/symbols-outline.nvim",
      -- LSP symbols
      cmd = "SymbolsOutline",
      setup = function()
        -- require("configs.symbols-outline").setup()
      end,
    }

    use { "jose-elias-alvarez/null-ls.nvim",
      -- Formatting and linting
      event = "BufRead",
      config = function()
        -- require("user.null-ls").config()
      end,
    }

    --]]

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

    use { "altercation/vim-colors-solarized" }
    use { "arcticicestudio/nord-vim" }
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

    use { "mileszs/ack.vim",
      -- ABOUT: Provide search functionality for the entire project (i.e. recursive grep
      -- starting from the current directory), and add a few useful mappings.
      --
      -- USAGE: Pass :Ack search arguments for &grepprg command.
      -- HELP: ack.txt
      -- NOTE: Consider using mhinz/vim-grepper
      setup = function()
        vim.cmd [[
          let g:ackprg=&grepprg
          nnoremap <leader>a :Ack<space>
          nnoremap <leader>A :Ack --fixed-strings<space>

          " About: Extend <leader>* to use Ack to search across the entire project.
          " Note that strings that can be interpreted as regular expressions can have
          " cause some problems.
          nnoremap <leader>* :Ack! --fixed-strings "<cword>"<cr>
          vnoremap <silent> <leader>* :<c-u>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<cr>
            \gvy:Ack! '<c-r><c-r>=substitute(
            \escape(@", '\.*+$^~[({'), '\_s\+', '\\s+', 'g')<cr>'<cr>
            \gV:call setreg('"', old_reg, old_regtype)<cr>
        ]]
      end,
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

    core.initialize()
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

core.colorscheme("nord", "slate")
core.keymaps()
core.user()
