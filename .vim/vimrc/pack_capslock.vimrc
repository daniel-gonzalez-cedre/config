function! CapsLockStatus()
  let l:capstatus = exists('*CapsLockStatusline')?CapsLockStatusline():''
  return l:capstatus
endfunction

nnoremap <silent> <c-g>c <plug>CapsLockToggle
