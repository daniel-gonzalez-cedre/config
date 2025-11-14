packadd latex-unicoder.vim

let g:unicoder_cancel_normal = 1
let g:unicoder_cancel_insert = 1
let g:unicoder_cancel_visual = 1

nnoremap <c-g>l :call unicoder#start(0)<cr>
inoremap <c-g>l <esc>:call unicoder#start(1)<cr><right>
vnoremap <c-g>l :<c-u>call unicoder#selection()<cr>
