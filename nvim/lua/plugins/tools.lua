return {
  { "qpkorr/vim-renamer",
    desc = "Rename files in the system with: nvim +Renamer",
    cmd = "Renamer",
  },

  { "raghur/vim-ghost",
    desc = "Bi-directionally edit text content in the browser.",
    build = function()
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
