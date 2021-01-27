" Neovim configuration
" vim: set textwidth=79 colorcolumn=80 foldmethod=marker foldlevel=0:
"
" Author: Benjamin Morgan
" Usage: Run nvim +PlugUpdate to install and update the list of plugins.
" Requirements:
" - cargo:      euclio/vim-markdown-composer
" - clang:      zchee/deoplete-clang
" - ctags:      ludovicchabant/vim-gutentags
" - cmake:      vhdirk/vim-cmake
" - go:         fatih/vim-go
" - gocode:     zchee/deoplete-go
" - gtm:        git-time-metric/gtm-vim-plugin
" - racer:      sebastianmarkow/deoplete-rust
" - xdotool:    raghur/vim-ghost
"

" ============================================================================= OPTIONS

" Change the mapleader from \ to <space>
let mapleader=' '
let localmapleader='\'

set undofile            " persistent undo via undodir=~/.local/share/nvim/undo
set nostartofline       " keep cursor in the same column if possible
set gdefault            " search/replace globally in a line by default
set title               " change the terminal's title
set autowriteall        " auto save whenever moving out of buffer or quitting

" Display options
set number              " show current line number
set showcmd             " show incomplete commands
set visualbell          " disable sounds
set splitright          " vertical splits open on the right (instead of left)
set showmatch           " show matching parenthesis
set scrolloff=4         " keep 4 lines off the edges of the screen when scrolling
set linebreak           " wrap words instead of characters
set list                " show tabs and spaces, with the following characters:
set listchars=tab:–\ ,trail:·,extends:#,nbsp:·
set mouse=a             " mouse support in normal and visual mode
set inccommand=split    " show substitution results incrementally (in a split)
set undolevels=10000    " support 10000 instead of 1000 undos
set foldlevelstart=1    " show all folds open initially

" If your terminal supports true colors, you can get nice things!
if $COLORTERM == "truecolor"
    set termguicolors
endif

" If your terminal supports it, you can try uncommenting the following.
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Text options
set autoindent          " automatically adjust indentation
set nosmartindent       " apparently deprecated for cindent
set cindent             " react to syntax for indentation
set expandtab           " don't insert tabs
set tabstop=4           " a tab is four spaces
set shiftwidth=4        " number of spaces to use for auto-indenting
set softtabstop=4       " number of spaces to remove on backspace
set shiftround          " use multlple of shiftwidth when indenting with < and >

" Formatting
set formatoptions+=1    " don't end wrapping paragraphs' lines with 1-letter
set nojoinspaces        " don't trail a period with two spaces when formatting
set fileformats=unix,dos,mac

" Diff settings
set diffopt+=vertical

" Replace grep program with rg or ag.
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ============================================================================= PLUGINS
call plug#begin('~/.local/share/nvim/plugged')

" Plug: startify {{{
" About: When starting nvim without any arguments, show something useful!
" Help: startify.txt
Plug 'mhinz/vim-startify'
" }}}

" Plug: dispatch | dispatch-neovim {{{
" About: Run commands asynchronously.
" Usage:
"   :Make[!] [arguments]
"   :Dispatch[!] [options] {program} [arguments]
"   :Start[!]
" Help: dispatch.txt
" Alternatives: neomake
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" }}}

" Plug: deoplete | neoinclude {{{
" About: Deoplete is responsible for autocompletion. On my system it currently
" could work better. But you can give it a try. Some things that are completed
" are pretty handy, others don't work at all.
"
" Usage: automatic
" Help: deoplete.txt neoinclude.txt
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim'
let g:deoplete#enable_at_startup = 0
let g:deoplete#max_menu_width = 50
let g:deoplete#auto_complete_delay = 100
let g:deoplete#auto_complete = 0
let g:deoplete#auto_refresh_delay = 50
let g:deoplete#skip_chars = [';']
" }}}

" Plug: fugitive | signify | gv {{{
"
" About: Git integration for Vim.
" Usage: Use :G<tab> to get an idea of the commands available.
" Help: fugitive.txt
Plug 'tpope/vim-fugitive'

" About: Show source revision changes on the side of buffers.
" Usage: automatic
" Help: signify.txt
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git']

