return {
  { "qpkorr/vim-renamer",
    -- ABOUT: Rename files in the system with vim.
    --
    -- Best way to start it is:
    --
    --    nvim +Ren
    --
    -- HELP: renamer.txt
    cmd = { "Renamer" },
  },

  { "raghur/vim-ghost",
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
    init = function()
      vim.g.ghost_autostart = 0
    end
  },
}
