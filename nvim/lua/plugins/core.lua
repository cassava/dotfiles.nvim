return {
  { "gbprod/yanky.nvim",
    event = "BufReadPost",
    enabled = false,
    config = function()
      -- vim.g.clipboard = {
      --   name = "xsel_override",
      --   copy = {
      --     ["+"] = "xsel --input --clipboard",
      --     ["*"] = "xsel --input --primary",
      --   },
      --   paste = {
      --     ["+"] = "xsel --output --clipboard",
      --     ["*"] = "xsel --output --primary",
      --   },
      --   cache_enabled = 1,
      -- }

      require("yanky").setup({
        highlight = {
          timer = 150,
        },
        ring = {
          storage = "shada"
        },
      })

      vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

      vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
      vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
      vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
      vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

      vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
      vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
      vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
      vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

      vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
      vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

      vim.keymap.set("n", "<leader>P", function()
        require("telescope").extensions.yank_history.yank_history({})
      end, { desc = "Paste from Yanky" })
    end,
  },

  { "ethanholz/nvim-lastplace",
    name = "lastplace",
    opts = {
      lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
      lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
      lastplace_open_folds = true
    }
  },

  { "folke/which-key.nvim",
    -- ABOUT: Provides popup reference for your keybindings.
    name = "which-key",
    version = "*",
    opts = {
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
  },

  { "folke/trouble.nvim",
    -- ABOUT: Error and warnings list.
    config = function()
      local key = require("util").keymapper()
      key.register({
        ["]k"]   = {
          function()
            require("trouble").next({skip_groups = true, jump = true});
          end,
          "Next Trouble"
        },

        ["[k"] = {
          function()
            require("trouble").previous({skip_groups = true, jump = true});
          end,
          "Previous Trouble"
        },

        ["[K"] = {
          function()
            require("trouble").first({skip_groups = true, jump = true});
          end,
          "First Trouble"
        },

        ["]K"] = {
          function()
            require("trouble").last({skip_groups = true, jump = true});
          end,
          "Last Trouble"
        }
      })
    end
  },

  { "folke/todo-comments.nvim",
    name = "todo-comments",
    event = "VeryLazy",
    config = true,
  },

  { "echasnovski/mini.basics",
    opts = {
      options = {
        basic = true,
        extra_ui = true,
        win_borders = "single",
      },
      mappings = {
        basic = true,
        option_toggle_prefix = "",
      }
    },
    config = function(_, opts)
      vim.opt.cursorline = false
      vim.opt.smartindent = false
      vim.opt.cindent = false

      require("mini.basics").setup(opts)
    end
  },

  { "echasnovski/mini.starter",
    config = function(_, opts) require("mini.starter").setup(opts) end,
  },

  { "echasnovski/mini.sessions",
    config = function(_, opts) require("mini.sessions").setup(opts) end,
  },

  { "echasnovski/mini.surround",
    keys = { "sa", "sd", "sf" , "sF", "sh", "sr", "sn" },
    config = function(_, opts) require("mini.surround").setup(opts) end,
  },

  { "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        left = '<c-s-h>',
        right = '<c-s-l>',
        down = '<c-s-j>',
        up = '<c-s-k>',

        -- Move current line in Normal mode
        line_left = '<c-s-h>',
        line_right = '<c-s-l>',
        line_down = '<c-s-j>',
        line_up = '<c-s-k>',
      }
    },
    config = function(_, opts) require("mini.move").setup(opts) end,
  },

  { "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require("mini.pairs").setup(opts)

      vim.keymap.set("i", "<c-v>",
        function()
          vim.g.minipairs_disable = true
          vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
              vim.g.minipairs_disable = false
              return true
            end
          })
          return "<c-v>"
        end,
        { silent = true, noremap = true, expr = true, desc = "Temporarily disable auto-pairing" }
      )
    end,
  },

  { "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function(_, opts) require("mini.ai").setup(opts) end,
  },

  { "echasnovski/mini.align",
    keys = { "ga", "gA" },
    config = function(_, opts) require("mini.align").setup(opts) end,
  },

  { "tpope/vim-unimpaired",
    -- ABOUT: Pairs of handy bracket mappings
    event = "VeryLazy",
    enabled = false,
    config = function()
      local key = require("util").keymapper()

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
  },

  { "tpope/vim-eunuch",
    -- ABOUT: Sugar for the UNIX shell commands that need it most.
    cmd = {
      "Delete",    -- Delete current file from disk
      "Unlink",    -- Delete current file from disk and reload buffer
      "Remove",    -- Alias for :Unlink
      "Move",      -- Like :saveas, but delete the old file afterwards
      "Rename",    -- Like :Move, but relative to current file directory
      "Chmod",     -- Change permissions of current file
      "Mkdir",     -- Create directory [with -p]
      "SudoEdit",  -- Edit a file using sudo
      "SudoWrite", -- Write current file using sudo, uses :SudoEdit
    }
  },

  { "justinmk/vim-dirvish",
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
    init = function()
      vim.g.dirvish_mode = ":sort i@^.*[/]@"
    end,
  },

  { "mg979/vim-visual-multi",
    -- ABOUT: Mutliple cursors.
    -- HELP: visual-multi.txt
    init = function()
      vim.g.VM_leader = "\\"
      vim.g.VM_mouse_mappings = 1
    end,
  },

  { "embear/vim-localvimrc",
    -- ABOUT: Load workspace specific settings.
    -- HELP: localvimrc.txt
    lazy = false,
    init = function()
      vim.g.localvimrc_sandbox = 0
      vim.g.localvimrc_ask = 0
    end,
  },

  { "gpanders/editorconfig.nvim",
    version = "*",
    lazy = false,
    enabled = function() return vim.fn.has("nvim-0.9") == 0 end,
  },
}