" About: Fast Git commit browser.
" Usage:
"   :GV     | Open commit browser. You can pass git log options to the command,
"           | e.g. :GV -S foobar -- plugins. Also works on lines in visual mode.
"   :GV!    | List commits that affected the current file.
"   :GV?    | Fill the location list with the revisions of the current file.
"           | Also works on lines in visual mode.
"
" Mappings:
"   o       | Display commit contents or diff
"   O       | Opens a new tab instead
"   gb      | Launches :Gbrowse
"   ]]      | Move to next commit
"   [[      | Move to previous commit
"   .       | Start command-line with :Git [CURSOR] SHA à la fugitive
"   q       | to close
Plug 'junegunn/gv.vim'

" About: Git time metrics lets you track how much time you spend in a git
" project. This requires that the executable gtm is installed.
" Usage: If gtm init has been executed in the git repository, then this plugin
" will track times automatically.
if executable('gtm')
    Plug 'git-time-metric/gtm-vim-plugin'
endif
" }}}

" Plug: airline | airline-themes {{{
" About: vim-airline provides the informative bar at the bottom of your vim.
" The themes are necessary to be compatible with multiple colorschemes.
" For best viewing experience, it is recommended to use a NERDfont.
"
" Help: airline.txt
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1     " use the available powerline font
" }}}

" Plug: repeat {{{
" About: Extend repeat command . to mappings.
" This plugin is required by several other plugins to also provide sane repeat
" behavior.
" Help: https://github.com/tpope/vim-repeat
Plug 'tpope/vim-repeat'
" }}}

" Filesystem:

" Plug: dirvish {{{
" About: Minimalist directory viewer.
"
" Dirvish basically dumps a list of paths into a Vim buffer and provides some
" sugar to work with those paths.
"
" It's totally fine to slice, dice, and smash any Dirvish buffer: it will never
" modify the filesystem. If you edit the buffer, Dirvish automatically disables
" conceal so you can see the full text.
"
" Mappings:
"   -    | Open the [count]th parent directory
"   <cr> | Open selected file(s)
"   o    | Open file in new window
"   K    | Show file info
"   p    | Preview file at cursor
"   c-n  | Preview next file
"   c-p  | Preview previous file
" Help: dirvish.txt
Plug 'justinmk/vim-dirvish'
let g:dirvish_mode = ':sort i@^.*[\/]@'
" }}}

" Plug: eunuch {{{
" About: Sugar for the UNIX shell commands that need it the most.
" Usage:
"   :Delete[!]          | Delete current file from disk
"   :Unlink[!]          | Delete current file from disk and reload buffer
"   :Remove[!]          | Alias for :Unlink
"   :Move[!] {file}     | Like :saveas, but delete the old file afterwards
"   :Rename[!] {file}   | Like :Move, but relative to current file directory
"   :Chmod {mode}       | Change permissions of current file
"   :Mkdir[!] [dir]     | Create directory [with -p]
"   :Cfind[!] {args}    | Run find and load results in quicklist
"   :Clocate[!] {args}  | Run locate and load results in quicklist
"   :SudoEdit [file]    | Edit a file using sudo
"   :SudoWrite          | Write current file using sudo; uses :SudoEdit
" Help: eunuch.txt
Plug 'tpope/vim-eunuch'
" }}}

" Plug: renamer {{{
" About: Quickly rename many files using Vim text editing.
" Usage:
"   :Renamer [path]
" Help: renamer.txt
Plug 'qpkorr/vim-renamer'
" }}}

" Motions:

" Plug: !targets {{{
" About: Provide additional text objects.
" Examples:
"   cin)    | Change in parentheses
"   da,     | Delete item in comma-separated list
"Plug 'wellle/targets.vim'
" }}}

" Plug: unimpaired {{{
" About: Pairs of handy braket mappings.
" Help: unimpaired.txt
Plug 'tpope/vim-unimpaired'

" Make moving between issues faster using whatever [q and ]q are mapped to
nmap <m-,> [q
nmap <m-.> ]q
" }}}

" Plug: sneak {{{
" About: Jump to any location specified by two characters.
" Usage:
"   s{char}{char}       | Go to next occurrence of {char}{char}
"   S{char}{char}       | Go to previous occurrence of {char}{char}
"   ;                   | Go to the [count]th next match
"   ,                   | Go to the [count]th previous match
" Help: sneak.txt
Plug 'justinmk/vim-sneak'
" }}}

