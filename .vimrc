" INIT
  filetype plugin indent on
  silent
  syntax enable

  augroup init_settings | au!
    au FileType * set conceallevel=0
    au BufEnter * :syntax sync fromstart
  augroup END

  " set home config directory
  if !isdirectory($HOME.'/.vim')
    call mkdir($HOME.'/.vim', '', 0770)
  endif

  " set swap file directory
  if !isdirectory($HOME.'/.vim/swapfiles')
    call mkdir($HOME.'/.vim/swapfiles', '', 0700)
  endif
  set directory=~/.vim/swapfiles//

  " set undo directory
  if !isdirectory($HOME.'/.vim/undodir')
    call mkdir($HOME.'/.vim/undodir', '', 0700)
  endif
  set undodir=~/.vim/undodir
  set undofile

  " make sure colors are set correctly
  " if $TERM_PROGRAM !=# 'Apple_Terminal' || $TMUX !=? ''
  if $TERM_PROGRAM !=# 'Apple_Terminal'
    if (has('nvim'))
      "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    set termguicolors
  endif

  " reload if file has been edited elsewhere
  redir => capture
  silent autocmd CursorHold
  redir END
  if match(capture, 'checktime') == -1
    augroup reload_settings
      au!
      au CursorHold * silent! checktime
    augroup END
  endif


" LEADER KEY
  nnoremap <space> <nop>
  vnoremap <space> <nop>
  let mapleader = ' '


" NOP MAPPINGS
  " silence macro recording
  noremap q <nop>
  noremap <leader><c-q> q

  nnoremap ZZ <nop>
  nnoremap Zz <nop>
  nnoremap ZX <nop>
  nnoremap Zx <nop>

  " unmap tmux leader key
  noremap <c-b> <nop>
  noremap! <c-b> <nop>

  nmap <s-cr> <cr>
  vmap <s-cr> <cr>
  " nmap <c-cr> <cr>
  " vmap <c-cr> <cr>
  " nmap <s-bs> <bs>
  " vmap <s-bs> <bs>
  " nmap <c-bs> <bs>
  " vmap <c-bs> <bs>

  nnoremap <s-up> <nop>
  nnoremap <s-down> <nop>
  nnoremap <s-left> <nop>
  nnoremap <s-right> <nop>
  inoremap <s-up> <nop>
  inoremap <s-down> <nop>
  inoremap <s-left> <nop>
  inoremap <s-right> <nop>

  nnoremap <silent> <cr> :noh<bar>:echo<cr>
  nnoremap <silent> <bs> :noh<bar>:echo<cr>
  vnoremap <silent> <bs> <nop>

  noremap <silent> <c-c> <esc><esc>
  nnoremap <silent> <c-c> :noh<bar>:echo<cr><esc><esc>
  inoremap <silent> <c-c> <esc><esc>:noh<bar>:echo<cr>
  " vnoremap <silent> <c-c> <c-c><c-c>`<


