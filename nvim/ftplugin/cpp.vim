" In C/C++ projects we mostly use Doxygen to document the code,
" so we will want to autoload the syntax highlighting.
let g:load_doxygen_syntax=1

" Doxygen C++ comments should be continued automatically dammit!
set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,bO:///,O://

" Quickly jump to header or source
augroup cassava_ft_cpp
  autocmd!
  autocmd BufLeave *.{c,cc,cpp} mark C
  autocmd BufLeave *.{h,hpp}    mark H
augroup END
