autocmd BufNewFile,BufRead *.tex setfiletype tex
autocmd BufNewFile,BufRead *.bib setfiletype tex
autocmd BufNewFile,BufRead *.tikz setfiletype tex

function! IDollar()
  let [l:l,l:c] = searchpairpos('\\(', '', '\\)', 'cbWn')
  return l:l ? '\)' : '\('
endfunction

au BufNewFile *.tex inoremap <silent><expr> $ IDollar()
au BufNewFile *.tex vmap $ <C-c>`>a\)<C-c>`<i$<C-c>
au BufRead *.tex inoremap <silent><expr> $ IDollar()
au BufRead *.tex vmap $ <C-c>`>a\)<C-c>`<i$<C-c>
" au BufNewFile *.tex imap $ <C-r>=QuoteDelim("$")<CR>
" au BufNewFile *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
" au BufRead *.tex imap $ <C-r>=QuoteDelim("$")<CR>
" au BufRead *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
