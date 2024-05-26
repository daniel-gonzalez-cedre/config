filetype plugin indent on
silent
syntax enable
au FileType * set conceallevel=0
autocmd BufEnter * :syntax sync fromstart

if !isdirectory($HOME."/.vim")
  call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undodir")
  call mkdir($HOME."/.vim/undodir", "", 0700)
endif
set undodir=~/.vim/undodir
set undofile

" LEADER
  nnoremap <space> <nop>
  vnoremap <space> <nop>
  let mapleader=' '

" NOP MAPPINGS
  " silence macro recording
  map q <nop>
  noremap <leader>q q
  vnoremap <bs> <nop>
  nnoremap ZZ <nop>
  nnoremap Zz <nop>
  nnoremap ZX <nop>
  nnoremap Zx <nop>
  " unmap tmux leader key
  map <c-b> <nop>
  map! <c-b> <nop>

" PACKAGES
  if has('nvim')
    " packadd! nvim-treesitter
  else
    " packadd! ale
    let g:ale_sign_error = ' ×'
    let g:ale_sign_warning = ' ⋅'
    let g:ale_linters = {'vim': ['vint'], 'python': ['mypy', 'pylint'], 'lua': ['luacheck', 'luac'], 'tex': ['lacheck']}  " ruff, pylint, pyright, lacheck, chktek, proselint
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_lint_delay = 0
    let g:ale_lint_on_save = 1
    let b:ale_virtualtext_prefix = ' '
    let g:ale_virtualtext_cursor = 'current'
    let g:ale_virtualtext_delay = 0
    let g:ale_echo_cursor = 0
    map <leader>aa :ALEToggle<cr>
    map <leader>at :ALEToggle<cr>
    map ]a :ALENextWrap<cr>
    map [a :ALEPreviousWrap<cr>
    map <leader>an :ALENextWrap<cr>
    map <leader>aN :ALEPreviousWrap<cr>
    map <leader>al :ALELint<cr>
    map <leader>ad :ALEDetail<cr>
  endif

  packadd julia-vim

  packadd vimtex
    let g:vimtex_compiler_enabled = 0
    let g:vimtex_complete_enabled = 0
    " let g:vimtex_fold_enabled = 1
    let g:vimtex_imaps_enabled = 0
    " let g:vimtex_mappings_enabled = 0
    let g:vimtex_quickfix_enabled = 0
    let g:vimtex_syntax_nospell_comments = 1
    let g:vimtex_view_enabled = 0

" SET OPTIONS
  " FILETYPE SPECIFIC
    " PYTHON
    augroup python_settings | au!
      au Filetype python setlocal shiftwidth=2
      au Filetype python setlocal softtabstop=2
      au Filetype python setlocal tabstop=8
    augroup END
    
    " LaTeX
    augroup latex_settings | au!
      " au Filetype tex packadd vimtex
      let g:Tex_SmartQuoteOpen = "``"
      let g:Tex_SmartQuoteClose = "''"
      " let g:tex_flavor="latex"
      " let g:tex_fold_enabled=1

      " au Filetype tex set foldmethod=syntax
    augroup END

  " GENERAL
    set background=dark
    set backspace=indent,eol,start
    set conceallevel=0
    set cursorline
    set display+=lastline
    set fillchars=stl:⋅,stlnc:⋅,vert:\|,fold:-
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
    set spell
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
    set updatetime=200
    set wildmenu
    set wildmode=list:longest,full
    " set nospell
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
  let g:gitgutter_map_keys = 0
  let g:gruvbox_improved_strings = 1
  let g:gruvbox_improved_warnings = 1
  let g:gruvbox_hls_cursor = 'orange'
  let g:gruvbox_contrast_dark = 'hard'
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
  noremap <leader>h :noh<bar>:echo<cr>
  noremap <leader>th :set nohlsearch!<cr>
  map <leader>tw :setlocal nowrap!<cr>
  map <leader>tb :call ToggleBackground()<cr>
  map <leader>tg :call ToggleGMove()<cr>
  map <leader>ts :setlocal spell!<cr>
  " relative line numbers
  nnoremap <leader>rln :set rnu!<cr>


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


" CLEAR MAPPINGS
  nmap i i
  nmap I I
  nmap a a
  nmap A A
  nmap o o
  nmap O O
  nmap gi gi
  nmap gI gI
  nmap s s
  nmap S S
  nmap r r
  nmap R R
  nmap c c
  nmap C C
  " nnoremap d :noh<bar>:echo<cr>d
  " nnoremap D :noh<bar>:echo<cr>D
  " vnoremap x x<c-C>
  " vnoremap X X<c-C>
  nmap v v
  nmap V V


" SEARCH MAPPINGS
  " search & replace (blank)
  nnoremap <leader>s :%s//gc<left><left><left>
  " search visual selection
  vnoremap // y/\V<c-r>=escape(@",'/\')<cr>
  " search & replace visual selection
  vnoremap <leader>s y`<`>:<c-u>%s/\V<c-r>=escape(@",'/\')<cr>//gc<left><left><left>


" QUALITY OF LIFE MAPPINGS
  noremap <c-f> $
  noremap! <c-f> $
  noremap <c-\> ^
  noremap! <c-\> ^

  " movement
  nnoremap j gj
  nnoremap k gk
  " nnoremap gj j
  " nnoremap gk k

  noremap <up> <c-y>
  noremap <down> <c-e>
  noremap <left> zh
  noremap <right> zl

  vnoremap <expr> i mode()=~'\cv' ? 'i' : 'I'
  vnoremap <expr> a mode()=~'\cv' ? 'a' : 'A'

  " nnoremap <silent> <c-o> :call JumpWithinFile ("\<c-i>", "\<c-o>")<cr>
  " nnoremap <silent> <c-i> :call JumpWithinFile ("\<c-o>", "\<c-i>")<cr>

  " nnoremap <silent> <leader>o :call JumpWithinFile ("\<c-i>", "\<c-o>")<cr>
  " nnoremap <silent> <leader>i :call JumpWithinFile ("\<c-o>", "\<c-i>")<cr>

  " nnoremap <c-t> <c-y>

  " text object for current line
  xnoremap il g_o^
  onoremap <silent> il :normal vil<cr>
  xnoremap al $o^
  onoremap <silent> al :normal val<cr>

  " status bar auto-clearing
  noremap <silent> <c-c> <esc>
  nnoremap <silent> <c-c> :noh<bar>:echo<cr><esc>
  inoremap <silent> <c-c> <esc>:noh<bar>:echo<cr>
  nnoremap <c-v> :noh<bar>:echo<cr><c-v>
  nnoremap <silent> <cr> :noh<bar>:echo<cr>
  nnoremap <silent> <bs> :noh<bar>:echo<cr>

  " misc
  nmap <tab> za
  " map <c-f> za
  " map <leader><c-f> zA
  inoremap <c-]> <del>
  inoremap <expr> <cr> pumvisible() ? !empty(v:completed_item) ? "<c-y><c-c>" : "<c-y><cr>" : "<cr>"


  if has('clipboard')
    noremap y "+y
    noremap Y "+Y
    noremap d "+d
    noremap dd "+dd
    noremap D "+D
    vnoremap x "+x
    vnoremap X "+X
    noremap p "+p
    noremap P "+P
  endif


" DELIMITER MAPPINGS
  inoremap ( ()<left>
  inoremap [ []<left>
  inoremap { {}<left>
  inoremap ) <c-r>=ClosePair(')')<cr>
  inoremap ] <c-r>=ClosePair(']')<cr>
  inoremap } <c-r>=ClosePair('}')<cr>
  inoremap > <c-r>=ClosePair('>')<cr>
  inoremap " <c-r>=ClosePair('"')<cr>
  inoremap ' <c-r>=ClosePair("'")<cr>
  inoremap ` <c-r>=ClosePair('`')<cr>
  inoremap $ <c-r>=ClosePair('$')<cr>
  inoremap <c-f> <c-r>=ClosePair('$')<cr>
  " inoremap " <c-r>=QuoteDelim('"')<cr>
  " inoremap ' <c-r>=QuoteDelim("'")<cr>
  " inoremap ` <c-r>=QuoteDelim('`')<cr>

  vmap <leader>p <s-s>)<cr>
  vmap <leader>( <s-s>)<cr>
  vmap <leader>) <s-s>)<cr>

  vmap <leader>r <s-s>]<cr>
  vmap <leader>[ <s-s>]<cr>
  vmap <leader>] <s-s>]<cr>

  vmap <leader>b <s-s>}<cr>
  vmap <leader>{ <s-s>}<cr>
  vmap <leader>} <s-s>}<cr>

  vmap <leader>a <s-s>><cr>
  vmap <leader>< <s-s>><cr>
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

  function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
      return "\<right>"
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
      return "\<right>"
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

  function! TwiddleCase(str)
    return substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  endfunction


