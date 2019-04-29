" dockerfiles.vim
"
" Mark all files that have the format Dockerfile.* as Dockerfiles.
" This is standard practice in a lot of projects.
"

augroup cassava_dockerfiles
  autocmd!
  autocmd BufNewFile,BufRead Dockerfile.* set filetype=dockerfile
augroup END