" Manipulation:

" Plug: tcomment {{{
" About: Provide mappings for commenting and uncommenting code.
" Mappings:
"   gc{motion}  | Toggle block comments
"   gcc         | Toggle block comments for this line
"   gC{motion}  | Toggle line comments
"   gCc         | Toggle line comments for this line
" Help: tcomment.txt
Plug 'tomtom/tcomment_vim'
" }}}

" Plug: surround {{{
" About: Tool for dealing with pairs of surroundings.
" Mappings:
"   ds{char}            | Delete surrounding given by {char}
"   cs{char}{char}      | Change first surround {char} to second {char}
"   ys{motion}{char}    | Surround text object or motion with {char}
"   S{char}             | In visual mode, surround selection with {char}
" Help: surround.txt
Plug 'tpope/vim-surround'
" }}}

" Plug: abolish {{{
" About: Language friendly searches, substitutions and abbreviations.
" Usage:
"   :Abolish [options] {abbreviation} {replacement}
"   :Subvert /{pattern}[/flags]
"   :S /{pattern}[/flags]
" Coercion Mappings:
"   crc         | camelCase
"   crm         | MixedCase
"   crs         | snake_case
"   cru         | SNAKE_UPPERCASE
"   cr-         | dash-case
"   cr.         | dot.case
"   cr<space>   | space case
"   crt         | Title Case
" Help: abolish.txt
Plug 'tpope/vim-abolish'
function! MakeLineTitleCase()
  s/\<./\U&/
  call histdel('search', -1)
endfunction
nnoremap crT :call MakeLineTitleCase()<cr>
" }}}

" Plug: easy-align {{{
" About: Align text by character and motion.
" Usage: ga<motion><character>
" Help: easy-align.txt easyalign
Plug 'junegunn/vim-easy-align'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)
" }}}

" Plug: swap {{{
" About: Reorder delimited items.
" Usage: g<, g>, and gs
" Help: swap.txt
Plug 'machakann/vim-swap'
" }}}

" Plug: vim-visual-multi {{{
" Alternative multiple cursors implementation
Plug 'mg979/vim-visual-multi'
let g:VM_leader = '\'
let g:VM_mouse_mappings = 1
" }}}

" Tools:

" Plug: ghost {{{
" About: Bi-directionally edit text content in the browser with Vim.
" You will need to install the browser plugin for this to work, of course.
"
" Usage:
"   :GhostStart     | Start the server.
" Help: ghost.txt
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
let g:ghost_autostart = 0
" }}}

" Plug: undotree {{{
" About: Provides a graphical representation of the vim undo tree.
" Usage:
"   :UndotreeToggle | Show or close the undo-tree panel
" Mappings:
"   ?               | Show quick help in undotree window
" Help: undotree.txt
Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>
" }}}

" Plug: rainbow_parentheses {{{
" About: Highlight the parenthesis layers differently to help identify opening
" and closing. Is approximate, so often has false positives.
Plug 'junegunn/rainbow_parentheses.vim'
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['<', '>']]
nnoremap <leader>r :RainbowParentheses!!<cr>
" }}}

" Plug: goyo | !limelight {{{
" About: Distraction free writing in Vim.
" Help: goyo.txt
Plug 'junegunn/goyo.vim'

" About: Highlight the line that you are currently editing.
" Plug 'junegunn/limelight.vim'
" }}}

" Plug: peekaboo {{{
" About:
" Peekaboo will show you the contents of the registers on the sidebar when you
" hit " or @ in normal mode or <CTRL-R> in insert mode. The sidebar is
" automatically closed on subsequent key strokes.
"
" Help:
" You can toggle fullscreen mode by pressing spacebar.
"
" Config                 Default         Description
" ---------------------  --------------  --------------------------------------
" g:peekaboo_window      vert bo 30new   Command for creating Peekaboo window
" g:peekaboo_delay       0 (ms)          Delay opening of Peekaboo window
" g:peekaboo_compact     0 (boolean)     Compact display
" g:peekaboo_prefix      Empty (string)  Prefix for key mapping (e.g. <leader>)
" g:peekaboo_ins_prefix  Empty (string)  Prefix for insert mode key mapping
"                                        (e.g. <c-x>)
"
Plug 'junegunn/vim-peekaboo'
" }}}

