" DELIMITER MAPPINGS
  augroup delimiter_mappings | au!
    au VimEnter * imap <silent> <c-f>a <
    au VimEnter * imap <silent> <c-g>a >

    au VimEnter * imap <silent> <c-f>b (
    au VimEnter * imap <silent> <c-g>b )

    au VimEnter * imap <silent> <c-f>B {
    au VimEnter * imap <silent> <c-g>B }

    au VimEnter * imap <silent> <c-f>c {
    au VimEnter * imap <silent> <c-g>c }

    au VimEnter * imap <silent> <c-f>r [
    au VimEnter * imap <silent> <c-g>r ]

    au VimEnter * imap <silent> <c-f>g `
    au VimEnter * imap <silent> <c-g>g `

    au VimEnter * imap <silent> <c-f>h #

    au VimEnter * imap <silent> <c-f>t ~

    au VimEnter * imap <silent> <c-f>d $
    au VimEnter * imap <silent> <c-g>d $

    au VimEnter * imap <silent> <c-f>x *

    au VimEnter * imap <silent> <c-f>u _

    au VimEnter * imap <silent> <c-f>q "
    au VimEnter * imap <silent> <c-g>q "

    au FileType bib,tex inoremap <silent> <c-f>Q ``
    au FileType bib,tex inoremap <silent> <c-g>Q ""
    au FileType bib,tex inoremap <silent> <c-f><c-q> ``""<left><left>

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

    au VimEnter * onoremap <silent> aa a<
    au VimEnter * xnoremap <silent> aa a<

    au VimEnter * onoremap <silent> ia i<
    au VimEnter * xnoremap <silent> ia i<

    au VimEnter * onoremap <silent> ac a{
    au VimEnter * xnoremap <silent> ac a{

    au VimEnter * onoremap <silent> ic i{
    au VimEnter * xnoremap <silent> ic i{

    au VimEnter * omap <silent> ad af$
    au VimEnter * xmap <silent> ad af$

    au VimEnter * omap <silent> id if$
    au VimEnter * xmap <silent> id if$

    au VimEnter * onoremap <silent> a` 2i`
    au VimEnter * xnoremap <silent> a` 2i`

    au VimEnter * onoremap <silent> a' 2i'
    au VimEnter * xnoremap <silent> a' 2i'

    au VimEnter * onoremap <silent> a" 2i"
    au VimEnter * xnoremap <silent> a" 2i"

    au VimEnter * onoremap <silent> iq i"
    au VimEnter * xnoremap <silent> iq i"

    au VimEnter * onoremap <silent> aq 2i"
    au VimEnter * xnoremap <silent> aq 2i"
  augroup END

  " VIM-SURROUND DEPENDENT MAPPINGS
  nmap ds    <Plug>Dsurround
  nmap cs    <Plug>Csurround
  nmap ys    <Plug>Ysurround
  nmap yss   <Plug>Yssurround
  xmap <c-s> <Plug>Vsurround
  imap <c-s> <Plug>Isurround

  " <s-s>(
  " <s-s>)
  " vmap ( <s-s>(<cr>
  " vmap ) <s-s>)<cr>
  " vmap <leader>( <s-s>(<cr>
  " vmap <leader>) <s-s>)<cr>
  " vmap <leader>( <s-s>(<cr>
  " vmap <leader>) <s-s>)<cr>

  " <s-s>[
  " <s-s>]
  " vmap [ <s-s>[<cr>
  " vmap ] <s-s>]<cr>
  " vmap <leader>[ <s-s>[<cr>
  " vmap <leader>] <s-s>]<cr>

  " <s-s>{
  " <s-s>}
  " vmap { <s-s>{<cr>
  " vmap } <s-s>}<cr>
  " vmap <leader>{ <s-s>{<cr>
  " vmap <leader>} <s-s>}<cr>

  " <s-s><
  " <s-s>>
  " vmap <leader>a <s-s>><cr>
  " vmap <leader>< <s-s><<cr>
  " vmap <leader>> <s-s>><cr>

  " vmap <c-g>m <s-s>$<cr>
  " vmap <leader>m <s-s>$<cr>
  " vmap <leader>$ <s-s>$<cr>

  " vmap " <s-s>"<cr>
  " vmap ' <s-s>'<cr>
  " vmap ` <s-s>`<cr>

  " vmap <c-g>q <s-s><c-q><cr>
  " vmap <leader>" <s-s>"<cr>
  " vmap <leader>' <s-s>'<cr>
  " vmap <leader>` <s-s>`<cr>
  " vmap <leader>q <s-s><c-q><cr>
  " vnoremap " <c-c>`>a"<c-c>`<i"<c-c>
  " vnoremap ' <c-c>`>a'<c-c>`<i'<c-c>
  " vnoremap ` <c-c>`>a`<c-c>`<i`<c-c>


