" This way I don't add tabs by accident when writing long strings.
setl expandtab

" Don't show whitespace like I normally do, because gofmt will handle it.
"
" NOTE: Occassionally, you should check strings to make sure they don't
" contain tabs.
setl nolist

" Use markers {{{ and }}} to control folding in Go.
setl fdm=marker

" Map S-k to an equivalent command
nmap <S-k> <Plug>(go-doc-vertical)
nmap <Leader>gi <Plug>(go-info)
nmap <Leader>gd <Plug>(go-def-vertical)

" Function jumping
noremap <buffer> <silent> ]] :<c-u>call GoJumpToDef( v:count1, '' )<CR>
noremap <buffer> <silent> [[ :<c-u>call GoJumpToDef( v:count1, 'b' )<CR>
function! GoJumpToDef( cnt, dir )
    let i = 0
    let pat = '^\(func\|type\)'
    let flags = 'W' . a:dir
    while i < a:cnt && search( pat, flags ) > 0
        let i = i+1
    endwhile
    let @/ = pat
endfunction