" COLORS
  function! s:set_lightline_colorscheme(name) abort
    let g:lightline.colorscheme = a:name
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endfunction

  " TODO: not working when refocussing after closing pane with <c-d>
  function! s:focus_gained_buffer()
    setlocal ruler
    setlocal showcmd
    hi! link SignColumn NONE
    hi! link LineNR NONE
    hi! link CursorLineNR NONE

    call s:set_lightline_colorscheme('gruvbox_material')

    if g:gitgutter_is_loaded
      GitGutterBufferEnable
    endif
    if g:ale_is_loaded
      ALELint
    endif
  endfunction

  " TODO: not working when tmux split pane
  function! s:focus_lost_buffer()
    setlocal noruler
    setlocal noshowcmd
    hi Blank guifg=#262626 guibg=#262626 ctermfg=0 ctermbg=0
    hi! link SignColumn Blank
    hi! link LineNR Blank
    hi! link CursorLineNR Blank

    call s:set_lightline_colorscheme('blank')

    if g:gitgutter_is_loaded
      GitGutterBufferDisable
    endif
    if g:ale_is_loaded
      ALEReset
    endif

    echo @%
  endfunction

  augroup active_focused_window | au!
    au FocusGained * call s:focus_gained_buffer()
    au FocusLost * call s:focus_lost_buffer()
  augroup END

  function! s:gruvbox_colors()
    hi clear Folded
    hi Folded guifg=#504945 ctermfg=240 ctermbg=none cterm=none

    " hi clear Comment
    " hi Comment ctermfg=243 ctermbg=none cterm=none

    hi clear String
    hi String guifg=#b8bb26 ctermfg=142 cterm=none

    hi clear StatusLine
    hi clear StatusLineNC
    hi StatusLine guifg=#504945 ctermfg=240 ctermbg=none cterm=none
    hi StatusLineNC guifg=#504945 ctermfg=240 ctermbg=none cterm=none

    hi clear Visual
    " hi Visual ctermfg=none ctermbg=none cterm=inverse
    " hi Visual ctermbg=238
    hi Visual guibg=#504945 ctermbg=239 cterm=none
    " hi Visual guifg=#ebdbb2 guibg=#504945 ctermfg=15 ctermbg=239 cterm=none

    hi clear Matchparen
    " hi MatchParen guibg=#504945 ctermfg=0 ctermbg=240
    " hi MatchParen cterm=inverse
    hi MatchParen cterm=bold

    hi clear SignColumn
    hi clear LineNR
    hi clear CursorLine
    hi clear CursorLineNR
    hi LineNR guifg=#504945 ctermfg=240 cterm=none
    " hi CursorLine ctermfg=none ctermbg=235 cterm=none
    hi CursorLineNR guifg=#7c6f64 ctermfg=244 cterm=none

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

    if g:ale_is_loaded
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
      hi ALEVirtualTextError guifg=#504945 ctermfg=240
      " hi ALEVirtualTextError ctermfg=167
      hi ALEVirtualTextWarning guifg=#504945 ctermfg=240
      " hi ALEVirtualTextWarning ctermfg=214
    endif

    hi SignColumn ctermbg=black
  endfunction

  function! s:gruvbox_material_colors()
    let l:palette = gruvbox_material#get_palette('medium', 'material', {})

    " call gruvbox_material#highlight('Function', l:palette.orange, l:palette.none)
    call gruvbox_material#highlight('Folded', l:palette.bg5, l:palette.none)
    " call gruvbox_material#highlight('String', l:palette.fg1, l:palette.none, 'bold')
    call gruvbox_material#highlight('String', l:palette.fg1, l:palette.none, 'bold')

    call gruvbox_material#highlight('Todo', l:palette.grey1, l:palette.none, 'bold')

    call gruvbox_material#highlight('ErrorText', l:palette.none, l:palette.none, 'undercurl', l:palette.red)
    call gruvbox_material#highlight('WarningText', l:palette.none, l:palette.none, 'undercurl', l:palette.yellow)
    call gruvbox_material#highlight('InfoText', l:palette.none, l:palette.none, 'undercurl', l:palette.blue)
    call gruvbox_material#highlight('HintText', l:palette.none, l:palette.none, 'undercurl', l:palette.green)

    " call gruvbox_material#highlight('CursorLine', l:palette.none, ['#2a2a2a',   '235'])
    " call gruvbox_material#highlight('CursorLineNr', l:palette.grey1, ['#2a2a2a',   '235'])
    " call gruvbox_material#highlight('CursorLine', l:palette.none, l:palette.bg1)
    " call gruvbox_material#highlight('CursorLineNr', l:palette.grey1, l:palette.bg1)
    call gruvbox_material#highlight('CursorLine', l:palette.none, l:palette.none)
    call gruvbox_material#highlight('CursorLineNr', l:palette.grey1, l:palette.none)
    " call gruvbox_material#highlight('StatusLine', l:palette.bg2, l:palette.none)
    " call gruvbox_material#highlight('StatusLineNC', l:palette.bg2, l:palette.none)

    " call gruvbox_material#highlight('MatchParen', l:palette.red, l:palette.none, 'bold')
    " call gruvbox_material#highlight('MatchParen', l:palette.none, l:palette.none, 'bold')
    call gruvbox_material#highlight('MatchParen', l:palette.none, l:palette.bg0, 'bold')
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
    " gruvbox
    let g:gruvbox_improved_strings = 1  " (0), 1
    let g:gruvbox_improved_warnings = 1  " (0), 1
    let g:gruvbox_hls_cursor = 'orange'
    let g:gruvbox_contrast_dark = 'medium'  " soft, (medium), hard
    let g:gruvbox_contrast_light = 'hard'  " soft, (medium), hard
    au ColorScheme gruvbox call s:gruvbox_colors()

    " gruvbox-material
    let g:gruvbox_material_background = 'medium'  " soft, (medium), hard
    let g:gruvbox_material_foreground = 'material'  " (material), mix, original
    let g:gruvbox_material_enable_bold = 0  " (0), 1
    let g:gruvbox_material_enable_italic = 0  " (0), 1
    let g:gruvbox_material_disable_italic_comment = 0  " (0), 1
    let g:gruvbox_material_visual = 'grey background'  " (grey background), red background, green background, blue background, reverse
    let g:gruvbox_material_menu_selection_background = 'yellow'  " (grey), red, orange, yellow, green, aqua, blue, purple
    let g:gruvbox_material_spell_foreground = 'colored'  " (none), colored
    let g:gruvbox_material_ui_contrast = 'low'  " (low), high
    let g:gruvbox_material_float_style = 'bright'  " (bright), dim
    let g:gruvbox_material_diagnostic_text_highlight = 0  " (0), 1
    let g:gruvbox_material_diagnostic_line_highlight = 0  " (0), 1
    let g:gruvbox_material_diagnostic_virtual_text = 'colored'  " (grey), colored, highlighted
    let g:gruvbox_material_better_performance = 1  " (0), 1
    let g:gruvbox_material_colors_override = {'bg0': ['#262626', '235']}
    au ColorScheme gruvbox-material call s:gruvbox_material_colors()
  augroup END

  packadd! gruvbox-material
  colorscheme gruvbox-material