" COLORS
  function! s:gruvbox_custom()
    hi Comment ctermfg=240 ctermbg=none cterm=none
    " hi Folded ctermfg=95 ctermbg=234
    hi Folded ctermfg=237 ctermbg=none cterm=none
    hi String ctermfg=142 ctermbg=none cterm=none

    hi StatusLine ctermfg=237 ctermbg=none cterm=none
    hi StatusLineNC ctermfg=237 ctermbg=none cterm=none

    hi MatchParen cterm=inverse
    hi Visual ctermfg=none ctermbg=none cterm=inverse

    hi clear SignColumn
    hi LineNR ctermfg=237 cterm=none
    hi CursorLine ctermfg=none ctermbg=none cterm=none
    hi CursorLineNR ctermbg=none

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
      hi ALEErrorLine ctermbg=none cterm=none
      hi ALEWarningLine ctermbg=none cterm=none
      hi ALEError ctermbg=none cterm=none
      hi ALEWarning ctermbg=none cterm=none
      hi ALEErrorSign ctermfg=167 ctermbg=none
      hi ALEWarningSign ctermfg=214 ctermbg=none
      hi ALEInfoSign ctermfg=108 ctermbg=none
      hi ALEVirtualTextError ctermfg=238
      hi ALEVirtualTextWarning ctermfg=238
    endif

    hi SignColumn ctermbg=black
  endfunction

  function! s:gitgutter_custom()
    highlight clear SignColumn
    highlight GitGutterAdd ctermfg=142 ctermbg=none
    highlight GitGutterChange ctermfg=109 ctermbg=none
    highlight GitGutterDelete ctermfg=167 ctermbg=none
    highlight GitGutterChangeDelete ctermfg=175 ctermbg=none
  endfunction

  augroup custom_colors | au!
    au ColorScheme gruvbox call s:gruvbox_custom()
    au ColorScheme gruvbox call s:gitgutter_custom()
  augroup END

  colorscheme gruvbox