" Plug: linediff {{{
" About: Diff multiple blocks (lines) of text, instead of files.
" If you want to diff files, you can use the internal :diffthis command on
" multiple files. This plugin allows the same for lines.
"
" Usage: Use :LineDiff with multiple selections of lines.
" Help: linediff.txt
Plug 'andrewradev/linediff.vim'
" }}}

" Plug: ack | visualstar {{{
" About: Provide search functionality for the entire project (i.e. recursive grep
" starting from the current directory), and add a few useful mappings.
"
" Usage: Pass :Ack search arguments for &grepprg command.
" Help: ack.txt
" Note: Consider using mhinz/vim-grepper
Plug 'mileszs/ack.vim'
let g:ackprg=&grepprg
nnoremap <leader>a :Ack<space>
nnoremap <leader>A :Ack --fixed-strings<space>

" About: Extend * and # to also work with visual selections.
" Usage: automatic
" Help: visualstar.txt
Plug 'thinca/vim-visualstar'

" About: Extend <leader>* to use Ack to search across the entire project.
" Note that strings that can be interpreted as regular expressions can have
" cause some problems.
nnoremap <leader>* :Ack! --fixed-strings "<cword>"<cr>
vnoremap <silent> <leader>* :<c-u>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<cr>
  \gvy:Ack! '<c-r><c-r>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\s+', 'g')<cr>'<cr>
  \gV:call setreg('"', old_reg, old_regtype)<cr>
" }}}

" Plug: fzf | fzf.vim {{{
" About: fzf is a fuzzy finder.
" Usage: Press enter on a file to open it, `c-x` to open in a split, `c-v` to
" open in a vertical split. You can switch between splits with `c-w c-w` or use
" `c-w [hjkl]`.
" Help: fzf.txt fzf-vim.txt
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

function! s:with_git_root()
    let root = systemlist('git -C ' . expand('%:p:h') . ' rev-parse --show-toplevel')[0]
    return v:shell_error ? {} : {'dir': root}
endfunction
command! -nargs=* GRg call fzf#vim#ag(<q-args>, s:with_git_root())

nnoremap <silent> <leader>/<space> :GRg<cr>
nnoremap <silent> <leader>/f :Files<cr>
nnoremap <silent> <leader>/g :GFiles -co<cr>
nnoremap <silent> <leader>/a :Buffers<cr>
nnoremap <silent> <leader>/w :Windows<cr>
nnoremap <silent> <leader>/t :Tags<cr>
" }}}

" Plug: gutentags | tagbar {{{
if executable('ctags')
    " About: This just automatically manages the tags for your projects.
    " You may have to create the directory below.
    "
    " Usage: automatic
    " Help: gutentags.txt
    Plug 'ludovicchabant/vim-gutentags'
    let g:gutentags_cache_dir = '~/.cache/tags'

    " About: If you have ctags installed, tagbar can show you the stuff you
    " have in your file, use F8 to toggle it open and closed.
    "
    " Usage: :TagbarToggle
    " Help: tagbar.txt
    Plug 'majutsushi/tagbar'
    nnoremap <leader>t :TagbarToggle<cr>
endif
" }}}

" Plug: ale {{{
" About: ALE provides asynchronous linting and fixing of files.
" Usage:
"   :ALEToggle
" Help: ale.txt
Plug 'dense-analysis/ale'
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '[%linter%] %severity%: %s'
let g:ale_lint_delay = 1000
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'cpp': ['clang-format'],
\  'css': ['prettier'],
\  'python': ['black'],
\}
nnoremap <leader>x :ALEToggle<cr>
nnoremap <leader>k :ALEDetail<cr>
" }}}

" Filetypes:

" Plug: localvimrc [.lvimrc] {{{
" About: Load workspace specific settings.
" Help: localvimrc.txt
Plug 'embear/vim-localvimrc'
let g:localvimrc_sandbox=0          " let local config do dangerous things
let g:localvimrc_ask=0              " don't ask for permission
" }}}

" Plug: editorconfig [.editorconfig] {{{
" About: Support editorconfig.org configurations
" Help: editorconfig.txt
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
" }}}

