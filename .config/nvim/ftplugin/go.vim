" This way I don't add tabs by accident when writing long strings.
setl expandtab

" Don't show whitespace like I normally do, because gofmt will handle it.
"
" NOTE: Occassionally, you should check strings to make sure they don't
" contain tabs.
setl nolist

" Use markers {{{ and }}} to control folding in Go.
setl fdm=marker

let g:go_auto_type_info = 0

" Map S-k to an equivalent command
nnoremap <buffer> <S-k> <Plug>(go-doc-vertical)
nnoremap <buffer> <Leader>gi <Plug>(go-info)
nnoremap <buffer> <Leader>gd <Plug>(go-def-vertical)

" Set up omnicompletion
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
