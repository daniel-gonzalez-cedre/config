autocmd BufNewFile,BufRead *.tex setfiletype tex
autocmd BufNewFile,BufRead *.bib setfiletype tex
autocmd BufNewFile,BufRead *.tikz setfiletype tex

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
function! IDollar()
    let [l:l,l:c] = searchpairpos('\\(', '', '\\)', 'cbWn')
    return l:l ? '\)' : '\('
endfunction

" au BufNewFile *.tex inoremap $ <C-r>=IDollar()<cr>
" au BufNewFile *.tex vmap $ <C-c>`>a\)<C-c>`<i$<C-c>
" au BufRead *.tex inoremap $ <C-r>=IDollar()<cr>
" au BufRead *.tex vmap $ <C-c>`>a\)<C-c>`<i$<C-c>
" 
" au BufNewFile *.tex inoremap <leader>d $
" au BufNewFile *.tex vnoremap <leader>d <C-c>`>a$<C-c>`<i$<C-c>
" au BufRead *.tex inoremap <leader>d $
" au BufRead *.tex vnoremap <leader>d <C-c>`>a$<C-c>`<i$<C-c>

" old settings

au BufNewFile *.tex imap $ <C-r>=QuoteDelim("$")<CR>
au BufNewFile *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
au BufRead *.tex imap $ <C-r>=QuoteDelim("$")<CR>
au BufRead *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
