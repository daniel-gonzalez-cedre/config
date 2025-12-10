" DELIMITER MAPPINGS
augroup delimiter_mappings | au!
  au VimEnter,BufEnter * imap <silent> <c-f>a <
  au VimEnter,BufEnter * imap <silent> <c-g>a >

  au VimEnter,BufEnter * imap <silent> <c-f>b (
  au VimEnter,BufEnter * imap <silent> <c-g>b )

  au VimEnter,BufEnter * imap <silent> <c-f>B {
  au VimEnter,BufEnter * imap <silent> <c-g>B }

  au VimEnter,BufEnter * imap <silent> <c-f>c {
  au VimEnter,BufEnter * imap <silent> <c-g>c }

  au VimEnter,BufEnter * imap <silent> <c-f>r [
  au VimEnter,BufEnter * imap <silent> <c-g>r ]

  au VimEnter,BufEnter * imap <silent> <c-f>g `
  au VimEnter,BufEnter * imap <silent> <c-g>g `

  au VimEnter,BufEnter * imap <silent> <c-f>h #

  au VimEnter,BufEnter * imap <silent> <c-f>t ~

  au VimEnter,BufEnter * imap <silent> <c-f>d $
  au VimEnter,BufEnter * imap <silent> <c-g>d $
  au VimEnter,BufEnter * imap <silent> <c-f><c-d> $
  au VimEnter,BufEnter * imap <silent> <c-g><c-d> $

  au VimEnter,BufEnter * imap <silent> <c-f>e ^

  au VimEnter,BufEnter * imap <silent> <c-f>x *

  au VimEnter,BufEnter * imap <silent> <c-f>u _

  au VimEnter,BufEnter * imap <silent> <c-f>q "
  au VimEnter,BufEnter * imap <silent> <c-g>q "

  au FileType bib,tex inoremap <silent> <c-f>Q ``
  au FileType bib,tex inoremap <silent> <c-g>Q ""
  au FileType bib,tex inoremap <silent> <c-f><c-q> ``""<left><left>

  au VimEnter,BufEnter * onoremap <silent> aa a<
  au VimEnter,BufEnter * xnoremap <silent> aa a<

  au VimEnter,BufEnter * onoremap <silent> ia i<
  au VimEnter,BufEnter * xnoremap <silent> ia i<

  au VimEnter,BufEnter * onoremap <silent> ac a{
  au VimEnter,BufEnter * xnoremap <silent> ac a{

  au VimEnter,BufEnter * onoremap <silent> ic i{
  au VimEnter,BufEnter * xnoremap <silent> ic i{

  au VimEnter,BufEnter * onoremap <silent> ar a[
  au VimEnter,BufEnter * xnoremap <silent> ar a[

  au VimEnter,BufEnter * onoremap <silent> ir i[
  au VimEnter,BufEnter * xnoremap <silent> ir i[

  au VimEnter,BufEnter * onoremap <silent> ag a`
  au VimEnter,BufEnter * xnoremap <silent> ag a`

  au VimEnter,BufEnter * onoremap <silent> ig i`
  au VimEnter,BufEnter * xnoremap <silent> ig i`

  au VimEnter,BufEnter * omap <silent> ad af$
  au VimEnter,BufEnter * xmap <silent> ad af$

  au VimEnter,BufEnter * omap <silent> id if$
  au VimEnter,BufEnter * xmap <silent> id if$

  au FileType markdown,typst omap <silent> au af_
  au FileType markdown,typst xmap <silent> au af_

  au FileType markdown,typst omap <silent> iu if_
  au FileType markdown,typst xmap <silent> iu if_

  au FileType markdown,typst omap <silent> ax af*
  au FileType markdown,typst xmap <silent> ax af*

  au FileType markdown,typst omap <silent> ix if*
  au FileType markdown,typst xmap <silent> ix if*

  au VimEnter,BufEnter * onoremap <silent> a` 2i`
  au VimEnter,BufEnter * xnoremap <silent> a` 2i`

  au VimEnter,BufEnter * onoremap <silent> a' 2i'
  au VimEnter,BufEnter * xnoremap <silent> a' 2i'

  au VimEnter,BufEnter * onoremap <silent> a" 2i"
  au VimEnter,BufEnter * xnoremap <silent> a" 2i"

  au VimEnter,BufEnter * onoremap <silent> iq i"
  au VimEnter,BufEnter * xnoremap <silent> iq i"

  au VimEnter,BufEnter * onoremap <silent> aq 2i"
  au VimEnter,BufEnter * xnoremap <silent> aq 2i"

  au VimEnter,BufEnter * xnoremap <silent> al $o^
  au VimEnter,BufEnter * onoremap <silent> al <cmd>normal val<cr>
  au VimEnter,BufEnter * xnoremap <silent> il g_o^
  au VimEnter,BufEnter * onoremap <silent> il <cmd>normal vil<cr>
augroup END
" au VimEnter * inoremap <silent> ( ()<c-g>U<left>
" au VimEnter * inoremap <silent> [ []<c-g>U<left>
" au VimEnter * inoremap <silent> { {}<c-g>U<left>
" au VimEnter * inoremap <silent> ) <c-g>U<c-r>=ClosePair(')')<cr>
" au VimEnter * inoremap <silent> ] <c-g>U<c-r>=ClosePair(']')<cr>
" au VimEnter * inoremap <silent> } <c-g>U<c-r>=ClosePair('}')<cr>
" au VimEnter * inoremap <silent> > <c-g>U<c-r>=ClosePair('>')<cr>
" au VimEnter * inoremap <silent> " <c-g>U<c-r>=QuoteDelim('"')<cr>
" au VimEnter * " inoremap <silent> ' <c-g>U<c-r>=QuoteDelim("'")<cr>
" au VimEnter * inoremap <silent> ` <c-g>U<c-r>=QuoteDelim('`')<cr>
" au VimEnter * inoremap <silent> <c-g>q ``''<left><left>
" au VimEnter * map <silent> ysiwd ysiw$
