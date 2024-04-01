" autocmd BufNewFile,BufRead *.tex setfiletype tex
" autocmd BufNewFile,BufRead *.tex set syntax=tex
" autocmd BufNewFile,BufRead *.bib setfiletype tex
" autocmd BufNewFile,BufRead *.bib set syntax=tex
" autocmd BufNewFile,BufRead *.tikz setfiletype tex
" autocmd BufNewFile,BufRead *.tikz set syntax=tex

autocmd BufNewFile,BufRead *.tex inoremap $ <c-r>=QuoteDelim('$')<cr>
autocmd BufNewFile,BufRead *.tex inoremap <c-\> <c-r>=QuoteDelim('$')<cr>
autocmd BufNewFile,BufRead *.tikz inoremap <c-\> <c-r>=QuoteDelim('$')<cr>
autocmd BufNewFile,BufRead *.tex iunmap `
autocmd BufNewFile,BufRead *.tikz iunmap `
