" FUNCTIONS
  " function! JumpWithinFile(back, forw)
    " let [n, i] = [bufnr('%'), 1]
    " let p = [n] + getpos('.')[1:]
    " sil! exe 'norm!1' . a:forw
    " while 1
      " let p1 = [bufnr('%')] + getpos('.')[1:]
      " if n == p1[0] | break | endif
      " if p == p1
        " sil! exe 'norm!' . (i-1) . a:back
        " break
      " endif
      " let [p, i] = [p1, i+1]
      " sil! exe 'norm!1' . a:forw
    " endwhile
  " endfunction

  function! NewTabBuffer()
    let l:prevft = &filetype
    tabnew
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    let &l:filetype=l:prevft
  endfunction
  function! NewSplitBuffer()
    let l:prevft = &filetype
    split
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    let &l:filetype=l:prevft
  endfunction
  function! NewVSplitBuffer()
    let l:prevft = &filetype
    vsplit
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    let &l:filetype=l:prevft
  endfunction

  function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
      return "\<c-g>U\<right>"
    else
      return a:char
    endif
  endfunction

  function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
      return a:char
    elseif line[col - 1] == a:char
      return "\<c-g>U\<right>"
    else
      return a:char.a:char."\<c-g>U\<left>"
    endif
  endfunction

  " echoes the highlight group under the cursor
  function! HighlightGroup()
    if !exists('*synstack')
      return
    endif
    return map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc
  function! HighlightTerm(group, term)
    let output = execute('hi ' . a:group)
    return matchstr(output, a:term.'=\zs\S*')
  endfunction

  function! ToggleBackground()
    if (&background == 'light')
      set background=dark
    else
      set background=light
    endif
  endfunction

  " function! MoveMap()
    " if (maparg('h') ==# ':noh<bar>:echo<cr>h') || (maparg('j') ==# ':noh<bar>:echo<cr>j') || (maparg('k') ==# ':noh<bar>:echo<cr>k') || (maparg('l') ==# ':noh<bar>:echo<cr>l')
      " unmap h
      " unmap j
      " unmap k
      " unmap l
    " else
      " nnoremap h :noh<bar>:echo<cr>h
      " nnoremap j :noh<bar>:echo<cr>j
      " nnoremap k :noh<bar>:echo<cr>k
      " nnoremap l :noh<bar>:echo<cr>l
    " endif
  " endfunction

  nnoremap j gj
  nnoremap k gk
  nnoremap gj j
  nnoremap gk k
  function! ToggleGMove()
    if (maparg('j') ==# 'gj') || (maparg('k') ==# 'gk')
      unmap j
      unmap k
      unmap gj
      unmap gk
    else
      nnoremap j gj
      nnoremap k gk
      nnoremap gj j
      nnoremap gk k
    endif
  endfunction

  function! ToggleAMove()
    if (maparg('<left>') ==# 'zh') || (maparg('<down>') ==# '<c-e>') || (maparg('<up>') ==# '<c-y>') || (maparg('<right>') ==# 'zl')
      unmap <up>
      unmap <down>
      unmap <left>
      unmap <right>
    else
      noremap <up>    <c-y>
      noremap <down>  <c-e>
      noremap <left>  zh
      noremap <right> zl
    endif
  endfunction

  function! SetQuote()
    let l:special_filetypes = ['python', 'lua', 'c', 'cpp', 'objc',
                             \ 'html', 'css', 'javascript',
                             \ 'vim', 'vimscript', 'sh', 'bash', 'zsh',
                             \ 'markdown', 'toml', 'yaml']
    let g:quote_status = index(l:special_filetypes, &filetype) >= 0 ? 1 : 0
    if g:quote_status == 0
      inoremap <silent> ' <c-r>=ClosePair("'")<cr>
    else
      inoremap <silent> ' <c-r>=QuoteDelim("'")<cr>
    endif
  endfunction
  function! ToggleQuote()
    if g:quote_status == 1
      let g:quote_status = 0
      inoremap <silent> ' <c-r>=ClosePair("'")<cr>
    else
      let g:quote_status = 1
      inoremap <silent> ' <c-r>=QuoteDelim("'")<cr>
    endif
  endfunction

  function! TwiddleCase(str)
    return substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  endfunction

