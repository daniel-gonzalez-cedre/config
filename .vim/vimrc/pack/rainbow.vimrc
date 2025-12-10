let g:rainbow_active = 1
let g:rainbow_conf = {
      \ 'guifgs': ['#ea6962', '#e78a4e', '#d8a657', '#a9b665', '#89b482', '#7daea3', '#d3869b'],
      \ 'ctermfgs': ['167', '208', '214', '142', '108', '109', '175'],
      \ }
" \ 'guifgs': ['#89b482', '#d8a657', '#e78a4e', '#7daea3', '#a9b665', '#ea6962'],
" \ 'guifgs': ['#7daea3', '#89b482', '#a9b665', '#d8a657', '#e78a4e', '#ea6962', '#d3869b'],
" \ 'guifgs': ['#ea6962', '#e78a4e', '#d8a657', '#a9b665', '#89b482', '#7daea3', '#d3869b'],

packadd rainbow

nnoremap <leader>tr <cmd>RainbowToggle<cr>
