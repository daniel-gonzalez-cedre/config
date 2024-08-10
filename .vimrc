" initialization
  filetype plugin indent on
  silent
  syntax enable

  augroup init_settings | au!
    au FileType * set conceallevel=0
    au BufEnter * :syntax sync fromstart
  augroup END

  if !isdirectory($HOME.'/.vim')
    call mkdir($HOME.'/.vim', '', 0770)
  endif

  if !isdirectory($HOME.'/.vim/undodir')
    call mkdir($HOME.'/.vim/undodir', '', 0700)
  endif
  set undodir=~/.vim/undodir
  set undofile

  " "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
  " "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
  " "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
  " " if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  " if getenv('TERM_PROGRAM') != 'Apple_Terminal'
    " if (has("nvim"))
      " "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    " endif
    " "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    " "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    " set termguicolors
  " endif

  " if $TERM_PROGRAM !=# 'Apple_Terminal' || $TMUX !=? ''
  if $TERM_PROGRAM !=# 'Apple_Terminal'
    if (has("nvim"))
      "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    set termguicolors
  endif

" LEADER
  nnoremap <space> <nop>
  vnoremap <space> <nop>
  let mapleader = ' '

" NOP MAPPINGS
  " silence macro recording
  map q <nop>
  noremap <leader><c-q> q

  nnoremap ZZ <nop>
  nnoremap Zz <nop>
  nnoremap ZX <nop>
  nnoremap Zx <nop>

  " unmap tmux leader key
  map <c-b> <nop>
  map! <c-b> <nop>

  nmap <s-cr> <cr>
  vmap <s-cr> <cr>
  " nmap <c-cr> <cr>
  " vmap <c-cr> <cr>
  " nmap <s-bs> <bs>
  " vmap <s-bs> <bs>
  " nmap <c-bs> <bs>
  " vmap <c-bs> <bs>

  nnoremap <silent> <cr> :noh<bar>:echo<cr>
  nnoremap <silent> <bs> :noh<bar>:echo<cr>
  vnoremap <silent> <bs> <nop>

  noremap <silent> <c-c> <esc><esc>
  nnoremap <silent> <c-c> :noh<bar>:echo<cr><esc><esc>
  inoremap <silent> <c-c> <esc><esc>:noh<bar>:echo<cr>
  " vnoremap <silent> <c-c> <c-c><c-c>`<


