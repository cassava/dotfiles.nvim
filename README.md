dotfiles.nvim
=============

This my [Neovim](https://github.com/neovim/neovim) configuration.

Most of the configuration should work with standard Vim as well, though
I haven't tested it.

## Custom Keybindings

Some of the custom keybindings I set up are:

- `<leader>t` Toggle tagbar
- `<leader>r` Toggle RainbowParentheses
- `<leader>u` Toggle Undotree
- `<leader>m` Build CMake project

## Troubleshooting

- Use `:CheckHealth` to show the health of your Neovim installation.
- Consider having a look at the Neovim [FAQ](https://github.com/neovim/neovim/wiki/FAQ).

### tmux

If you use Neovim together with [tmux](https://github.com/tmux/tmux), consider adding the following to `~/.tmux.conf`:
```tmux
set -g default-terminal "screen-256color"
set -g mouse on
set -s escape-time 10
```

If tmux does not show colors correctly, then that might be because it didn't recognize
your terminal emulator as supporting them. This occurs for example with PuTTy.
Run tmux with the `-2` flag to force it to use 256 colors:
```bash
tmux -2
```