" CUSTOM CURSORS
  " LINE: \e[5
  " BLOCK:
  " UNDERLINE: \e[4
  let &t_SI="\e[5 q"      " LINE: start insert mode
  " let &t_SI="\e[4 q"    " UNDERLINE: start insert mode
  let &t_EI="\e[1 q"      " UNDERLINE: end insert mode
  " let &t_EI="\e[2 q"    " BLOCK: end insert mode

" NERDCommenter MAPPINGS
autocmd! VimEnter * call s:nerdcommenter_mappings()
function! s:nerdcommenter_mappings()
  map <leader>cc <plug>NERDCommenterToggle
  map <leader>ct <plug>NERDCommenterInvert
  map <leader>c<space> <plug>NERDCommenterInvert
  noremap <leader>ci <plug>NERDCommenterAppend
  noremap <leader>ca A<space><c-c><plug>NERDCommenterAppend
  noremap <leader>cl A<c-c><plug>NERDCommenterAppend<bs><left><bs><right><c-c>
  noremap <leader>co o<space><bs><c-c><plug>NERDCommenterAppend<c-o><<<c-o>$
  noremap <leader>cO O<space><bs><c-c><plug>NERDCommenterAppend<c-o><<<c-o>$
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
" set statusline+=%{GitStatus()}

let g:currentmode={
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
