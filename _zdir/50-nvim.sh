# Define some Neovim aliases.

function vimz() { vim "$(which "$1")" }
alias vimi="nvim ~/.config/nvim/init.lua"
alias vimr="nvim +Renamer"
alias vimg="nvim +GhostStart"
