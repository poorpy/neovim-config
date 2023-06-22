autocmd BufNewFile,BufRead *.yaml if search('{{.\+}}', 'nw') | setlocal filetype=gotmpl | endif
