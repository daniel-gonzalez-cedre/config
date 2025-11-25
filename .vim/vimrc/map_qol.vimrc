" QUALITY OF LIFE MAPPINGS
  " LIST AND COMMAND MAPPINGS
    nnoremap <leader>ls :ls<cr>
    nnoremap <leader>b :ls<cr>:b<space>
    " nnoremap <leader>u :u<cr>:u<space>
    nnoremap <leader>m :<c-u>marks<cr>:normal! `


  " MATCH MAPPINGS
    " cnoremap <tab> <c-g>
    " cnoremap <s-tab> <c-t>
    " nmap <c-f> %
    " vmap <c-f> %

    " nmap [<c-f> [%
    " nmap ]<c-f> ]%

    " vmap i<c-f> i%
    " vmap a<c-f> a%

    " omap i<c-f> i%
    " omap a<c-f> a%

    " xmap i<c-f> i%
    " xmap a<c-f> a%

    noremap + <c-a>
    noremap - <c-x>
    noremap g+ g<c-a>
    noremap g- g<c-x>

  " WINDOWS, BUFFERS, & POPUPS
    noremap <c-w>q <nop>
    noremap <c-w>c <nop>
    noremap <c-w>o <nop>

    " noremap <silent> <c-s-a>b <cmd>ls<cr>

    " GO TO PREVIOUS/NEXT BUFFER
    noremap <silent> <c-w>n <cmd>bn<cr>
    noremap <silent> <c-w>p <cmd>bp<cr>
    noremap <silent> <c-w>d <cmd>bd<cr>
    noremap <silent> <c-w>s <cmd>ls<cr>

    " GO TO PREVIOUS/NEXT TAB
    " noremap <c-w>p <c-w>gT
    " noremap <c-w>n <c-w>gt

    noremap <c-w>t <cmd>call NewTabBuffer()<cr>

    " noremap <c-w>v <cmd>call NewVSplitBuffer()<cr>
    noremap <c-w>x <cmd>sp<cr>
    noremap <c-w>y <cmd>vsp<cr>

    noremap <c-w>b <cmd>call NewSplitBuffer()<cr>
    noremap <c-w>B <cmd>call NewSplitBuffer()<cr>

    noremap <c-w>" <cmd>call NewSplitBuffer()<cr>
    noremap <c-w>% <cmd>call NewVSplitBuffer()<cr>

    noremap <c-w>z <c-w>_
    noremap <c-w>Z <c-w>=

    " inoremap <expr> <cr> pumvisible() ? (complete_info().selected == -1 ? '<c-y><cr>' : '<c-y>') : '<cr>'
    " inoremap <expr> <cr> pumvisible() ? "\<c-g>u\<cr>" : "\<cr>"
    " inoremap <expr> <tab> pumvisible() ? "\<c-y>" : "\<tab>"

  " MOVEMENT
    nnoremap dgs :%s/\s\+$//e<cr><c-o>
    " augroup yank_visual_movement | au!
      " nnoremap v mmv
      " vnoremap y "+ygv<c-c>
      " au TextYankPost if v:event.operator ==# 'y' | normal `m | endif

    " vmap y ygv<c-c>
    " augroup yank_cursor_reset | au!
    " augroup END
    " augroup END
    " there are no autocmd
    " augroup visual_cursor_reset | au!
      " autocmd VisualEnter *
      " autocmd VisualLeave *
    " augroup END

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

    " nnoremap j gj
    " nnoremap k gk
    " nnoremap gj j
    " nnoremap gk k

    " LINE MOVEMENT
    " START OF RENDERED TEXT LINE
      noremap <silent> g<c-a> g^
      onoremap <silent> g<c-a> g^
      inoremap <silent> <c-g><c-a> <c-o>g^
    " START OF LOGICAL TEXT LINE
      noremap <silent> <c-a> ^
      onoremap <silent> <c-a> ^
      inoremap <silent> <c-a> <c-o>^
    " START OF COMMAND LINE
      cnoremap <c-a> <home>

    " END OF RENDERED LINE OF TEXT
      noremap <silent> g<c-e> g_
      onoremap <silent> g<c-e> g_
      inoremap <silent> <c-g><c-e> <c-o>g$
    " END OF LOGICAL LINE OF TEXT
      " nnoremap ge g$
      " vnoremap ge g$<left>
      " onoremap ge g$
      nnoremap <silent> <c-e> $
      vnoremap <silent> <c-e> $<left>
      onoremap <silent> <c-e> $
      inoremap <silent> <c-e> <c-o>$
    " OPERATOR PENDING TO END OF LOGICAL TEXT LINE
    " END OF COMMAND LINE
      cnoremap <c-e> <end>

    " TEXT OBJECT INSIDE CURRENT LINE
      xnoremap il g_o^
      onoremap <silent> il <cmd>normal vil<cr>
    " TEXT OBJECT AROUND CURRENT LINE
      xnoremap al $o^
      onoremap <silent> al <cmd>normal val<cr>


  " FOLDS
    " nnoremap <leader>ff zf
    " vnoremap <leader>ff zf

    " nnoremap <leader>fd zd
    " vnoremap <leader>fd zd
    " nnoremap <leader>fD zD
    " vnoremap <leader>fD zD
    " nnoremap <leader>fE zE
    " vnoremap <leader>fE zE

    " nnoremap <leader>fa za
    " vnoremap <leader>fa za
    " nnoremap <leader>fA zA
    " vnoremap <leader>fA zA

    " nnoremap <leader>fo zo
    " vnoremap <leader>fo zo

    " nnoremap <leader>fc zc
    " vnoremap <leader>fc zc

    nnoremap [f zk
    nnoremap ]f zj

    " inoremap <c-]> <del>

  " vnoremap <expr> i mode()=~'\cv' ? 'i' : 'I'
  " vnoremap <expr> a mode()=~'\cv' ? 'a' : 'A'

  " nnoremap <silent> <c-o> :call JumpWithinFile ("\<c-i>", "\<c-o>")<cr>
  " nnoremap <silent> <c-i> :call JumpWithinFile ("\<c-o>", "\<c-i>")<cr>

  " nnoremap <silent> <leader>o :call JumpWithinFile ("\<c-i>", "\<c-o>")<cr>
  " nnoremap <silent> <leader>i :call JumpWithinFile ("\<c-o>", "\<c-i>")<cr>


  " COPY AND PASTE
    if has('clipboard')
      vnoremap x "+x
      vnoremap X "+X

      noremap d "+d
      noremap D "+D
      nnoremap dd "+dd

      noremap y "+y
      noremap Y "+Y
      nnoremap yy "+yy

      noremap p "+p
      noremap P "+P

      " noremap x "+x:noh<bar>:echo<cr>
      " noremap X "+X:noh<bar>:echo<cr>

      " vnoremap y "+y`<
    else
      " noremap x x:noh<bar>:echo<cr>
      " noremap X X:noh<bar>:echo<cr>
    endif