" PACKAGES
  let g:matchup_is_loaded = 0
  let g:lightline_is_loaded = 0
  let g:nrrwrgn_is_loaded = 0
  let g:tabular_is_loaded = 0
  let g:fanfingtastic_is_loaded = 0
  let g:polyglot_is_loaded = 0
  let g:juliavim_is_loaded = 0
  let g:rainbow_is_loaded=0
  let g:gitgutter_is_loaded = 0
  let g:nerdcommenter_is_loaded = 0
  let g:ale_is_loaded = 0
  let g:vimtex_is_loaded = 0

  let g:matchup_is_loaded = 1
  packadd vim-matchup
  augroup matchup_settings | au!
    let g:matchup_matchparen_offscreen = {'method': 'popup'}
    " let g:matchup_matchparen_offscreen = {}
    let g:matchup_matchparen_stopline = 50
    let g:matchup_matchparen_deferred = 1
    let g:matchup_matchparen_deferred_show_delay = 0
    let g:matchup_matchparen_deferred_hide_delay = 0
    let g:matchup_matchparen_hi_surround_always = 1
    let g:matchup_matchparen_timeout = 50
    let g:matchup_matchparen_insert_timeout = 10

    let g:palette = gruvbox_material#get_palette('medium', 'material', {})
    au ColorScheme * hi MatchParenCur gui=bold cterm=bold
    au ColorScheme * hi MatchWordCur gui=bold cterm=bold
    au ColorScheme * hi MatchWord gui=bold cterm=bold
  augroup END

  let g:lightline_is_loaded = 1
  packadd lightline.vim
    set noshowmode
    function! LightlineFilenameAndMod()
      let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
      let modified = &modified ? ' +' : ''
      return filename . modified
    endfunction

    let g:lightline = { 
          \ 'colorscheme': 'gruvbox_material', 
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'caps', 'filenameAndMod' ] ],
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
          \ }

  " vim-capslock
    nnoremap <silent> <c-g>c <plug>CapsLockToggle:call lightline#update()<cr>
    inoremap <silent> <c-g>c <c-o><plug>CapsLockToggle<c-o>:call lightline#update()<cr>

  let g:nrrwrgn_is_loaded = 1
  packadd NrrwRgn
    vunmap <leader>nr
    vmap <leader>be :NR<cr>
    vmap <leader>bc :NR<cr>
    vmap <leader>bs :NR<cr>

  let g:tabular_is_loaded = 1
  packadd tabular  " tabularize
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

  let g:fanfingtastic_is_loaded = 1
  packadd vim-fanfingtastic
    let g:fanfingtastic_all_inclusive = 1
    let g:fanfingtastic_fix_t = 1
    let g:fanfingtastic_ignorecase = 1

  let g:polyglot_is_loaded = 1
  let g:polyglot_disabled = ['ftdetect', 'sensible']
  " let g:polyglot_disabled = ['ftdetect']
  packadd vim-polyglot
    " let g:polyglot_disabled = ['sensible']

  let g:juliavim_is_loaded = 1
  packadd julia-vim

  let g:rainbow_is_loaded = 1
  let g:rainbow_active = 1
  let g:rainbow_conf = {
    \ 'guifgs': ['#ea6962', '#e78a4e', '#d8a657', '#a9b665', '#89b482', '#7daea3', '#d3869b'],
  \ }
    " \ 'guifgs': ['#89b482', '#d8a657', '#e78a4e', '#7daea3', '#a9b665', '#ea6962'],
    " \ 'guifgs': ['#7daea3', '#89b482', '#a9b665', '#d8a657', '#e78a4e', '#ea6962', '#d3869b'],
    " \ 'guifgs': ['#ea6962', '#e78a4e', '#d8a657', '#a9b665', '#89b482', '#7daea3', '#d3869b'],
  packadd rainbow

  let g:gitgutter_is_loaded = 1
  packadd vim-gitgutter
  augroup gitgutter_settings | au!
    let g:gitgutter_map_keys = 1
    let g:gitgutter_sign_added = '⋅ '
    let g:gitgutter_sign_modified = '⋅ '
    let g:gitgutter_sign_removed = '⋅ '
    " let g:gitgutter_sign_removed_first_line = '  '
    " let g:gitgutter_sign_removed_above_and_below = '  '
    let g:gitgutter_sign_modified_removed = '⋅ '
    call gitgutter#highlight#define_signs()

    if g:gitgutter_is_loaded
      au ColorScheme gruvbox call s:gitgutter_colors()
    endif

    nmap ]g <Plug>(GitGutterNextHunk)
    nmap [g <Plug>(GitGutterPrevHunk)
    omap ig <Plug>(GitGutterTextObjectInnerPending)
    omap ag <Plug>(GitGutterTextObjectOuterPending)
    xmap ig <Plug>(GitGutterTextObjectInnerVisual)
    xmap ag <Plug>(GitGutterTextObjectOuterVisual)
    nmap <leader>gf :GitGutterFold<cr>

    function! GitStatus()
      let [a,m,r] = GitGutterGetHunkSummary()
      return printf('+%d ~%d -%d', a, m, r)
    endfunction
    " set statusline+=%{GitStatus()}
  augroup END

  let nerdcommenter_is_loaded = 1
  packadd nerdcommenter
  augroup nerdcommenter_settings | au!
    let g:NERDCommentEmptyLines = 0
    let g:NERDCompactSexyComs = 1
    let g:NERDCustomDelimiters = {
          \ 'python': { 'left': '#', 'right': '' },
          \ 'julia': { 'left': '#', 'right': '' },
          \ 'typst': { 'left': '//', 'right': '' }
          \ }
    " let g:NERDDefaultAlign = 'left'
    let g:NERDSpaceDelims = 1
    let g:NERDToggleCheckAllLines = 1
    let g:NERDTrimTrailingWhitespace = 1
    au! VimEnter * call s:nerdcommenter_mappings()

    function! s:nerdcommenter_mappings()
      nmap <leader>cc <plug>NERDCommenterToggle
      nmap <leader>ci <plug>NERDCommenterInvert
      nmap <leader>ct <plug>NERDCommenterInvert
      vmap <leader>cc <plug>NERDCommenterToggle `<
      vmap <leader>ci <plug>NERDCommenterInvert `<
      vmap <leader>ct <plug>NERDCommenterInvert `<
      nnoremap <leader>cA <plug>NERDCommenterAppend
      nnoremap <leader>ca A<space><c-c><plug>NERDCommenterAppend
      nnoremap <leader>cl A<esc><plug>NERDCommenterAppend<bs><c-g>U<left><bs><right><esc>
      nnoremap <leader>co o<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$
      nnoremap <leader>cO O<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$
    endfunction
  augroup END

  augroup ale_settings | au!
    let g:ale_sign_error = '×⟩'
    let g:ale_sign_warning = '~⟩'
    let g:ale_linters = {
          \ 'vim': ['vint'],
          \ 'python': ['ruff', 'mypy'],
          \ 'lua': ['luacheck', 'luac'],
          \ 'tex': ['lacheck']
          \ }
    " let g:ale_lint_on_text_changed = 'always'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_lint_delay = 0
    let g:ale_lint_on_save = 1
    " let g:ale_virtualtext_prefix = '  '
    let g:ale_virtualtext_prefix = ' ⟨⋅ '
    let g:ale_virtualtext_cursor = 'current'
    let g:ale_virtualtext_delay = 0
    let g:ale_echo_cursor = 0
    " let g:ale_echo_detail = 1
    " let g:ale_echo_delay = 0
    let g:ale_python_pylint_options = "--init-hook=\"import sys; sys.path.append(\'" . trim(system('git rev-parse --show-toplevel')) . "\')\""

    au FileType python call s:setup_ale()
    au FileType lua call s:setup_ale()
    au FileType vim call s:setup_ale()
    au FileType tex call s:setup_ale()

    " linters: ruff, mypy, pylint, pyright, lacheck, chktek, proselint
    function! s:setup_ale()
      packadd ale
      let g:ale_is_loaded = 1

      map ]a :ALENextWrap<cr>
      map [a :ALEPreviousWrap<cr>
      map ]e <Plug>(ale_next_wrap_error)
      map [e <Plug>(ale_previous_wrap_error)
      map ]w <Plug>(ale_next_wrap_warning)
      map [w <Plug>(ale_previous_wrap_warning)
      nmap <leader>at :ALEToggle<cr>
      nmap <leader>al :ALELint<cr>
      map <leader>bd :ALEDetail<cr>
    endfunction
  augroup END


" SET OPTIONS
  " FILETYPE SPECIFIC
    augroup python_settings | au!
      au FileType python setlocal shiftwidth=2
      au FileType python setlocal softtabstop=2
      au FileType python setlocal tabstop=8
    augroup END

    augroup html_settings | au!
      au BufNewFile,BufRead *.svg set filetype=html
      au FileType html inoremap < <><c-g>U<left>
    augroup END
    
    augroup latex_settings | au!
      " packadd vimtex
      " let g:vimtex_is_loaded = 1

      au BufNewFile,BufRead *.bib,*.tex,*.tikz set filetype=tex
      au BufNewFile,BufRead *.bib,*.tex,*.tikz set syntax=tex

      au BufNewFile,BufRead *.bib,*.tex,*.tikz imap ` <nop>
      au BufNewFile,BufRead *.bib,*.tex,*.tikz iunmap `

      au FileType tex inoremap $ <c-r>=ClosePair('$')<cr>
      au FileType tex inoremap <c-f> <c-r>=ClosePair('$')<cr>
      " au FileType tex inoremap <c-\> <c-r>=QuoteDelim('$')<cr>

      " au FileType tex set foldmethod=syntax

      if g:vimtex_is_loaded
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
      endif

    augroup END

  " GENERAL
    augroup set_settings | au!
      autocmd BufNewFile,BufRead * setlocal formatoptions-=c
      autocmd BufNewFile,BufRead * setlocal formatoptions-=o
      autocmd BufNewFile,BufRead * setlocal formatoptions+=r
      autocmd BufNewFile,BufRead * setlocal formatoptions+=j
    augroup END
    set background=dark
    set backspace=indent,eol,start
    set conceallevel=0
    set cursorline
    set display+=lastline
    " set fillchars=stl:⋅,stlnc:⋅,vert:\|,fold:⋅
    set formatoptions-=c
    set formatoptions-=o
    set formatoptions+=r
    set formatoptions+=j
    set hlsearch
    set ignorecase
    set incsearch
    set nojoinspaces
    set laststatus=2
    set matchpairs+=<:>
    set mouse=""
    " set spell
    set nospell
    set number
    set numberwidth=3
    " set ruler
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

  " " POP-UP WINDOW
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
  let g:haskell_indent_if = 2
  let g:haskell_indent_case = 4
  let g:haskell_indent_guard = 5
  let g:incsearch#auto_nohlsearch = 1
  let g:latex_to_unicode_file_types = '.*'
  let g:matchparen_timeout = 8
  let g:matchparen_insert_timeout = 8
  let g:python_highlight_all = 1
  let g:tex_flavor = 'latex'
  let g:unicoder_cancel_normal = 1
  " let g:unicoder_cancel_insert = 1
  let g:unicoder_cancel_visual = 1


" TOGGLE MAPPINGS
  if g:rainbow_is_loaded
    nnoremap <leader>tr :RainbowToggle<cr>
  endif
  nnoremap <leader>tw :setlocal nowrap!<cr>
  nnoremap <leader>ts :setlocal spell!<cr>
  nnoremap <leader>tgm :call ToggleGMove()<cr>
  nnoremap <leader>tq :call ToggleQuote()<cr>
  nnoremap <leader>t' :call ToggleQuote()<cr>
  nnoremap <leader>t" :call ToggleQuote()<cr>
  " noremap <leader>h :noh<bar>:echo<cr>
  " nnoremap <leader>th :set nohlsearch!<cr>
  " nnoremap <leader>tb :call ToggleBackground()<cr>

  nnoremap <leader>tgit :GitGutterToggle<cr>

  " relative line numbers
  " nnoremap <leader>trln :set rnu!<cr>


" Z MAPPINGS
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
  nnoremap <leader>s :%s//gc<left><left><left>
  nnoremap ? /<up>

  vnoremap <leader>/ y/\V<c-r>=escape(@",'/\')<cr>
  vnoremap <leader>F y/\V<c-r>=escape(@",'/\')<cr>
  vnoremap <leader>s y`<`>:<c-u>%s/\V<c-r>=escape(@",'/\')<cr>//gc<left><left><left>

  " toggle highlighting on search
  augroup search_highlight_toggling | au!
    " au CmdlineEnter /,\? :set hlsearch

    " au CmdlineEnter /,\? hi clear Search
    " au CmdlineEnter /,\? hi Search guifg=#fabd2f guibg=#504945 ctermfg=15 ctermbg=239 cterm=none

    au InsertEnter * call feedkeys("\<cmd>noh\<cr>" , 'n')
    au TextChanged * call feedkeys("\<cmd>noh\<cr>" , 'n')
  augroup END


" QUALITY OF LIFE MAPPINGS
  " COMMAND MAPPINGS
    " cnoremap <tab> <c-g>
    " cnoremap <s-tab> <c-t>
    nmap <c-f> %
    vmap <c-f> %

    nmap [<c-f> [%
    nmap ]<c-f> ]%

    vmap i<c-f> i%
    vmap a<c-f> a%

    omap i<c-f> i%
    omap a<c-f> a%

    xmap i<c-f> i%
    xmap a<c-f> a%

    " nnoremap <c-\> <c-a>
    " vnoremap <c-\> <c-a>
    " nnoremap <c-_> <c-x>
    " vnoremap <c-_> <c-x>

    nnoremap ga ^
    vnoremap ga ^
    cnoremap <c-a> <home>

    nnoremap ge g_
    vnoremap ge g_
    cnoremap <c-e> <end>

  " BUFFER MAPPINGS
  noremap <leader>bb :call ScratchBuffer()<cr>
  " noremap <leader>bs :call ScratchBuffer()<cr>

  " movement
  inoremap <left> <c-g>U<left>
  inoremap <right> <c-g>U<right>
  " noremap \h <c-w>h
  " noremap \j <c-w>j
  " noremap \k <c-w>k
  " noremap \l <c-w>l

  nnoremap j gj
  nnoremap k gk
  nnoremap gj j
  nnoremap gk k

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
  inoremap <c-f> $
  inoremap ( ()<c-g>U<left>
  inoremap [ []<c-g>U<left>
  inoremap { {}<c-g>U<left>
  inoremap ) <c-r>=ClosePair(')')<cr>
  inoremap ] <c-r>=ClosePair(']')<cr>
  inoremap } <c-r>=ClosePair('}')<cr> () {} <> {}
  inoremap > <c-r>=ClosePair('>')<cr>
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

  " vmap <leader>a <s-s>><cr>
  vmap <leader>k <s-s>><cr>
  vmap <leader>< <s-s><<cr>
  vmap <leader>> <s-s>><cr>

  vmap <leader>m <s-s>$<cr>
  vmap <leader>$ <s-s>$<cr>

  vmap <leader>" <s-s>"<cr>
  vmap <leader>' <s-s>'<cr>
  vmap <leader>` <s-s>`<cr>
  vmap <leader><c-q> <s-s><c-q><cr>
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
    if !exists('*synstack')
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

  function! MoveMap()
    if (maparg('h') ==# ':noh<bar>:echo<cr>h') || (maparg('j') ==# ':noh<bar>:echo<cr>j') || (maparg('k') ==# ':noh<bar>:echo<cr>k') || (maparg('l') ==# ':noh<bar>:echo<cr>l')
      unmap h
      unmap j
      unmap k
      unmap l
    else
      nnoremap h :noh<bar>:echo<cr>h
      nnoremap j :noh<bar>:echo<cr>j
      nnoremap k :noh<bar>:echo<cr>k
      nnoremap l :noh<bar>:echo<cr>l
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

" CUSTOM CURSORS
  " BLINKING BLOCK:     \e[0
  " BLINKING BLOCK:     \e[1
  " STEADY BLOCK:       \e[2
  " BLINKING UNDERLINE: \e[3
  " STEADY UNDERLINE:   \e[4
  " BLINKING BAR:       \e[5
  " STEADY BAR:         \e[6
  augroup custom_cursors | au! 
    let &t_SI="\e[6 q"  " start insert mode
    let &t_EI="\e[2 q"  " end insert mode
    autocmd VimEnter * silent !echo \ne "\e[2 q"
  augroup END

" UNDERCURL SUPPORT FOR WEZTERM
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"

augroup jump_settings | au!
  autocmd VimEnter * :clearjumps
augroup END