" PACKAGES
  " tabularize
    nnoremap <leader><tab> :Tabularize /
    vnoremap <tab> :Tabularize /
    vnoremap <tab><space> :Tabularize /\zs<left><left><left>
    " vnoremap <tab>\ :Tabularize /\zs<left><left><left>
    vnoremap <tab>= :Tabularize /=<cr>
    vnoremap <tab>( :Tabularize /(<cr>
    vnoremap <tab>{ :Tabularize /{<cr>
    vnoremap <tab>[ :Tabularize /[<cr>
    vnoremap <tab>: :Tabularize /:<cr>
    vnoremap <tab>, :Tabularize /,<cr>
    " vnoremap <leader><tab>| :Tabularize /|<cr>

  packadd vim-gitgutter
    let g:gitgutter_map_keys = 1

    let g:gitgutter_sign_added = '⋅ '
    let g:gitgutter_sign_modified = '⋅ '
    let g:gitgutter_sign_removed = '⋅ '
    " let g:gitgutter_sign_removed_first_line = '  '
    " let g:gitgutter_sign_removed_above_and_below = '  '
    let g:gitgutter_sign_modified_removed = '⋅ '
    call gitgutter#highlight#define_signs()

    nmap ]h <Plug>(GitGutterNextHunk)
    nmap [h <Plug>(GitGutterPrevHunk)
    omap ih <Plug>(GitGutterTextObjectInnerPending)
    omap ah <Plug>(GitGutterTextObjectOuterPending)
    xmap ih <Plug>(GitGutterTextObjectInnerVisual)
    xmap ah <Plug>(GitGutterTextObjectOuterVisual)
    nmap <leader>hf :GitGutterFold<cr>

  packadd julia-vim

  " if has('nvim')
    " packadd! nvim-treesitter
  " else
    " packadd! ale
  " endif
  augroup ale_settings | au!
    au FileType python call s:setup_ale()
    au FileType lua call s:setup_ale()
    au FileType vim call s:setup_ale()
    au FileType tex call s:setup_ale()

    " linters: ruff, mypy, pylint, pyright, lacheck, chktek, proselint
    function! s:setup_ale()
      packadd ale

      map ]a :ALENextWrap<cr>
      map [a :ALEPreviousWrap<cr>
      map ]e <Plug>(ale_next_wrap_error)
      map [e <Plug>(ale_previous_wrap_error)
      map ]w <Plug>(ale_next_wrap_warning)
      map [w <Plug>(ale_previous_wrap_warning)
      map <leader>an :ALENextWrap<cr>
      map <leader>aN :ALEPreviousWrap<cr>
      map <leader>ae <Plug>(ale_next_wrap_error)
      map <leader>aE <Plug>(ale_previous_wrap_error)
      map <leader>aw <Plug>(ale_next_wrap_warning)
      map <leader>aW <Plug>(ale_previous_wrap_warning)
      map <leader>al :ALELint<cr>
      map <leader>ad :ALEDetail<cr>
    endfunction

    let g:ale_sign_error='×⟩'
    let g:ale_sign_warning='⋅⟩'
    " let g:ale_sign_error=' ×'
    " let g:ale_sign_warning=' ×'
    let g:ale_linters={
          \ 'vim': ['vint'],
          \ 'python': ['ruff', 'mypy'],
          \ 'lua': ['luacheck', 'luac'],
          \ 'tex': ['lacheck']
          \ }
    let g:ale_lint_on_text_changed='always'
    let g:ale_lint_on_insert_leave=1
    let g:ale_lint_delay=0
    let g:ale_lint_on_save=1
    let g:ale_virtualtext_prefix=' '
    let g:ale_virtualtext_cursor='current'
    let g:ale_virtualtext_delay=0
    let g:ale_echo_cursor=0
    let g:ale_python_pylint_options="--init-hook=\"import sys; sys.path.append(\'" . trim(system('git rev-parse --show-toplevel')) . "\')\""
  augroup END

" SET OPTIONS
  " FILETYPE SPECIFIC
    " PYTHON
    augroup python_settings | au!
      au FileType python setlocal shiftwidth=2
      au FileType python setlocal softtabstop=2
      au FileType python setlocal tabstop=8
    augroup END

    augroup html_settings | au!
      au BufNewFile,BufRead *.svg set filetype=html
    augroup END
    
    " LaTeX
    augroup latex_settings | au!
      " packadd vim-latex
      packadd vimtex

      au BufNewFile,BufRead *.bib,*.tex,*.tikz set filetype=tex
      au BufNewFile,BufRead *.bib,*.tex,*.tikz set syntax=tex

      au BufNewFile,BufRead *.bib,*.tex,*.tikz imap ` <nop>
      au BufNewFile,BufRead *.bib,*.tex,*.tikz iunmap `

      au FileType tex let g:vimtex_compiler_enabled = 0
      au FileType tex let g:vimtex_complete_enabled = 0
      " au FileType tex let g:vimtex_fold_enabled = 1
      au FileType tex let g:vimtex_imaps_enabled = 0
      " au FileType tex let g:vimtex_mappings_enabled = 0
      au FileType tex let g:vimtex_quickfix_enabled = 0
      au FileType tex let g:vimtex_syntax_nospell_comments = 1
      au FileType tex let g:vimtex_view_enabled = 0

      let g:Tex_SmartQuoteOpen = '``'
      let g:Tex_SmartQuoteClose = "''"
      " let g:tex_flavor = 'latex'
      " let g:tex_fold_enabled = 1

      " au FileType tex set foldmethod=syntax
    augroup END

  " GENERAL
    set background=dark
    set backspace=indent,eol,start
    set conceallevel=0
    set cursorline
    set display+=lastline
    set fillchars=stl:⋅,stlnc:⋅,vert:\|,fold:⋅
    " set fillchars=stl:-,stlnc:⋅,vert:│,fold:\ ,diff:·
    set formatoptions+=1jr/  " use <c-U> to remove comment symbol
    " set hlsearch
    set nohlsearch
    set ignorecase
    set incsearch
    set nojoinspaces
    set laststatus=2
    set matchpairs+=<:>
    " set matchpairs+=`:'
    set mouse=
    " set spell
    set nospell
    set number
    set numberwidth=3
    set ruler
    set signcolumn=yes
    set shiftround
    set showcmd
    set showtabline=1
    set smartcase
    set spelllang+=cjk
    set spellsuggest=best,5
    set splitbelow
    set splitright
    set notimeout nottimeout
    set updatetime=100
    set wildmenu
    set wildmode=list:longest,full
    " set number relativenumber
    " set scrolloff=2

  " POP-UP WINDOW
    " set completeopt+=popup
    " set completepopup=height:15,width:60,border:off,highlight:PMenuSbar
    " set previewpopup=height:10,width:60,highlight:PMenuSbar

  " FOLDING
    set foldignore=
    set foldlevelstart=99
    set foldmethod=indent

  " INDENTATION
    set autoindent
    " set smartindent
    set smartindent

    set expandtab
    set shiftwidth=2
    set softtabstop=2
    set tabstop=8

  " LINES & WRAPPING
    set breakindent
    set breakindentopt=sbr
    set linebreak
    " let &showbreak='>'
    set sidescroll=10
    set textwidth=0
    " set list
    " set listchars=tab:--,nbsp:_,eol:⋅

" PLUGIN SETTINGS
  let g:fanfingtastic_all_inclusive = 1
  let g:fanfingtastic_fix_t = 1
  let g:fanfingtastic_ignorecase = 1
  let g:gruvbox_improved_strings = 1
  let g:gruvbox_improved_warnings = 1
  let g:gruvbox_hls_cursor = 'orange'
  " let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_contrast_light = 'hard'
  let g:haskell_indent_if = 2
  let g:haskell_indent_case = 4
  let g:haskell_indent_guard = 5
  let g:incsearch#auto_nohlsearch = 1
  let g:latex_to_unicode_file_types = '.*'
  let g:matchparen_timeout = 8
  let g:matchparen_insert_timeout = 8
  let g:NERDCommentEmptyLines = 0
  let g:NERDCompactSexyComs = 1
  let g:NERDCustomDelimiters = { 'python': { 'left': '#', 'right': '' }, 'julia': { 'left': '#', 'right': '' }, 'typst': { 'left': '//', 'right': '' }}
  " let g:NERDDefaultAlign = 'left'
  let g:NERDSpaceDelims = 1
  let g:NERDToggleCheckAllLines = 1
  let g:NERDTrimTrailingWhitespace = 1
  let g:python_highlight_all = 1
  let g:rainbow_active = 1
  let g:tex_flavor = 'latex'
  let g:unicoder_cancel_normal = 1
  " let g:unicoder_cancel_insert = 1
  let g:unicoder_cancel_visual = 1


" TOGGLE MAPPINGS
  " noremap <leader>h :noh<bar>:echo<cr>
  nnoremap <leader>th :set nohlsearch!<cr>
  nnoremap <leader>tw :setlocal nowrap!<cr>
  nnoremap <leader>ts :setlocal spell!<cr>
  nnoremap <leader>tb :call ToggleBackground()<cr>
  nnoremap <leader>tgm :call ToggleGMove()<cr>
  nnoremap <leader>tq :call ToggleQuote()<cr>
  nnoremap <leader>t' :call ToggleQuote()<cr>
  nnoremap <leader>t" :call ToggleQuote()<cr>

  nnoremap <leader>ta :ALEToggle<cr>
  nnoremap <leader>tgit :GitGutterToggle<cr>

  " relative line numbers
  nnoremap <leader>tln :set rnu!<cr>


" map zs :setlocal spell!<cr>
" map <leader><c-f> zA
" map zt ZT
" map zn ZN
" map zN ZP
" map zl ZL
" map z= ZL
" map zg Zg
" map zug Zug
" map zG ZG
" map zuG ZUG
" map zw Zw
" map zuw Zuw
" map zW ZW
" map zUW ZUW
" map ]s ZN
" map [s ZP


" SEARCH MAPPINGS
  " search visual selection
  vnoremap <leader>/ y/\V<c-r>=escape(@",'/\')<cr>
  " search & replace without selection
  nnoremap <leader>s :%s//gc<left><left><left>
  " search & replace visual selection
  vnoremap <leader>s y`<`>:<c-u>%s/\V<c-r>=escape(@",'/\')<cr>//gc<left><left><left>


" QUALITY OF LIFE MAPPINGS
  nnoremap <c-g> g_
  vnoremap <c-g> g_
  nnoremap <c-f> ^
  vnoremap <c-f> ^

  noremap <leader>nn :call ScratchBuffer()<cr>

  " movement
  inoremap <left> <c-g>U<left>
  inoremap <right> <c-g>U<right>
  " noremap \h <c-w>h
  " noremap \j <c-w>j
  " noremap \k <c-w>k
  " noremap \l <c-w>l

  nnoremap j gj
  nnoremap k gk
  " nnoremap gj j
  " nnoremap gk k

  nnoremap <up> <c-y>
  vnoremap <up> <c-y>
  nnoremap <down> <c-e>
  vnoremap <down> <c-e>
  nnoremap <left> zh
  vnoremap <left> zh
  nnoremap <right> zl
  vnoremap <right> zl

  " vnoremap <expr> i mode()=~'\cv' ? 'i' : 'I'
  " vnoremap <expr> a mode()=~'\cv' ? 'a' : 'A'

  " nnoremap <silent> <c-o> :call JumpWithinFile ("\<c-i>", "\<c-o>")<cr>
  " nnoremap <silent> <c-i> :call JumpWithinFile ("\<c-o>", "\<c-i>")<cr>

  " nnoremap <silent> <leader>o :call JumpWithinFile ("\<c-i>", "\<c-o>")<cr>
  " nnoremap <silent> <leader>i :call JumpWithinFile ("\<c-o>", "\<c-i>")<cr>

  " text object for current line
  xnoremap il g_o^
  onoremap <silent> il :normal vil<cr>
  xnoremap al $o^
  onoremap <silent> al :normal val<cr>

  " misc
  nnoremap <leader>ff za
  vnoremap <leader>ff za
  nnoremap <leader>fa zA
  vnoremap <leader>fa zA
  nnoremap <leader>F zA
  vnoremap <leader>F zA
  inoremap <c-]> <del>
  " inoremap <expr> <cr> pumvisible() ? !empty(v:completed_item) ? "<c-y><c-c>" : "<c-y><cr>" : "<cr>"

  if has('clipboard')
    noremap d "+d
    noremap p "+p
    noremap x "+x:noh<bar>:echo<cr>
    noremap X "+X:noh<bar>:echo<cr>

    nnoremap y "+y
    nnoremap Y "+Y
    nnoremap D "+D
    nnoremap P "+P
    nnoremap yy "+yy
    nnoremap dd "+dd

    vnoremap y "+y`<
  else
    noremap x x:noh<bar>:echo<cr>
    noremap X X:noh<bar>:echo<cr>
  endif


" DELIMITER MAPPINGS
  inoremap ( ()<c-g>U<left>
  inoremap [ []<c-g>U<left>
  inoremap { {}<c-g>U<left>
  inoremap ) <c-r>=ClosePair(')')<cr>
  inoremap ] <c-r>=ClosePair(']')<cr>
  inoremap } <c-r>=ClosePair('}')<cr>
  inoremap > <c-r>=ClosePair('>')<cr>
  inoremap $ <c-r>=ClosePair('$')<cr>
  inoremap <c-f> <c-r>=ClosePair('$')<cr>
  inoremap <c-\> <c-r>=QuoteDelim('$')<cr>
  inoremap " <c-r>=QuoteDelim('"')<cr>
  inoremap ' <c-r>=QuoteDelim("'")<cr>
  inoremap ` <c-r>=QuoteDelim('`')<cr>
  inoremap <c-q> ``''<left><left>

  vmap <leader>b <s-s>)<cr>
  vmap <leader>p <s-s>)<cr>
  vmap <leader>( <s-s>(<cr>
  vmap <leader>) <s-s>)<cr>

  vmap <leader>r <s-s>]<cr>
  vmap <leader>[ <s-s>[<cr>
  vmap <leader>] <s-s>]<cr>

  vmap <leader>B <s-s>}<cr>
  vmap <leader>{ <s-s>{<cr>
  vmap <leader>} <s-s>}<cr>

  vmap <leader>a <s-s>><cr>
  vmap <leader>< <s-s><<cr>
  vmap <leader>> <s-s>><cr>

  vmap <leader>m <s-s>$<cr>
  vmap <leader>$ <s-s>$<cr>

  vmap <leader>Q <s-s>Q<cr>
  vmap <leader>" <s-s>"<cr>
  vmap <leader>' <s-s>'<cr>
  vmap <leader>` <s-s>`<cr>
  " vnoremap " <c-c>`>a"<c-c>`<i"<c-c>
  " vnoremap ' <c-c>`>a'<c-c>`<i'<c-c>
  " vnoremap ` <c-c>`>a`<c-c>`<i`<c-c>


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

  function! ScratchBuffer()
    let l:prevft = &filetype
    split
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    let &l:filetype=l:prevft
    file scratch
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
      return a:char.a:char."\<esc>i"
    endif
  endfunction

  " echoes the highlight group under the cursor
  function! SynStack()
    if !exists("*synstack")
      return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
  endfunc

  function! ToggleBackground()
    if (&background == 'light')
      set background=dark
    else
      set background=light
    endif
  endfunction

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

  let quoteStatus = 0
  function! ToggleQuote()
    if g:quoteStatus == 0
      let g:quoteStatus = 1
      inoremap " <c-r>=ClosePair('"')<cr>
      inoremap ' <c-r>=ClosePair("'")<cr>
      inoremap ` <c-r>=ClosePair('`')<cr>
    else
      let g:quoteStatus = 0
      inoremap " <c-r>=QuoteDelim('"')<cr>
      inoremap ' <c-r>=QuoteDelim("'")<cr>
      inoremap ` <c-r>=QuoteDelim('`')<cr>
    endif
  endfunction

  function! TwiddleCase(str)
    return substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  endfunction


" COLORS
  function! s:gruvbox_colors()
    hi clear Comment
    hi clear Folded
    hi Comment ctermfg=240 ctermbg=none cterm=none
    " hi Folded ctermfg=95 ctermbg=234
    hi Folded ctermfg=237 ctermbg=none cterm=none
    " hi String ctermfg=142 ctermbg=none cterm=none

    hi clear StatusLine
    hi clear StatusLineNC
    hi StatusLine ctermfg=237 ctermbg=none cterm=none
    hi StatusLineNC ctermfg=237 ctermbg=none cterm=none

    " hi clear Visual
    " hi Visual ctermfg=none ctermbg=none cterm=inverse
    hi Visual ctermbg=238

    " hi clear Matchparen
    " hi MatchParen cterm=inverse
    hi MatchParen guibg=#504945 ctermfg=0 ctermbg=240

    hi clear SignColumn
    hi clear LineNR
    hi clear CursorLine
    " hi clear CursorLineNR
    hi LineNR ctermfg=237 cterm=none
    hi CursorLine ctermfg=none ctermbg=none cterm=none
    hi CursorLineNR ctermfg=214 ctermbg=none

    " hi SpellBad ctermfg=131 ctermbg=234 cterm=underline
    " hi SpellCap ctermfg=66 ctermbg=234 cterm=underline
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellLocal
    hi clear SpellRare
    hi SpellBad ctermbg=none cterm=underline
    hi SpellCap ctermbg=none cterm=underline
    hi SpellLocal ctermbg=none cterm=none
    hi SpellRare ctermbg=none cterm=none

    hi clear texStyleItal
    hi clear texCmdSize
    hi clear texCmdStyle
    hi texStyleItal ctermfg=214 ctermbg=none cterm=none
    hi texCmdSize ctermfg=208 ctermbg=none cterm=none
    hi texCmdStyle ctermfg=208 ctermbg=none cterm=none

    if has('nvim')
    else
      hi clear ALEError
      hi clear ALEWarning
      hi clear ALEErrorSign
      hi clear ALEWarningSign
      hi clear ALEErrorLine
      hi clear ALEWarningLine
      hi clear ALEInfoSign
      hi clear ALEVirtualTextError
      hi clear ALEVirtualTextWarning
      " hi ALEErrorLine ctermbg=none cterm=none
      " hi ALEWarningLine ctermbg=none cterm=none
      " hi ALEError ctermbg=167
      " hi ALEWarning ctermfg=214
      hi ALEErrorSign ctermfg=167 ctermbg=none
      hi ALEWarningSign ctermfg=214 ctermbg=none
      hi ALEInfoSign ctermfg=108 ctermbg=none
      " hi ALEVirtualTextError ctermfg=237
      " hi ALEVirtualTextWarning ctermfg=237
      hi ALEVirtualTextError ctermfg=167
      hi ALEVirtualTextWarning ctermfg=214
    endif

    hi SignColumn ctermbg=black
  endfunction

  function! s:gitgutter_colors()
    if $TERM_PROGRAM !=# 'Apple_Terminal'
      hi clear SignColumn
      hi GitGutterAdd ctermfg=142 ctermbg=none
      hi GitGutterChange ctermfg=109 ctermbg=none
      hi GitGutterDelete ctermfg=167 ctermbg=none
      hi GitGutterChangeDelete ctermfg=175 ctermbg=none
    endif
  endfunction

  augroup setup_colors | au!
    au ColorScheme gruvbox call s:gruvbox_colors()
    au ColorScheme gruvbox call s:gitgutter_colors()
  augroup END

  colorscheme gruvbox

" CUSTOM CURSORS
  " LINE: \e[5
  " BLOCK: \e[2
  " UNDERLINE: \e[4
  let &t_SI="\e[5 q"  " start insert mode
  let &t_EI="\e[2 q"  " end insert mode

" NERDCommenter MAPPINGS
autocmd! VimEnter * call s:nerdcommenter_mappings()
function! s:nerdcommenter_mappings()
  nmap <leader>cc <plug>NERDCommenterToggle
  nmap <leader>ci <plug>NERDCommenterInvert
  nmap <leader>ct <plug>NERDCommenterInvert
  vmap <leader>cc <plug>NERDCommenterToggle `<
  vmap <leader>ci <plug>NERDCommenterInvert `<
  vmap <leader>ct <plug>NERDCommenterInvert `<
  " map <leader>c<space> <plug>NERDCommenterInvert
  nnoremap <leader>cA <plug>NERDCommenterAppend
  nnoremap <leader>ca A<space><c-c><plug>NERDCommenterAppend
  nnoremap <leader>cl A<c-c><plug>NERDCommenterAppend<bs><c-g>U<left><bs><right><c-c>
  nnoremap <leader>co o<space><bs><c-c><plug>NERDCommenterAppend<c-o><<<c-o>$
  nnoremap <leader>cO O<space><bs><c-c><plug>NERDCommenterAppend<c-o><<<c-o>$
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
" set statusline+=%{GitStatus()}

let g:currentmode = {
	\ 'n'  : 'Normal',
	\ 'no' : 'Operator Pending',
	\ 'v'  : 'Visual',
	\ 'V'  : 'Visual Line',
	\ '' : 'Visual Block',
	\ 's'  : 'Select',
	\ 'S'  : 'S·Line',
	\ '' : 'S·Block',
	\ 'i'  : 'Insert',
	\ 'R'  : 'Replace',
	\ 'Rv' : 'Visual Replace',
	\ 'c'  : 'Command',
	\ 'cv' : 'Vim Ex',
	\ 'ce' : 'Ex',
	\ 'r'  : 'Prompt',
	\ 'rm' : 'More',
	\ 'r?' : 'Confirm',
	\ '!'  : 'Shell',
	\}

autocmd VimEnter * :clearjumps
