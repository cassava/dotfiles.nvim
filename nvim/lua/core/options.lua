local M = {}

local set = vim.opt
local fn = vim.fn

set.fileencoding = "utf-8"

set.undofile = true     -- support persistent undo via undodir=~/.local/share/nvim/undo
set.startofline = false -- when opening a file, restore to last column of line, not the beginning of the line
set.gdefault = true     -- search/replace globally in a line by default
set.autowriteall = true -- auto save whenever moving out of buffer or quitting
set.more = false        -- do not pipe output through more

set.title = true        -- set the title of the terminal
set.mouse = "a"         -- enable mouse support in normal and visual mode
-- If your terminal supports true colors, you can get nice things!
if vim.env.COLORTERM == "truecolor" then
    set.termguicolors = true
end
set.guifont = "FuraMono Nerd Font:h8"

set.number = true       -- show current line number
set.showcmd = true      -- show incomplete commands
set.visualbell = true   -- disable sounds
set.splitright = true   -- split new vertical windows to the right of the current
set.splitbelow = true   -- split new horizontal windows below the current

-- Display options
set.showmatch = true    -- show matching parenthesis
set.scrolloff = 4       -- keep 4 lines off the edges of the screen when scrolling
set.wrap = false        -- do not wrap by default
set.linebreak = true    -- wrap words instead of characters
set.list = true         -- show tabs and spaces, with the following characters:
set.listchars = {
  extends = '#',
  nbsp = '·',
  tab = '– ',
  trail = '·',
}
set.inccommand = "split" -- show substitution results incrementally (in a split)
set.undolevels = 10000   -- support 10000 instead of 1000 undos

-- Folding:
set.foldlevelstart = -1  -- show all folds open initially
set.foldmethod = "expr"  -- use whatever foldexpr says, e.g. treesitter
set.foldnestmax = 5      -- don't fold forever

-- Text options:
set.autoindent = true   -- automatically adjust indentation
set.smartindent = false -- apparently deprecated for cindent
set.cindent = true      -- react to syntax for indentation
set.expandtab = true    -- don't insert tabs
set.tabstop = 4         -- a tab is four spaces
set.shiftwidth = 4      -- number of spaces to use for auto-indenting
set.softtabstop = 4     -- number of spaces to remove on backspace
set.shiftround = true   -- use multlple of shiftwidth when indenting with < and >
set.completeopt = {
  "menu",       -- Use a popup menu to show possible completions.
  "menuone",    -- Use the popup menu even if there is only one option.
  "preview",    -- Provide extra information in a preview window.
  "noselect",   -- Do not auto-select a match in the menu.
}

-- Formatting
set.formatoptions:append("1")  -- don't end wrapping paragraphs' lines with 1-letter
set.joinspaces = false       -- don't trail a period with two spaces when formatting
set.fileformats = { "unix", "dos", "mac" }

-- Diff settings
set.diffopt:append("vertical")

-- Replace grep program with rg or ag.
if fn.executable('rg') > 0 then
    set.grepprg = "rg --vimgrep --no-heading"
    set.grepformat = { "%f:%l:%c:%m", "%f:%l:%m" }
elseif fn.executable('ag') > 0 then
    set.grepprg = "ag --nogroup --nocolor --ignore-case --column"
    set.grepformat = { "%f:%l:%c:%m", "%f:%l:%m" }
end

set.timeoutlen = 500

return M
