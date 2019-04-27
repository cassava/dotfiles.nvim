" suffixes.vim
"
" This file contains a list of suffixes for Vim to ignore, or prioritize lower
" than other filetypes. This list is used by dirvish and vinegar for
" de-emphesizing these filetypes in the file browser. See :h suffixes.
"
" By default, suffixes=.bak,~,.o,.h,.info,.swp,.obj
" This contains .h, which we do not want de-prioritized, so in this file we
" also reset the suffixes option to not include the .h suffix.
"

set suffixes=.log,.swp,.bak,.info,~

" Binary Types:
set suffixes+=.svg,.jpg,.jpeg,.png                                  " Images
set suffixes+=.pdf,.xls,docx,xoj                                    " Documents
set suffixes+=.zip,.tar,.gz,.bz2,.xz                                " Archives

" Generated Artifacts:
set suffixes+=.retry                                                " Ansible
set suffixes+=.a,.i,.o,.obj,.so,.out,.plist                         " C/C++
set suffixes+=.aux,.fdb_latexmk,.fls,.idx,.ilg,.ind,.toc,.xdy,.ist  " LaTeX
set suffixes+=.pyc                                                  " Python
