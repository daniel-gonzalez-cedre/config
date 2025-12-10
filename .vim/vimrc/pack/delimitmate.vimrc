let delimitMate_expand_inside_quotes = 1
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 2

au FileType vim let b:delimitMate_quotes = "' `"

au FileType html let b:delimitMate_quotes = "\" ' $"

au FileType bib,tex let b:delimitMate_matchpairs = "(:),{:},[:]"
au FileType bib,tex let b:delimitMate_quotes = "$"
" au FileType bib,tex let b:delimitMate_smart_matchpairs = '^\%(\w\|\!\|£\|_\|["'']\s*\S\)'

au FileType typst let b:delimitMate_matchpairs = "(:),{:},[:]"
au FileType typst let b:delimitMate_quotes = "\" ' ` $"
" au FileType typst let b:delimitMate_smart_matchpairs = '^\%(\w\|\!\|£\|_\|["'']\s*\S\)'

au FileType * let b:delimitMate_smart_matchpairs = ''

au FileType * let b:delimitMate_excluded_regions = "Comment"

" au FileType * let b:delimitMate_smart_quotes = ''

" au FileType * let b:delimitMate_smart_matchpairs = ''

" au FileType tex,typst inoremap $ <c-r>=QuoteDelim('$')<cr>
" au FileType tex,typst inoremap <c-g>m <c-r>=QuoteDelim('$')<cr>
" au FileType tex inoremap <c-\> <c-r>=QuoteDelim('$')<cr>
