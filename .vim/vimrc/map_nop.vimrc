" augroup nop_mappings | au!
"   let &t_TI = ""
"   let &t_TE = ""
"   " noremap 
" augroup END


" silence macro recording
noremap <silent> q <nop>
noremap <silent> Qq <nop>
noremap QQ Q

noremap <silent> <c-f> <nop>

" noremap <c-y> <nop>
" noremap <c-e> <nop>
noremap <c-w><c-c> <nop>
noremap <c-z> <nop>

nnoremap ZQ <nop>
nnoremap ZZ <nop>
nnoremap Zz <nop>
nnoremap ZX <nop>
nnoremap Zx <nop>

" unmap tmux leader key
noremap <c-b> <nop>
inoremap <c-b> <nop>
" noremap! <c-b> <nop>

" nnoremap <s-up> <nop>
" nnoremap <s-down> <nop>
" nnoremap <s-left> <nop>
" nnoremap <s-right> <nop>
" inoremap <s-up> <nop>
" inoremap <s-down> <nop>
" inoremap <s-left> <nop>
" inoremap <s-right> <nop>

" nnoremap <silent> <cr> :noh<bar>:echo<cr>
" nnoremap <silent> <bs> :noh<bar>:echo<cr>
" vnoremap <silent> <bs> <nop>
nnoremap <silent><cr> <nop>
nnoremap <silent><bs> <nop>
nnoremap <silent><del> <nop>

noremap <silent> <c-c> <esc>
inoremap <silent> <c-c> <esc>

noremap <s-cr> <nop>
noremap <c-cr> <nop>
" nmap <c-cr> <cr>
" vmap <c-cr> <cr>
" nmap <s-bs> <bs>
" vmap <s-bs> <bs>
" nmap <c-bs> <bs>
" vmap <c-bs> <bs>
