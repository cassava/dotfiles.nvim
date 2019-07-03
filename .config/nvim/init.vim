" Neovim configuration
" vim: set tw=100 cc=80 fdm=marker:
"
" Maintainer: Benjamin Morgan
" Usage: Run nvim +PlugUpdate to install and update the list of plugins.
" Requirements:
" - cargo:  euclio/vim-markdown-composer
" - clang:  zchee/deoplete-clang
" - ctags:  ludovicchabant/vim-gutentags
" - cmake:  vhdirk/vim-cmake
" - go:     fatih/vim-go
" - gocode: zchee/deoplete-go
" - gtm:    git-time-metric/gtm-vim-plugin
" - racer:  sebastianmarkow/deoplete-rust
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

" When starting nvim without any arguments, show something useful!
Plug 'mhinz/vim-startify'                                                      " [*]

" Support editorconfig.org configurations
Plug 'editorconfig/editorconfig-vim'                                           " [*]
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" vim-dispatch helps run commands asynchronously.
" Alternatives include: neomake
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'

" vim-commentary provides actions and movements to comment text.
" Consider also using tomtom/tcomment_vim
Plug 'tpope/vim-commentary'

Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'                                                        " [*]

Plug 'justinmk/vim-dirvish'                                                    " [*]
let g:dirvish_mode = ':sort i@^.*[\/]@'

" Plug 'tpope/vim-abolish' {{{
" Provide coercian and substitution with:
"   :Subvert
"   {crs, crm, crc, cru, cr-, cr., cr<space>, crt}
Plug 'tpope/vim-abolish'
function! MakeLineTitleCase()
  s/\<./\U&/
  call histdel('search', -1)
endfunction
nnoremap crT :call MakeLineTitleCase()<cr>
" }}}

" Vim sugar for the UNIX shell commands that need it the most:
"   :{Delete, Unlink, Move, Rename, Chmod, Mkdir, Cfind, Clocate, Lfind, ...}
Plug 'tpope/vim-eunuch'                                                        " [*]

" Jump to any location specified by two characters.
Plug 'justinmk/vim-sneak'                                                      " [*]

" Provides a graphical representation of the vim undo tree.
Plug 'mbbill/undotree'                                                         " [*]
nnoremap <leader>u :UndotreeToggle<cr>

" Alternative multiple cursors implementation
Plug 'mg979/vim-visual-multi'                                                  " [*]
let g:VM_leader = '\'
let g:VM_mouse_mappings = 1

" rainbow_parentheses.vim highlights the parenthesis layers differently.
Plug 'junegunn/rainbow_parentheses.vim'
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['<', '>']]
nnoremap <leader>r :RainbowParentheses!!<cr>

" The following two plugins are really good for visualizing and working with
" files that reside in git repositories. vim-signify shows changes on the
" side, and vim-fugitive allows you to do crazy things, like `:Gdiff` and
" `:Glog`.
Plug 'mhinz/vim-signify'                                                       " [*]
Plug 'tpope/vim-fugitive'                                                      " [*]
let g:signify_vcs_list = ['git']

" gv.vim allows you to use `:GV` to see a particularly nice view of the Git
" history. Press `q` to exit the view.
Plug 'junegunn/gv.vim'

" If you need to align, you will never need to look further:
"   ga<motion><character>
Plug 'junegunn/vim-easy-align'                                                 " [*]
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

" Swap around function arguments with g<, g>, and gs
Plug 'machakann/vim-swap'

" Git time metrics lets you track how much time you spend in a git project.
" This requires that the executable gtm is installed.
if executable('gtm')
    Plug 'git-time-metric/gtm-vim-plugin'
endif

" vim-localvimrc is useful for storing project-specific vim settings.
" Plug 'embear/vim-localvimrc' {{{
Plug 'embear/vim-localvimrc'                                                   " [*]
let g:localvimrc_sandbox=0          " let local config do dangerous things
let g:localvimrc_ask=0              " don't ask for permission
" }}}

" Start this amazing plugin with :Renamer [path] or :Ren [path]
Plug 'qpkorr/vim-renamer'                                                      " [*]

" Allows you to diff blocks of text with :Linediff
Plug 'andrewradev/linediff.vim'

