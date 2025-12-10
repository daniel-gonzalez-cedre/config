function! CapsLockStatus()
  let l:capstatus = exists('*CapsLockStatusline')?CapsLockStatusline():''
  return l:capstatus
endfunction

nmap <silent> <c-t> <plug>CapsLockToggle
imap <silent> <c-t> <plug>CapsLockToggle

" nmap <silent> <c-f>s <plug>CapsLockEnable
" nmap <silent> <c-g>s <plug>CapsLockDisable

" imap <silent> <c-f>s <Plug>CapsLockEnable
" imap <silent> <c-g>s <Plug>CapsLockDisable

" cmap <silent> <c-f>s <Plug>CapsLockEnable
" cmap <silent> <c-g>s <Plug>CapsLockDisable
