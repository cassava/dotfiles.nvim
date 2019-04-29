if $TMUX == ""
    noremap <c-space>% :vsplit term://zsh<CR>i
    noremap <c-space>" :botright split term://zsh<CR>i
    noremap <c-space>c :botright split term://zsh<CR>i
    tnoremap <c-space>x <c-\><c-n>:q!<CR>
    tnoremap <c-space><space> <c-\><c-n>
endif

augroup cassava_term_bindings
    autocmd!
    au TermOpen * setlocal nonumber
augroup END

" Return to normal mode
tnoremap <a-space> <c-\><c-n>

" Navigate windows with <a-{hjkl}>
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l
inoremap <a-h> <c-\><c-n><c-w>h
inoremap <a-j> <c-\><c-n><c-w>j
inoremap <a-k> <c-\><c-n><c-w>k
inoremap <a-l> <c-\><c-n><c-w>l
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l

" Move windows with <a-{HJKL}>
tnoremap <a-H> <c-\><c-n><c-w>H
tnoremap <a-J> <c-\><c-n><c-w>J
tnoremap <a-K> <c-\><c-n><c-w>K
tnoremap <a-L> <c-\><c-n><c-w>L
inoremap <a-H> <c-\><c-n><c-w>H
inoremap <a-J> <c-\><c-n><c-w>J
inoremap <a-K> <c-\><c-n><c-w>K
inoremap <a-L> <c-\><c-n><c-w>L
nnoremap <a-H> <c-w>H
nnoremap <a-J> <c-w>J
nnoremap <a-K> <c-w>K
nnoremap <a-L> <c-w>L

" Make a window a new tab with <a-T>
tnoremap <a-T> <c-\><c-n><c-w>T
inoremap <a-T> <c-\><c-n><c-w>T
nnoremap <a-T> <c-w>T

" Switch through tabs with <a-o>
tnoremap <a-o> <c-\><c-n>gt
inoremap <a-o> <c-\><c-n>gt
nnoremap <a-o> gt

" Create zsh sessions with <a-{[,],return}>
noremap <a-return> :tabe term://zsh<cr>i
noremap <a-]> :botright vsplit term://zsh<cr>i
noremap <a-[> :botright split term://zsh<cr>i

" Close windows with <a-w>
tnoremap <a-w> <c-\><c-n><c-w>c
inoremap <a-w> <c-\><c-n><c-w>c
nnoremap <a-w> <c-w>c
