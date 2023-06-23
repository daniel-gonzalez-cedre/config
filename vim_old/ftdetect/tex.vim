autocmd BufNewFile,BufRead *.tex setfiletype tex
autocmd BufNewFile,BufRead *.tex set syntax=tex
autocmd BufNewFile,BufRead *.bib setfiletype tex
autocmd BufNewFile,BufRead *.bib set syntax=tex
autocmd BufNewFile,BufRead *.tikz setfiletype tex
autocmd BufNewFile,BufRead *.tikz set syntax=tex

" =============================================================
" au BufNewFile,BufRead *.tex imap $ <C-r>=QuoteDelim("$")<CR>
" =============================================================

" function! IDollar()
"     let cur_line_num = line('.')
"     let cur_col_num = col('.')
"     let [l:l,l:c] = searchpairpos('\\(', '', '\\)', 'cbWn')
"     if l:l
"         call feedkeys('i', '\')
"     else
"         execute "normal! " . 'i\(\)<esc>'
"     endif
" endfunction
" function! IDollar()
    " let [l:l,l:c] = searchpairpos('\\(', '', '\\)', 'cbWn')
    " return l:l ? '\)' : '\('
" endfunction

" au BufNewFile,BufRead *.tex inoremap $ <C-r>=IDollar()<cr>
" au BufNewFile,BufRead *.tex vmap $ <C-c>`>a\)<C-c>`<i$<C-c>
" 
" au BufNewFile,BufRead *.tex inoremap <leader>d $
" au BufNewFile,BufRead *.tex vnoremap <leader>d <C-c>`>a$<C-c>`<i$<C-c>

" old settings

"
" au BufNewFile,BufRead *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
" au BufNewFile,BufRead *.tex xnoremap <expr> $ mode() ==# "V" ? "<C-c>=a$^<C-c>i$<C-c>" : "<C-c>`>a$<C-c>`<i$<C-c>"
