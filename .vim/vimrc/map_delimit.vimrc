" DELIMITER MAPPINGS
  augroup delimiter_mappings | au!
    au VimEnter * imap <silent> <c-g>a <
    au VimEnter * imap <silent> <c-g>b (
    au VimEnter * imap <silent> <c-g>B {
    au VimEnter * imap <silent> <c-g>r [
    au VimEnter * imap <silent> <c-g>g `
    au VimEnter * imap <silent> <c-g>h #
    au VimEnter * imap <silent> <c-g>d $
    au VimEnter * imap <silent> <c-g>x *
    au VimEnter * imap <silent> <c-g>u _
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
    au VimEnter * omap <silent> aa a<
    au VimEnter * xmap <silent> aa a<
    au VimEnter * omap <silent> ia i<
    au VimEnter * xmap <silent> ia i<
    au VimEnter * omap <silent> ad af$
    au VimEnter * xmap <silent> ad af$
    au VimEnter * omap <silent> id if$
    au VimEnter * xmap <silent> id if$
    au VimEnter * onoremap <silent> a` 2i`
    au VimEnter * onoremap <silent> a' 2i'
    au VimEnter * onoremap <silent> a" 2i"
    au VimEnter * xnoremap <silent> a` 2i`
    au VimEnter * xnoremap <silent> a' 2i'
    au VimEnter * xnoremap <silent> a" 2i"
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