" fzf is a fuzzy finder. Open this fold and see what mappings I created.
" Press enter on a file to open it, `c-x` to open in a split, `c-v` to open
" in a vertical split. You can switch between splits with `c-w c-w` or use
" `c-w [hjkl]`.
" Plug 'junegunn/fzf' | '.../fzf.vim' {{{
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }              " [*]
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

nnoremap <silent> <leader><space><space> :GRg<cr>
nnoremap <silent> <leader><space>f :Files<cr>
nnoremap <silent> <leader><space>g :GFiles -co<cr>
nnoremap <silent> <leader><space>a :Buffers<cr>
nnoremap <silent> <leader><space>w :Windows<cr>
nnoremap <silent> <leader><space>t :Tags<cr>
" }}}

" Plug 'vim-airline/vim-airline' | '.../vim-airline-themes' {{{
" vim-airline provides the informative bar at the bottom of your vim.
" The themes are necessary to be compatible with multiple colorschemes.
Plug 'vim-airline/vim-airline'                                                 " [*]
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts=1     " use the available powerline font
" }}}

if executable('ctags')
    " This just automatically manages the tags for your projects. You may have
    " to create the directory below.
    Plug 'ludovicchabant/vim-gutentags'                                        " [*]
    let g:gutentags_cache_dir = '~/.cache/tags'

    " If you have ctags installed, tagbar can show you the stuff you have in
    " your file, use F8 to toggle it open and closed.
    Plug 'majutsushi/tagbar'
    nnoremap <leader>t :TagbarToggle<cr>
endif

" Plug 'vimwiki/vimwiki' {{{
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/documents/wiki', 'path_html': '~/public/wiki'}]
let g:vimwiki_hl_headers = 1
" }}}

" Plug 'Shougo/deoplete.nvim' | 'Shougo/neoinclude' | 'zchee/...' {{{
" Deoplete is responsible for autocompletion. On my system it currently
" could work better. But you can give it a try. Some things that are
" completed are pretty handy, others don't work at all.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim'
let g:deoplete#enable_at_startup = 0
let g:deoplete#max_menu_width = 50
let g:deoplete#auto_complete_delay = 100
let g:deoplete#auto_complete = 0
let g:deoplete#auto_refresh_delay = 50
let g:deoplete#skip_chars = [';']
" }}}

" Plug 'w0rp/ale' {{{
" ALE provides asynchronous linting.
Plug 'w0rp/ale'
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_delay = 1000
" }}}

" Plug 'chiel92/vim-autoformat' {{{
Plug 'chiel92/vim-autoformat'
let g:autoformat_autoindent = 0
" }}}

" ----------------------------------------------------------------------------- FILETYPE PLUGINS

" Filetype: markdown {{{
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

    Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
endif
" }}}

" Filetype: c/c++ {{{
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

" Automatically format C++ files
augroup autoformat_cpp_settings
    autocmd!
    autocmd FileType cpp  au BufWrite *.{h,cpp} :Autoformat
augroup END
" }}}

" Filetype: go {{{
if executable('go')
    Plug 'fatih/vim-go'
    let g:go_highlight_trailing_whitespace_error = 0
    let g:go_auto_type_info = 1
    let g:go_fmt_command = "goimports"
    let g:go_fmt_experimental = 1

    if executable('gocode')
        Plug 'zchee/deoplete-go', { 'do': 'make' }
    endif
endif
" }}}

" Fileytpe: python {{{
Plug 'zchee/deoplete-jedi'
Plug 'raimon49/requirements.txt.vim'
" }}}

" Filetype: rust {{{
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

Plug 'peter-edge/vim-capnp'

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['go', 'rust']

" Colorschemes:
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

call plug#end()

" ============================================================================= POST-PLUGIN CONFIGURATION

colorscheme gruvbox
set background=dark

" netrw preview opens on the left
let g:netrw_preview=1

" ============================================================================= MAPPINGS

" Saner Ctrl+L
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr>:SignifyRefresh<cr><c-l>
nnoremap <leader>h :vert h<space>

" Don't lose selection when shifting sideways
xnoremap < <gv
xnoremap > >gv

" Allow me to quickly edit and source my Vimrc.
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>
