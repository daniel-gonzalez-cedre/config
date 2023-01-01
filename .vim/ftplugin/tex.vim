au BufNewFile *.tex inoremap $ <C-r>=QuoteDelim("$")<CR>
au BufNewFile *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>

au BufRead *.tex inoremap $ <C-r>=QuoteDelim("$")<CR>
au BufRead *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