" Plug: markdown | markdown-composer [*.md] {{{
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toml_frontmatter = 1

if executable('cargo')
    function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        if has('nvim')
            !cargo build --release
        else
            !cargo build --release --no-default-features --features json-rpc
        endif
    endif
    endfunction

    " About: Provide instant preview in a browser window when working on
    "        Markdown.
    " Usage: :ComposerStart
    " Help: markdown-composer.txt
    Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
    let g:markdown_composer_autostart = 0
endif
" }}}

" Plug: deoplete-clang | cmake [*.cpp] {{{
if executable('clang')
    Plug 'zchee/deoplete-clang'
    let g:deoplete#sources#clang#libclang_path = '/usr/lib//libclang.so'
    let g:deoplete#sources#clang#clang_header = '/usr/include/clang'
    let g:deoplete#sources#clang#std = {'c': 'c11', 'cpp': 'c++11' }
endif

" Provides better support for CMake via `:CMake`. After that running `:make`
" will build the project.
if executable('cmake')
    Plug 'vhdirk/vim-cmake'

    nnoremap <leader>m :CMake<cr>:Make<cr>
endif
" }}}

" Plug: go | deoplete-go [*.go] {{{
if executable('go')
    Plug 'fatih/vim-go', { 'for': 'go' }
    let g:go_highlight_trailing_whitespace_error = 0
    let g:go_auto_type_info = 1
    let g:go_fmt_command = "goimports"
    let g:go_fmt_experimental = 1

    if executable('gocode')
        Plug 'zchee/deoplete-go', { 'for': 'go', 'do': 'make' }
    endif
endif
" }}}

" Plug: deoplete-jedi | requirements.txt [*.py] {{{
Plug 'zchee/deoplete-jedi'
Plug 'raimon49/requirements.txt.vim'
" }}}

" Plug: rust | deoplete-rust [*.rs] {{{
Plug 'rust-lang/rust.vim'
if executable('rustfmt')
    let g:rustfmt_autosave = 1
endif

if executable('racer')
    Plug 'sebastianmarkow/deoplete-rust'
    let g:deoplete#sources#rust#racer_binary = system('which racer')
    let g:deoplete#sources#rust#rust_source_path = $RUST_SRC_PATH
endif
" }}}

" Plug: capnp | bats [*.capnp, *.bats] {{{
Plug 'cstrahan/vim-capnp'
Plug 'aliou/bats.vim'
" }}}

" Plug: polyglot [*] {{{
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['go', 'rust']
" }}}

" Colorschemes: {{{
Plug 'altercation/vim-colors-solarized'
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'endel/vim-github-colorscheme'
Plug 'jacoborus/tender.vim'
Plug 'jnurmine/zenburn'
Plug 'nanotech/jellybeans.vim'
Plug 'tomasr/molokai'
Plug 'sjl/badwolf'

Plug 'ayu-theme/ayu-vim'
let g:ayucolor='light'

Plug 'morhetz/gruvbox'
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='hard'
let g:gruvbox_invert_selection=0

function! ToggleBackground()
  if &background ==? 'dark'
    set background=light
  else
    set background=dark
  endif
endfunction
nnoremap <silent> <leader>s :call ToggleBackground()<cr>
" }}}

call plug#end()

" ============================================================================= POST-PLUGIN CONFIGURATION

colorscheme gruvbox
set background=dark

" netrw preview opens on the left
let g:netrw_preview=1

autocmd FileType help wincmd L

" ============================================================================= MAPPINGS

" Write the file with sudo
cnoremap w!! execute 'silent! write !sudo /usr/bin/tee % >/dev/null' <bar> edit!

" Close the quicklist and location list
nnoremap <silent> <leader>c :cclose<cr>:lclose<cr>

" Easier yanking and pasting from the clipboard
xnoremap <leader>y "+y
xnoremap <leader>Y "+Y
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" Saner Ctrl+L
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr>:SignifyRefresh<cr><c-l>

" Open help in a vertical split
nnoremap <leader>h :vert h<space>

" Don't lose selection when shifting sideways
xnoremap < <gv
xnoremap > >gv

" Allow me to quickly edit and source my Vimrc.
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>

" Quickly format current paragraph
nnoremap <leader>f gqip
