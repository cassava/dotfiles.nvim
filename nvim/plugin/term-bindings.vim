if $TMUX == ""
    noremap <a-space>% :vsplit term://zsh<CR>i
    noremap <a-space>" :botright split term://zsh<CR>i
    noremap <a-space>c :botright split term://zsh<CR>i
    tnoremap <a-space>x <c-\><c-n>:q!<CR>
    tnoremap <a-space><space> <c-\><c-n>
endif

augroup cassava_term_bindings
    autocmd!
    au TermOpen * setlocal nonumber
augroup END

" Return to normal mode
"tnoremap <a-space> <c-\><c-n>

" Navigate windows with <a-{hjkl}>
tnoremap <silent> <a-h> <c-\><c-n><c-w>h
tnoremap <silent> <a-j> <c-\><c-n><c-w>j
tnoremap <silent> <a-k> <c-\><c-n><c-w>k
tnoremap <silent> <a-l> <c-\><c-n><c-w>l
inoremap <silent> <a-h> <c-\><c-n><c-w>h
inoremap <silent> <a-j> <c-\><c-n><c-w>j
inoremap <silent> <a-k> <c-\><c-n><c-w>k
inoremap <silent> <a-l> <c-\><c-n><c-w>l
nnoremap <silent> <a-h> <c-w>h
nnoremap <silent> <a-j> <c-w>j
nnoremap <silent> <a-k> <c-w>k
nnoremap <silent> <a-l> <c-w>l

" Move windows with <a-{HJKL}>
tnoremap <silent> <a-H> <c-\><c-n><c-w>H
tnoremap <silent> <a-J> <c-\><c-n><c-w>J
tnoremap <silent> <a-K> <c-\><c-n><c-w>K
tnoremap <silent> <a-L> <c-\><c-n><c-w>L
inoremap <silent> <a-H> <c-\><c-n><c-w>H
inoremap <silent> <a-J> <c-\><c-n><c-w>J
inoremap <silent> <a-K> <c-\><c-n><c-w>K
inoremap <silent> <a-L> <c-\><c-n><c-w>L
nnoremap <silent> <a-H> <c-w>H
nnoremap <silent> <a-J> <c-w>J
nnoremap <silent> <a-K> <c-w>K
nnoremap <silent> <a-L> <c-w>L

" Make a window a new tab with <a-T>
tnoremap <silent> <a-T> <c-\><c-n><c-w>T
inoremap <silent> <a-T> <c-\><c-n><c-w>T
nnoremap <silent> <a-T> <c-w>T

" Switch through tabs with <a-o>
tnoremap <silent> <a-o> <c-\><c-n>gt
inoremap <silent> <a-o> <c-\><c-n>gt
nnoremap <silent> <a-o> gt

" Create zsh sessions with <a-{[,],return}>
noremap <silent> <a-return> :tabe term://zsh<cr>i
noremap <silent> <a-]> :botright vsplit term://zsh<cr>i
noremap <silent> <a-[> :botright split term://zsh<cr>i

" Close windows with <a-w>
tnoremap <silent> <a-w> <c-\><c-n><c-w>c
inoremap <silent> <a-w> <c-\><c-n><c-w>c
nnoremap <silent> <a-w> <c-w>c

" Close tabs with <a-W>
noremap <silent> <a-W> :tabclose<cr>
