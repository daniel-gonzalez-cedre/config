" VISUALIZATION: BUFFERS
  " nnoremap <leader>ls :ls<cr>
  " nnoremap <leader>b :ls<cr>:b<space>
" VISUALIZATION: MARKS
  " nnoremap <leader>m :<c-u>marks<cr>:normal! `

" NUMBERS: INCREASE
  noremap  +  <c-a>
  noremap g+ g<c-a>
" NUMBERS: DECREASE
  noremap  -  <c-x>
  noremap g- g<c-x>

" MOVEMENT: LINES
  nnoremap j gj
  nnoremap k gk
  nnoremap gj j
  nnoremap gk k

" WINDOW: NOP
  noremap <c-w>q <nop>
  noremap <c-w>c <nop>
  noremap <c-w>o <nop>

" noremap <silent> <c-s-a>b <cmd>ls<cr>

" WINDOW NAVIGATION:
  noremap <silent> <c-w>n <cmd>bn<cr>
  noremap <silent> <c-w>p <cmd>bp<cr>
  noremap <silent> <c-w>d <cmd>bd<cr>
  noremap <silent> <c-w>s <cmd>ls<cr>

" TAB CREATION:
  noremap <c-w>t <cmd>call NewTabBuffer()<cr>

" WINDOW SPLITTING: DUPLICATE BUFFER
  noremap <c-w>x <cmd>sp<cr>
  noremap <c-w>y <cmd>vsp<cr>
  " noremap <c-w>v <cmd>call NewVSplitBuffer()<cr>

" WINDOW SPLITTING: NEW BLANK BUFFER
  noremap <c-w>b <cmd>call NewSplitBuffer()<cr>
  noremap <c-w>B <cmd>call NewSplitBuffer()<cr>
  noremap <c-w>" <cmd>call NewSplitBuffer()<cr>
  noremap <c-w>% <cmd>call NewVSplitBuffer()<cr>

" WINDOW RESIZING:
  noremap <c-w>z <c-w>_
  noremap <c-w>Z <c-w>=

" DELETE TRAILING SPACES: GLOBAL
  nnoremap dgs :%s/\s\+$//e<cr><c-o>

" PAGE SCROLLING:
  noremap <up>    <c-y>
  noremap <down>  <c-e>
  noremap <left>  zh
  noremap <right> zl

  inoremap <left>  <c-g>U<left>
  inoremap <right> <c-g>U<right>

  noremap <s-up>    <c-y>
  noremap <s-down>  <c-e>
  noremap <s-left>  zh
  noremap <s-right> zl

  inoremap <s-up>    <c-o><c-y>
  inoremap <s-down>  <c-o><c-e>
  inoremap <s-left>  <c-o>zh
  inoremap <s-right> <c-o>zl

" LINE NAVIGATION:
  " RENDERED TEXT LINE: END
     noremap <silent> g<c-a> g^
    onoremap <silent> g<c-a> g^
    inoremap <silent> <c-g><c-a> <c-o>g^
  " RENDERED TEXT LINE: START
     noremap <silent> g<c-e> g_
    onoremap <silent> g<c-e> g_
    inoremap <silent> <c-g><c-e> <c-o>g$

  " LOGICAL TEXT LINE: START
     noremap <silent> <c-a> ^
    onoremap <silent> <c-a> ^
    inoremap <silent> <c-a> <c-o>^
  " LOGICAL TEXT LINE: END
    nnoremap <silent> <c-e> $
    vnoremap <silent> <c-e> $<left>
    onoremap <silent> <c-e> $
    inoremap <silent> <c-e> <c-o>$

  " COMMAND LINE: START
    cnoremap <c-a> <home>
  " COMMAND LINE: END
    cnoremap <c-e> <end>

nnoremap [f zk
nnoremap ]f zj

" vnoremap <expr> i mode()=~'\cv' ? 'i' : 'I'
" vnoremap <expr> a mode()=~'\cv' ? 'a' : 'A'

" REGISTERS: CLIPBOARD
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif
if has('clipboard')
   noremap y  "+y
   noremap Y  "+Y
  nnoremap yy "+yy

   noremap d  "+d
   noremap D  "+D
  nnoremap dd "+dd

  noremap p "+p
  noremap P "+P
endif
