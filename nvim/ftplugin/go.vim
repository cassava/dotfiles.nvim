" This way I don't add tabs by accident when writing long strings.
setl expandtab

" Don't show whitespace like I normally do, because gofmt will handle it.
"
" NOTE: Occassionally, you should check strings to make sure they don't
" contain tabs.
setl nolist

let g:go_auto_type_info = 0
