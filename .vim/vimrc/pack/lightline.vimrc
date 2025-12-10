let g:lightline_is_loaded = 1

packadd lightline.vim

set noshowmode

function! LightlineFilenameAndMod()
  let l:filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let l:modified = &modified ? ' +' : ''
  return l:filename . modified
endfunction

let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'caps', 'relativepath' ],
      \             [ 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'readonly', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'filenameAndMod': 'LightlineFilenameAndMod',
      \ },
      \ 'component_expand': {
      \   'caps': 'CapsLockStatusline',
      \ },
      \ 'component_type': {
      \   'caps': 'warning',
      \ },
      \ 'separator': {'left': '', 'right': ''},
      \ 'subseparator': { 'left': '', 'right': ''}
      \ }
      " \ 'component_function': {
      " \   'filenameAndMod': 'LightlineFilenameAndMod',
      " \   'caps': 'CapsLockStatus',
      " \ },
      " \ 'component_expand': {
      " \   'caps': 'CapsLockStatusline',
      " \ },
      " \ 'separator': {'left': '', 'right': ''},
