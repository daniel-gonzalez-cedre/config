nnoremap <leader>tw <cmd>setlocal nowrap!<cr>
nnoremap <leader>ts <cmd>setlocal spell!<cr>
nnoremap <leader>tq <cmd>call ToggleQuote()<cr>
nnoremap <leader>t' <cmd>call ToggleQuote()<cr>
nnoremap <leader>t" <cmd>call ToggleQuote()<cr>
nnoremap <leader>tg <cmd>call ToggleGMove()<cr>
nnoremap <leader>ta <cmd>call ToggleAMove()<cr>
nnoremap <leader>tfi <cmd>setlocal foldmethod=indent<cr>
nnoremap <leader>tfm <cmd>setlocal foldmethod=manual<cr>
" noremap <leader>h <cmd>noh<bar>:echo<cr>
" nnoremap <leader>th <cmd>set nohlsearch!<cr>
" nnoremap <leader>tb <cmd>call ToggleBackground()<cr>

" function! ToggleConcealLevel()
" if &conceallevel == 0
" setlocal conceallevel=1
" else
" setlocal conceallevel=0
" endif
" endfunction
" nnoremap <silent> <leader>tc <cmd>call ToggleConcealLevel()<cr>

" relative line numbers
" nnoremap <leader>trln <cmd>set rnu!<cr>

