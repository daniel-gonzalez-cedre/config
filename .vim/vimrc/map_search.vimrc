" SEARCH MAPPINGS
  " augroup search_highlighting | au!
    " autocmd CmdlineEnter /,\? set hlsearch
    " autocmd CmdlineLeave /,\? set nohlsearch
    " autocmd InsertEnter * set nohlsearch
    " " autocmd InsertLeave * set nohlsearch
    " nnoremap <silent> gh <cmd>set hlsearch!<cr>
    " vnoremap <silent> gh <cmd>set hlsearch!<cr>
    " " cnoremap <expr> <cr> getcmdtype() == '/' ? '<cr>zz' : '<cr>'
  " augroup END
  " nnoremap <silent> gh <cmd>noh<cr>
  " vnoremap <silent> gh <cmd>noh<cr>
  nnoremap S :%s//gc<left><left><left>
  noremap ? //e<left><left>

  " vnoremap <leader>/ y/\V<c-r>=escape(@",'/\')<cr>
  vnoremap S y`<`>:<c-u>%s/\V<c-r>=escape(@",'/\')<cr>//gc<left><left><left>

  vnoremap * y/\V<c-r>=escape(@",'/\')<cr><cr>
