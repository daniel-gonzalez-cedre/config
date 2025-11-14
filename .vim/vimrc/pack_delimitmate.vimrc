let delimitMate_expand_inside_quotes = 1
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2

" au FileType tex,typst inoremap $ <c-r>=QuoteDelim('$')<cr>
" au FileType tex,typst inoremap <c-g>m <c-r>=QuoteDelim('$')<cr>
" au FileType tex inoremap <c-\> <c-r>=QuoteDelim('$')<cr>
" let delimitMate_matchpairs = "(:),{:},[:],<:>"
" au FileType tex,typst let b:delimitMate_matchpairs = "(:),{:},[:],<:>"
" let delimitMate_quotes = "\" ' `"

au FileType vim let delimitMate_quotes = "' `"
au FileType bib,tex let b:delimitMate_quotes = "$"
au FileType bib,tex let b:delimitMate_smart_matchpairs = '^\%(\w\|\!\|£\|_\|["'']\s*\S\)'

au FileType typst let b:delimitMate_quotes = "\" ' ` $"
au FileType typst let b:delimitMate_smart_matchpairs = '^\%(\w\|\!\|£\|_\|["'']\s*\S\)'
