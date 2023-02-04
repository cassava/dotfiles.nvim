return {
  { "nvim-treesitter/nvim-treesitter",
    -- ABOUT: Provide fast and accurate language parsing.
    --        This can be used for syntax highlighting among other things.
    version = false,
    build = ":TSUpdate",
    event = "BufReadPost",
    opts = {
      ensure_installed = "all",
      sync_install = false,
      ignore_install = { "comment" },
      highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { "yaml" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    init = function()
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  { "nvim-treesitter/nvim-treesitter-textobjects",
    -- Manipulate text objects
    keys = { "g>", "g<" },
    config = function()
      require("nvim-treesitter.configs").setup {
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
    end,
  },

  { "nvim-treesitter/nvim-treesitter-refactor",
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup {
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~100.
          },
        },
      }
    end,
  },

  { "p00f/nvim-ts-rainbow",
    -- ABOUT: Parenthesis highlighting
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
      }
    end,
  },

  { "theHamsta/nvim-treesitter-pairs",
    -- ABOUT: Provide language-specific % pairs
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup {
        pairs = {
          enable = true,
          disable = {},
          highlight_pair_events = {"CursorMoved"}, -- when to highlight the pairs, {} to deactivate highlighting
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
      }
    end,
  },

  { "JoosepAlviste/nvim-ts-context-commentstring",
    -- ABOUT: Context based commenting
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter.configs").setup {
        context_commentstring = {
          enable = true
        },
      }
    end,
  },

  { "nvim-treesitter/playground",
    -- ABOUT: Provide a playground, accessible via :TSPlaygroundToggle
    cmd = "TSPlaygroundToggle",
    config = function()
      require "nvim-treesitter.configs".setup {
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        }
      }
    end,
  },
}