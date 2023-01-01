packadd YouCompleteMe
nnoremap <leader>gg :YcmCompleter GoTo<CR>:noh<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>:noh<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>:noh<CR>

let s:lsp_ft_maps = 'python'
augroup ycm_settings | au!
    exe printf('au FileType %s call Ycm_mappings()', s:lsp_ft_maps)
augroup end
func! Ycm_mappings() abort
    nmap <silent><buffer> K <Plug>(YCMHover)
    nnoremap <silent><buffer> gd :YcmCompleter GoTo<CR>
endfunc

let g:ycm_auto_hover=""
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_stop_completion = ['<C-y>']
