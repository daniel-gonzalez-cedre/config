" ☡
" setlocal spell

" INIT
  filetype plugin indent on
  syntax enable
  silent
  runtime ftplugin/man.vim

  " :call HelptagsAll()
  " function HelptagsAll()
  "   command! -nargs=0 -bar Helptags
  "       \  for p in glob('~/.vim/pack/plugins/opt/*', 1, 1)
  "       \|     exe 'packadd ' . fnamemodify(p, ':t')
  "       \| endfor
  "       \| helptags ALL
  " endfunction

  augroup init_settings | au!
    " uncomment this line ∨∨∨
    " au VimEnter,BufEnter,BufNewFile,BufReadPost * set nospell
    " uncomment this line ∧∧∧

    " au BufEnter * set nospell
    " au BufEnter,BufNewFile,BufReadPost *.vimrc,*.vim setlocal nospell
    " au FileType vim set nospell
    " au FileType text,markdown,html,tex,vim,gitcommit set spell

    au VimEnter,BufEnter,BufNewFile,BufReadPost * syntax sync fromstart
    au VimEnter,BufEnter,BufNewFile,BufReadPost * set conceallevel=0
    " au BufEnter,BufNewFile,BufReadPost * set conceallevel=1
    " au FileType * syntax keyword Normal lambda conceal cchar=λ

    " au VimEnter * set completeopt=menuone,popup,noinsert,noselect,fuzzy
    au VimEnter * set completepopup=height:16,width:32
    au VimEnter * set previewpopup=height:16,width:32
    " au VimEnter * set completepopup=height:15,width:60,border:off,highlight:PMenuSbar
    " au VimEnter * set previewpopup=height:10,width:60,highlight:PMenuSbar

    au FileType gitcommit set nowrap
    au VimEnter,BufEnter,BufNewFile,BufReadPost,FileType * call SetQuote()

    " CUSTOM CURSORS
      " BLINKING BLOCK:     \e[0
      " BLINKING BLOCK:     \e[1
      " STEADY BLOCK:       \e[2
      " BLINKING UNDERLINE: \e[3
      " STEADY UNDERLINE:   \e[4
      " BLINKING BAR:       \e[5
      " STEADY BAR:         \e[6
      let &t_SI="\e[6 q"  " start insert mode
      let &t_EI="\e[2 q"  " end insert mode
  augroup END

  " set home config directory
  if !isdirectory($HOME.'/.vim')
    call mkdir($HOME.'/.vim', '', 0770)
  endif

  " set directory for miscellaneous book-keeping files
  if !isdirectory($HOME.'/.vim/vimfiles')
    call mkdir($HOME.'/.vim/vimfiles', '', 0700)
  endif

  " set swap directory
  if !isdirectory($HOME.'/.vim/vimfiles/swapfiles')
    call mkdir($HOME.'/.vim/vimfiles/swapfiles', '', 0700)
  endif
  set directory=~/.vim/vimfiles/swapfiles//

  " set views directory
  if !isdirectory($HOME.'/.vim/vimfiles/viewfiles')
    call mkdir($HOME.'/.vim/vimfiles/viewfiles', '', 0700)
  endif
  set viewdir=~/.vim/vimfiles/viewfiles//
  set viewoptions=cursor,folds
  " set viewoptions=cursor
  set sessionoptions=folds
  " set sessionoptions=
  augroup autosave_recovery | au!
    au BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
    " au BufWinLeave * mkview
    au BufWinEnter ?* silent! loadview
  augroup END

  " set undo directory
  if !isdirectory($HOME.'/.vim/vimfiles/undodir')
    call mkdir($HOME.'/.vim/vimfiles/undodir', '', 0700)
  endif
  set undodir=~/.vim/vimfiles/undodir
  set undofile

  " make sure colors are set correctly
  " if $TERM_PROGRAM !=# 'Apple_Terminal' || $TMUX !=? ''
  if $TERM_PROGRAM !=# 'Apple_Terminal'
    set termguicolors

    " UNDERCURL SUPPORT
    let &t_Cs = "\e[4:3m"
    let &t_Ce = "\e[4:0m"

    " COLORED UNDERCURL SUPPORT
    " let &t_RB = "\<esc>]11;?\<C-G>"
    let &t_RV = "\<esc>[>c"

    if &term =~ "alacritty"
      let &t_fe = "\<esc>[?1004h"
      let &t_fd = "\<esc>[?1004l"
    endif

    if (has('nvim'))
      "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
  endif

  " " reload if file has been edited elsewhere
  " redir => capture
  " silent au CursorHold
  " redir END
  " if match(capture, 'checktime') == -1
    " augroup reload_settings
      " au!
      " au CursorHold * silent! checktime
    " augroup END
  " endif


" LEADER KEY
  noremap <silent> <space> <nop>
  let mapleader = "\<space>"


" NOP MAPPINGS
  " silence macro recording
  noremap <silent> q <nop>
  noremap <silent> Qq q
  noremap QQ Q
  " noremap <leader><c-q> q

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
  noremap! <c-b> <nop>

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

  noremap <silent> <c-c> <esc><esc>
  inoremap <silent> <c-c> <esc><esc>
  " nnoremap <silent> <c-c> :noh<bar>:echo<cr><esc><esc>
  " inoremap <silent> <c-c> <esc><esc>:noh<bar>:echo<cr>
  " vnoremap <silent> <c-c> <c-c><c-c>`<

  map <s-cr> <cr>
  " nmap <c-cr> <cr>
  " vmap <c-cr> <cr>
  " nmap <s-bs> <bs>
  " vmap <s-bs> <bs>
  " nmap <c-bs> <bs>
  " vmap <c-bs> <bs>


" COLORS
  function! s:set_lightline_colorscheme(name) abort
    let g:lightline.colorscheme = a:name
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endfunction

  " TODO: not working when refocussing after closing pane with <c-d>
  function! s:focus_gained_buffer()
    " setlocal ruler
    " setlocal showcmd
    " hi! link Folded NONE
    " hi! link FoldColumn NONE
    " hi! link SignColumn NONE
    " hi! link CursorLineNR NONE

    " call s:set_lightline_colorscheme('gruvbox_material')
    call lightline#toggle()

    " if g:gitgutter_is_loaded
      " GitGutterBufferEnable
    " endif
  endfunction

  " TODO: not working when tmux split pane
  function! s:focus_lost_buffer()
    " setlocal noruler
    " setlocal noshowcmd
    " hi Blank guifg=#282828 guibg=NONE ctermfg=0 ctermbg=NONE
    " hi! link Folded LineNR
    " hi! link FoldColumn Blank
    " hi! link SignColumn Blank
    " hi! link CursorLineNR LineNR

    " call s:set_lightline_colorscheme('blank')
    call lightline#toggle()

    " if g:gitgutter_is_loaded
      " GitGutterBufferDisable
    " endif

    " echo @%
    echo ''
  endfunction

  augroup focus | au!
    " let g:focus_status = 0
    " au VimResized * call s:toggle_focus()

    au FocusGained * call s:focus_gained_buffer()
    au FocusLost * call s:focus_lost_buffer()
  augroup END

  function! s:gruvbox_colors()
    hi clear Folded
    hi Folded guifg=#504945 ctermfg=240 ctermbg=none cterm=none

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

    hi SignColumn ctermbg=black
  endfunction

  function! s:gruvbox_material_colors()
    " let l:palette = gruvbox_material#get_palette('medium', 'material', {'bg0': ['#262626', '235'], 'bg1': ['#2f2c29', '235']})
    let l:palette = gruvbox_material#get_palette('medium', 'material', {'bg1': ['#2f2c29', '235']})
    " let l:palette = gruvbox_material#get_palette('medium', 'material', {})

    call gruvbox_material#highlight('IncSearch', l:palette.none, l:palette.none, 'inverse')
    " call gruvbox_material#highlight('IncSearch', l:palette.bg_yellow, l:palette.none, 'inverse')
    " call gruvbox_material#highlight('Search', l:palette.none, l:palette.bg2)
    call gruvbox_material#highlight('Search', l:palette.none, l:palette.bg3)

    call gruvbox_material#highlight('Comment', l:palette.bg5, l:palette.none, 'italic')

    call gruvbox_material#highlight('String', l:palette.fg0, l:palette.bg1, 'bold')

    call gruvbox_material#highlight('Todo', l:palette.grey1, l:palette.none, 'bolditalic')

    call gruvbox_material#highlight('ErrorText', l:palette.none, l:palette.none, 'undercurl', l:palette.red)
    call gruvbox_material#highlight('WarningText', l:palette.none, l:palette.none, 'undercurl', l:palette.yellow)
    call gruvbox_material#highlight('InfoText', l:palette.none, l:palette.none, 'undercurl', l:palette.blue)
    call gruvbox_material#highlight('HintText', l:palette.none, l:palette.none, 'undercurl', l:palette.aqua)

    " call gruvbox_material#highlight('LspDiagLine', l:palette.none, l:palette.none, 'undercurl', l:palette.fg1)
    call gruvbox_material#highlight('LspDiagInlineError', l:palette.none, l:palette.none, 'undercurl', l:palette.red)
    call gruvbox_material#highlight('LspDiagInlineHint', l:palette.none, l:palette.none, 'undercurl', l:palette.aqua)
    call gruvbox_material#highlight('LspDiagInlineInfo', l:palette.none, l:palette.none, 'undercurl', l:palette.blue)
    call gruvbox_material#highlight('LspDiagInlineWarning', l:palette.none, l:palette.none, 'undercurl', l:palette.yellow)

    call gruvbox_material#highlight('LspDiagSignErrorText', l:palette.red, l:palette.none, 'bold')
    call gruvbox_material#highlight('LspDiagSignHintText', l:palette.aqua, l:palette.none, 'bold')
    call gruvbox_material#highlight('LspDiagSignInfoText', l:palette.blue, l:palette.none, 'bold')
    call gruvbox_material#highlight('LspDiagSignWarningText', l:palette.yellow, l:palette.none, 'bold')


    " call gruvbox_material#highlight('ALEErrorSign', l:palette.none, l:palette.none, 'undercurl', l:palette.red)
    " call gruvbox_material#highlight('ALEWarningSign', l:palette.none, l:palette.none, 'undercurl', l:palette.yellow)
    " call gruvbox_material#highlight('ALEInfoSign', l:palette.none, l:palette.none, 'undercurl', l:palette.blue)
    " call gruvbox_material#highlight('ALEVirtualTextError', l:palette.none, l:palette.none, 'undercurl', l:palette.red)
    " call gruvbox_material#highlight('ALEVirtualTextWarning', l:palette.none, l:palette.none, 'undercurl', l:palette.yellow)

    call gruvbox_material#highlight('Folded', l:palette.bg3, l:palette.none)
    " call gruvbox_material#highlight('FoldColumn', l:palette.bg2, l:palette.none)
    " call gruvbox_material#highlight('FoldColumn', l:palette.grey1, l:palette.none)

    " call gruvbox_material#highlight('CursorLine', l:palette.none, ['#2a2a2a',   '235'])
    " call gruvbox_material#highlight('CursorLineNR', l:palette.grey1, ['#2a2a2a',   '235'])
    " call gruvbox_material#highlight('CursorLine', l:palette.none, l:palette.bg1)
    " call gruvbox_material#highlight('CursorLineNR', l:palette.grey1, l:palette.bg1)
    call gruvbox_material#highlight('LineNR', l:palette.bg5, l:palette.none)
    call gruvbox_material#highlight('CursorLine', l:palette.none, l:palette.none)
    call gruvbox_material#highlight('CursorLineNR', l:palette.fg1, l:palette.none)
    " call gruvbox_material#highlight('StatusLine', l:palette.bg2, l:palette.none)
    " call gruvbox_material#highlight('StatusLineNC', l:palette.bg2, l:palette.none)

    " call gruvbox_material#highlight('MatchParen', l:palette.red, l:palette.none, 'bold')
    call gruvbox_material#highlight('MatchParen', l:palette.none, l:palette.none, 'bold')
    " call gruvbox_material#highlight('MatchParen', l:palette.none, l:palette.bg1, 'bold')

    call gruvbox_material#highlight('NonText', l:palette.bg2, l:palette.none)
    " call gruvbox_material#highlight('SpecialKey', l:palette.bg2, l:palette.none)

    " call gruvbox_material#highlight('LeadingSpace', l:palette.none, l:palette.bg1)
    " match LeadingSpace /^\s\+/

    " call gruvbox_material#highlight('TrailingSpace', l:palette.none, l:palette.bg1)
    " match TrailingSpace / \+$/

    " call gruvbox_material#highlight('HighlightedyankRegion', l:palette.none, l:palette.bg3)
    " highlight HighlightedyankRegion cterm=reverse gui=reverse
  endfunction

  " function! s:gitgutter_colors()
    " if $TERM_PROGRAM !=# 'Apple_Terminal'
      " hi clear SignColumn
      " hi GitGutterAdd ctermfg=142 ctermbg=none
      " hi GitGutterChange ctermfg=109 ctermbg=none
      " hi GitGutterDelete ctermfg=167 ctermbg=none
      " hi GitGutterChangeDelete ctermfg=175 ctermbg=none
    " endif
  " endfunction

  augroup setup_colors | au!
    " gruvbox
    " let g:gruvbox_improved_strings = 1  " (0), 1
    " let g:gruvbox_improved_warnings = 1  " (0), 1
    " let g:gruvbox_hls_cursor = 'orange'
    " let g:gruvbox_contrast_dark = 'medium'  " soft, (medium), hard
    " let g:gruvbox_contrast_light = 'hard'  " soft, (medium), hard
    " au ColorScheme gruvbox call s:gruvbox_colors()

    " gruvbox-material
    let g:gruvbox_material_background = 'medium'  " soft, (medium), hard
    let g:gruvbox_material_foreground = 'material'  " (material), mix, original
    let g:gruvbox_material_transparent_background = 1
    let g:gruvbox_material_enable_bold = 1  " (0), 1
    let g:gruvbox_material_enable_italic = 0  " (0), 1
    let g:gruvbox_material_disable_italic_comment = 0  " (0), 1
    let g:gruvbox_material_visual = 'grey background'  " (grey background), red background, green background, blue background, reverse
    " let g:gruvbox_material_menu_selection_background = 'green'  " (grey), red, orange, yellow, green, aqua, blue, purple
    let g:gruvbox_material_spell_foreground = 'none'  " (none), colored
    let g:gruvbox_material_ui_contrast = 'low'  " (low), high
    let g:gruvbox_material_float_style = 'bright'  " (bright), dim
    let g:gruvbox_material_diagnostic_text_highlight = 0  " (0), 1
    let g:gruvbox_material_diagnostic_line_highlight = 0  " (0), 1
    let g:gruvbox_material_diagnostic_virtual_text = 'colored'  " (grey), colored, highlighted
    let g:gruvbox_material_better_performance = 1  " (0), 1
    au ColorScheme gruvbox-material call s:gruvbox_material_colors()
  augroup END

  packadd! gruvbox-material
  colorscheme gruvbox-material


" PACKAGES
  " let delimitMate_autoclose = 1
  let delimitMate_expand_inside_quotes = 1
  let delimitMate_expand_space = 1
  let delimitMate_expand_cr = 2
  " au FileType tex,typst inoremap $ <c-r>=QuoteDelim('$')<cr>
  " au FileType tex,typst inoremap <c-g>m <c-r>=QuoteDelim('$')<cr>
  " au FileType tex inoremap <c-\> <c-r>=QuoteDelim('$')<cr>
  " let delimitMate_matchpairs = "(:),{:},[:],<:>"
  " au FileType tex,typst let b:delimitMate_matchpairs = "(:),{:},[:],<:>"
  " let delimitMate_quotes = "\" ' `"
  au FileType typst let b:delimitMate_quotes = "\" ' ` $"
  au FileType tex let b:delimitMate_quotes = "$"
  " au FileType * set sts=0

  let g:fanfingtastic_all_inclusive = 1
  let g:fanfingtastic_fix_t = 1
  let g:fanfingtastic_ignorecase = 1

  let g:vimlsp_is_loaded = 0
  let g:highlightedyank_is_loaded = 0
  let g:autocomplpop_is_loaded = 0
  let g:matchup_is_loaded = 0
  let g:foldsearch_is_loaded = 0
  let g:lightline_is_loaded = 0
  let g:tmuxline_is_loaded = 0
  let g:nrrwrgn_is_loaded = 0
  let g:tabular_is_loaded = 0
  let g:polyglot_is_loaded = 0
  let g:juliavim_is_loaded = 0
  let g:rainbow_is_loaded = 0
  let g:gitgutter_is_loaded = 0
  let g:vimcommentary_is_loaded = 1
  let g:nerdcommenter_is_loaded = 0
  let g:vimtex_is_loaded = 0

  " MARKS IN SIGN GUTTER
  " packadd! vim-signature

  " SEARCH HIGHLIGHT AUTOTOGGLING
  packadd! vim-cool
    set hlsearch
    " let g:cool_total_matches = 1

  " HIGHLIGHT YANK SELECTION AUTOMATICALLY
  let g:highlightedyank_is_loaded=1
  packadd vim-highlightedyank
    let g:highlightedyank_highlight_duration = 128
    let g:highlightedyank_highlight_in_visual = 0

  " inoremap <expr> <cr> pumvisible() ? "\<c-g>u\<cr>" : "\<cr>"


  " let g:matchup_is_loaded = 1
  " packadd vim-matchup
  " augroup matchup_settings | au!
    " " let g:matchup_matchparen_offscreen = {'method': 'popup'}
    " let g:matchup_matchparen_offscreen = {}
    " let g:matchup_matchparen_stopline = 50

    " " au FileType python let g:matchup_matchparen_deferred = 1
    " " au FileType python let g:matchup_matchparen_deferred_show_delay = 0
    " " au FileType python let g:matchup_matchparen_deferred_hide_delay = 0
    " " au FileType python let g:matchup_matchparen_hi_surround_always = 1

    " let g:matchup_matchparen_deferred = 1
    " let g:matchup_matchparen_deferred_show_delay = 0
    " let g:matchup_matchparen_deferred_hide_delay = 0
    " let g:matchup_matchparen_hi_surround_always = 1
    " let g:matchup_matchparen_timeout = 50
    " let g:matchup_matchparen_insert_timeout = 100

    " let g:palette = gruvbox_material#get_palette('medium', 'material', {})
    " au ColorScheme * hi MatchParenCur gui=bold cterm=bold
    " au ColorScheme * hi MatchWordCur gui=bold cterm=bold
    " au ColorScheme * hi MatchWord gui=bold cterm=bold
  " augroup END

  " let g:foldsearch_is_loaded = 1
  " packadd vim-foldsearch

  let g:lightline_is_loaded = 1
  packadd lightline.vim
    set noshowmode
    function! LightlineFilenameAndMod()
      let l:filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
      let l:modified = &modified ? ' +' : ''
      return l:filename . modified
    endfunction
    function! CapsLockStatus()
      let l:capstatus = exists('*CapsLockStatusline')?CapsLockStatusline():''
      return l:capstatus
    endfunction

    let g:lightline = {
          \ 'colorscheme': 'gruvbox_material',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ],
          \             [ 'caps', 'filename' ],
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

  nnoremap <silent> <c-g>c <plug>CapsLockToggle

  let g:tmuxline_is_loaded = 1
  packadd tmuxline.vim
  if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
    let g:vim_is_in_tmux = 1
    " let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
    " let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
  else
    let g:vim_is_in_tmux = 0
  endif

  if g:vim_is_in_tmux == 1 && !has('win32')
    " let g:tmuxline_powerline_separators = 0
    let g:tmuxline_status_justify = 'left'
    let g:tmuxline_theme = 'lightline'
    let g:tmuxline_preset = {
          \'a'    : '#S',
          \'b'    : '#P',
          \'win'  : '#W',
          \'cwin' : '#W',
          \'x'    : '%a',
          \'y'    : '%h %d',
          \'z'    : '%R'
          \}
    " let g:tmuxline_preset = {
          " \'a'    : '#S',
          " \'b'    : '#{b:pane_current_path}',
          " \'win'  : '#W',
          " \'cwin' : '#W',
          " \'x'    : '%a',
          " \'y'    : '%h %d',
          " \'z'    : '%R'
          " \}
    " let g:tmuxline_preset = {
          " \'a'    : '#S',
          " \'b'    : '#{d:pane_current_path}',
          " \'c'    : '#{b:pane_current_path}',
          " \'win'  : '#W',
          " \'cwin' : '#W',
          " \'x'    : '%a',
          " \'y'    : '%h %d',
          " \'z'    : '%R'
          " \}
    " let g:tmuxline_separators = {
          " \ 'left' : '',
          " \ 'left_alt': '',
          " \ 'right' : '',
          " \ 'right_alt' : '',
          " \ 'space' : ' '}
    let g:tmuxline_separators = {
          \ 'left' : '',
          \ 'left_alt': '',
          \ 'right' : '',
          \ 'right_alt' : '',
          \ 'space' : ' '}
    " let g:tmuxline_theme = {
          " \   'a'    : [ 236, 103 ],
          " \   'b'    : [ 253, 239 ],
          " \   'c'    : [ 244, 236 ],
          " \   'x'    : [ 244, 236 ],
          " \   'y'    : [ 253, 239 ],
          " \   'z'    : [ 236, 103 ],
          " \   'win'  : [ 103, 236 ],
          " \   'cwin' : [ 236, 103 ],
          " \   'bg'   : [ 244, 236 ],
          " \ }
  endif

  let g:nrrwrgn_is_loaded = 1
  packadd NrrwRgn
    vunmap <leader>nr
    " vmap gbe :NR<cr>
    " vmap gbc :NR<cr>
    " vmap gbs :NR<cr>
    vnoremap <c-w>e :NR<cr>

  let g:tabular_is_loaded = 1
  packadd tabular  " tabularize
    " nnoremap <leader><tab> <cmd>Tabularize /
    nnoremap <leader><tab> <cmd>Tabularize /
    vnoremap <leader><tab> <cmd>Tabularize /
    " vnoremap <tab> <cmd>Tabularize /
    " vnoremap <tab><space> <cmd>Tabularize /\zs<left><left><left>
    vnoremap <leader><tab>= <cmd>Tabularize /=<cr>
    vnoremap <leader><tab>( <cmd>Tabularize /(<cr>
    vnoremap <leader><tab>[ <cmd>Tabularize /[<cr>
    vnoremap <leader><tab>{ <cmd>Tabularize /{<cr>
    vnoremap <leader><tab>< <cmd>Tabularize /<<cr>
    vnoremap <leader><tab>: <cmd>Tabularize /:<cr>
    vnoremap <leader><tab>; <cmd>Tabularize /;<cr>
    vnoremap <leader><tab>, <cmd>Tabularize /,<cr>
    vnoremap <leader><tab>\| <cmd>Tabularize /\|<cr>
    " vnoremap <tab>\ <cmd>Tabularize /\zs<left><left><left>

  " let g:polyglot_is_loaded = 1
  " let g:polyglot_disabled = ['ftdetect', 'sensible']
  " packadd vim-polyglot
  " let g:polyglot_disabled = ['ftdetect', 'sensible']

  let g:juliavim_is_loaded = 1
  packadd julia-vim

  let g:rainbow_is_loaded = 1
  let g:rainbow_active = 1
  let g:rainbow_conf = {
    \ 'guifgs': ['#ea6962', '#e78a4e', '#d8a657', '#a9b665', '#89b482', '#7daea3', '#d3869b'],
    \ 'ctermfgs': ['167', '208', '214', '142', '108', '109', '175'],
  \ }
    " \ 'guifgs': ['#89b482', '#d8a657', '#e78a4e', '#7daea3', '#a9b665', '#ea6962'],
    " \ 'guifgs': ['#7daea3', '#89b482', '#a9b665', '#d8a657', '#e78a4e', '#ea6962', '#d3869b'],
    " \ 'guifgs': ['#ea6962', '#e78a4e', '#d8a657', '#a9b665', '#89b482', '#7daea3', '#d3869b'],
  packadd rainbow

  " let g:gitgutter_is_loaded = 1
  " packadd vim-gitgutter
  " augroup gitgutter_settings | au!
    " let g:gitgutter_map_keys = 1
    " let g:gitgutter_sign_added = '⋅ '
    " let g:gitgutter_sign_modified = '⋅ '
    " let g:gitgutter_sign_removed = '⋅ '
    " " let g:gitgutter_sign_removed_first_line = '  '
    " " let g:gitgutter_sign_removed_above_and_below = '  '
    " let g:gitgutter_sign_modified_removed = '⋅ '
    " call gitgutter#highlight#define_signs()

    if g:gitgutter_is_loaded
      au ColorScheme gruvbox call s:gitgutter_colors()
      " nmap ]g <Plug>(GitGutterNextHunk)
      " nmap [g <Plug>(GitGutterPrevHunk)
      " omap ig <Plug>(GitGutterTextObjectInnerPending)
      " omap ag <Plug>(GitGutterTextObjectOuterPending)
      " xmap ig <Plug>(GitGutterTextObjectInnerVisual)
      " xmap ag <Plug>(GitGutterTextObjectOuterVisual)
      " nmap <leader>gf <cmd>GitGutterFold<cr>
      " nmap <leader>fg <cmd>GitGutterFold<cr>
    endif

    " function! GitStatus()
      " let [a,m,r] = GitGutterGetHunkSummary()
      " return printf('+%d ~%d -%d', a, m, r)
    " endfunction
    " set statusline+=%{GitStatus()}
  augroup END

  if vimcommentary_is_loaded
    packadd vim-commentary
    " nnoremap <silent> gC o.<esc><plug>Commentary kJi<space><esc>$s
    nnoremap <silent> gcs i<enter>.<esc><plug>Commentary kJi<space><esc>

    nnoremap <silent> gce i<enter>.<esc><plug>Commentary kJi<space><left>

    " append comment to end of line with space
    nnoremap <silent> gcA o.<esc><plug>Commentary kJi<space><esc>$s

    " append comment to end of line without space
    nnoremap <silent> gcL o.<esc><plug>Commentary kJx$xx

    nnoremap <silent> gcO O.<esc><plug>Commentary $s
    nnoremap <silent> gco o.<esc><plug>Commentary $s

  endif

  if nerdcommenter_is_loaded
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
      au! BufEnter * call s:nerdcommenter_mappings()

      " function! s:nerdcommenter_mappings()
      " for key in ['c', 'a', 'n', 'm', 'y', '$', 'a', 'a', 'l', 'b', 'u' "<space>"]
      " exe "unmap \<leader\>c" . key
      " endfor
      " endfunction
      function! s:nerdcommenter_mappings()
        " for mov in ['j', 'k', 'gg', 'G', '(', ')', '{', '}', 'is', 'ip', 'if', 'af']
        " exe "nnoremap gc" . mov . " V" . mov . "\<Plug\>NERDCommenterInvert `<"
        " endfor

        " for i in range(1, 50)
        " exe 'nnoremap gc' . i . 'j V' . i . 'j\<plug\>NERDCommenterInvert'
        " exe 'nnoremap gc' . i . 'k V' . i . 'k\<plug\>NERDCommenterInvert'
        " endfor

        " noremap gci <plug>NERDCommenterInvert
        " nnoremap gcx <plug>NERDCommenterComment
        " vnoremap gcx <plug>NERDCommenterComment
        " noremap gcd <plug>NERDCommenterUncomment
        " nnoremap gca <plug>NERDCommenterAppend<left><left><left><space><right><right><right>
        " nnoremap gcl A<c-g>U<c-o><plug>NERDCommenterAppend<bs><left><bs><right><esc>
        " nnoremap gco o<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$
        " nnoremap gcO O<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$

        nnoremap c/ <plug>NERDCommenterComment
        nnoremap c\ <plug>NERDCommenterInvert
        nnoremap cd <plug>NERDCommenterUncomment
        nnoremap dc <plug>NERDCommenterUncomment

        vnoremap c/ <plug>NERDCommenterComment
        vnoremap c\ <plug>NERDCommenterInvert
        vnoremap cd <plug>NERDCommenterUncomment

        nnoremap cA <plug>NERDCommenterAppend<left><left><left><space><right><right><right>
        nnoremap cL A<c-g>U<c-o><plug>NERDCommenterAppend<bs><left><bs><right><esc>
        nnoremap co o<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$
        nnoremap cO O<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$

        " noremap gc/ <plug>NERDCommenterComment
        " noremap gcd <plug>NERDCommenterUncomment
        " noremap gcx <plug>NERDCommenterUncomment
        " " noremap cd <plug>NERDCommenterUncomment
        " " " noremap dc <plug>NERDCommenterUncomment
        " " " noremap gci <plug>NERDCommenterComment
        " " " noremap gcu <plug>NERDCommenterUncomment

        " noremap gci <plug>NERDCommenterInvert
        " " noremap gct <plug>NERDCommenterInvert
        " " noremap gcc <plug>NERDCommenterInvert
        " noremap gct <plug>NERDCommenterToggle

        " " noremap gci <plug>NERDCommenterToEOL a
        " " noremap gcI <plug>NERDCommenterComment ^a<space>
        " " noremap gck <plug>NERDCommenterToEOL
        " " noremap gcK <plug>NERDCommenterComment ^

        " nnoremap gca <plug>NERDCommenterAppend<left><left><left><space><right><right><right>
        " " nnoremap cA <plug>NERDCommenterAppend
        " " nnoremap cA <plug>NERDCommenterAppend
        " " nnoremap gca A<c-g>U<space><c-o><plug>NERDCommenterAppend
        " " nnoremap gcA <plug>NERDCommenterAppend

        " nnoremap gcl A<c-g>U<c-o><plug>NERDCommenterAppend<bs><left><bs><right><esc>
        " " nnoremap gcl A<c-g>U<c-o><plug>NERDCommenterAppend<bs><left><bs><right><esc>
        " " nnoremap gcH <plug>NERDCommenterToEOL
        " " nnoremap gcJ <plug>NERDCommenterToEOL
        " " nnoremap gcK <plug>NERDCommenterToEOL
        " " nnoremap gcL <plug>NERDCommenterToEOL

        " nnoremap gco o<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$
        " nnoremap gcO O<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$
        " " nnoremap gco o<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$
        " " nnoremap gcO O<space><bs><esc><plug>NERDCommenterAppend<c-o><<<c-o>$
      endfunction
    augroup END
  endif

  " packadd asyncomplete.vim
  " packadd vim-lsp
  " if executable('pylsp')
      " " pip install python-lsp-server
      " au User lsp_setup call lsp#register_server({
          " \ 'name': 'pylsp',
          " \ 'cmd': {server_info->['pylsp']},
          " \ 'allowlist': ['python'],
          " \ })
  " endif

  packadd lsp
  let g:vimlsp_is_loaded = 0
  if g:vimlsp_is_loaded
    " brew install python-lsp-server, pip install python-lsp-server
    if executable('pylsp')
      call LspAddServer([#{name: 'pylsp',
                        \  filetype: 'python',
                        \  path: '/opt/homebrew/bin/pylsp',
                        \  args: []}])
    endif
    " if executable('lua-language-server')
      " call LspAddServer([#{name: 'lua-language-server',
                        " \  filetype: 'lua',
                        " \  path: '/opt/homebrew/bin/lua-language-server',
                        " \  args: [],
                        " \  workspaceConfig: #{
                        " \    Lua: #{
                        " \      hint: #{
                        " \        enable: v:true,
                        " \      }
                        " \    }
                        " \  }}])
    " endif
    " if executable('emmylua_ls')
      " call LspAddServer([#{name: 'emmylua_ls',
                        " \  filetype: 'lua',
                        " \  path: '/Users/cedre/.cargo/bin/emmylua_ls',
                        " \  args: []}])
    " endif
    " if executable('clangd')
      " call LspAddServer([#{name: 'clangd',
                        " \  filetype: ['c', 'cpp', 'objc'],
                        " \  path: '/usr/bin/clangd',
                        " \  args: ['-j=8',
                        " \         '--background-index',
                        " \         '--background-index-priority=normal',
                        " \         '--pch-storage=memory',
                        " \         '--header-insertion=never',
                        " \         '--limit-references=64',
                        " \         '--limit-results=16',
                        " \         '--enable-config']}])
    " endif
    " if executable('ccls')
      " call LspAddServer([#{name: 'ccls',
                        " \  filetype: ['c', 'cpp', 'objc'],
                        " \  path: '/opt/homebrew/bin/ccls',
                        " \  args: ['']}])
    " endif
    " if executable('pyright')
      " call LspAddServer([#{name: 'pyright',
                        " \  filetype: 'python',
                        " \  path: '/opt/homebrew/bin/pyright-langserver',
                        " \  args: ['--stdio'],
                        " \  workspaceConfig: #{
                        " \    python: #{
                        " \      pythonPath: '/Users/cedre/repos/explainable_graphs/.venv/bin/python3'
                        " \  }}
                        " \ }])
    " endif
    " call LspAddServer([#{name: 'ruff',
                      " \   filetype: 'python',
                      " \   path: '/opt/homebrew/bin/ruff',
                      " \   args: [server]
                      " \ }])
    " brew install texlab
    if executable('texlab')
      call LspAddServer([#{name: 'texlab',
                        \  filetype: 'tex',
                        \  path: '/opt/homebrew/bin/texlab',
                        \  args: []}])
    endif
    call LspOptionsSet(#{aleSupport: v:false,
                       \ autoComplete: v:true,
                       \ autoHighlight: v:false,
                       \ autoHighlightDiags: v:true,
                       \ autoPopulateDiags: v:false,
                       \ completionMatcher: 'icase',
                       \ completionMatcherValue: 1,
                       \ diagSignErrorText: '!>',
                       \ diagSignHintText: '->',
                       \ diagSignInfoText: '=>',
                       \ diagSignWarningText: '?>',
                       \ echoSignature: v:false,
                       \ hideDisabledCodeActions: v:false,
                       \ highlightDiagInline: v:true,
                       \ hoverInPreview: v:false,
                       \ ignoreMissingServer: v:false,
                       \ keepFocusInDiags: v:true,
                       \ keepFocusInReferences: v:true,
                       \ completionTextEdit: v:true,
                       \ diagVirtualTextAlign: 'after',
                       \ diagVirtualTextWrap: 'truncate',
                       \ noNewlineInCompletion: v:true,
                       \ omniComplete: v:null,
                       \ outlineOnRight: v:true,
                       \ outlineWinSize: 32,
                       \ semanticHighlight: v:true,
                       \ showDiagInBalloon: v:false,
                       \ showDiagInPopup: v:true,
                       \ showDiagOnStatusLine: v:true,
                       \ showDiagWithSign: v:true,
                       \ showDiagWithVirtualText: v:false,
                       \ showInlayHints: v:false,
                       \ showSignature: v:false,
                       \ snippetSupport: v:false,
                       \ ultisnipsSupport: v:false,
                       \ useBufferCompletion: v:false,
                       \ usePopupInCodeAction: v:false,
                       \ useQuickfixForLocations: v:false,
                       \ vsnipSupport: v:false,
                       \ bufferCompletionTimeout: 20,
                       \ customCompletionKinds: v:false,
                       \ completionKinds: {},
                       \ filterCompletionDuplicates: v:false})
    augroup lsp_settings | au!
      au VimEnter * set keywordprg=:LspHover

      au VimEnter * noremap ]e <cmd>LspDiag nextWrap<cr>
      au VimEnter * noremap [e <cmd>LspDiag prevWrap<cr>

      au VimEnter * nnoremap [d <cmd>botright LspGotoDefinition<cr>
      au VimEnter * nnoremap ]d <cmd>LspGotoDefinition<cr>
      au VimEnter * nnoremap ]D <cmd>LspGotoDeclaration<cr>
      au VimEnter * nnoremap ]i <cmd>LspGotoImpl<cr>
      au VimEnter * nnoremap ]t <cmd>LspGotoTypeDef<cr>

      au VimEnter * nnoremap gd <cmd>LspPeekDefinition<cr>
      au VimEnter * nnoremap gD <cmd>LspPeekDeclaration<cr>
      " au VimEnter * nnoremap gi <cmd>LspPeekImpl<cr>
      au VimEnter * nnoremap gt <cmd>LspPeekTypeDef<cr>

      au VimEnter * nnoremap gm <cmd>LspDiag current<cr>

      au VimEnter * nnoremap gh <cmd>LspDiag highlight toggle<cr>

      au VimEnter * nnoremap gs <cmd>LspShowSignature<cr>
      " au VimEnter * nnoremap gS <cmd>LspHighlightClear<cr>

      " function! s:CheckSig(timer)
        " if g:lsp_trigger_flag
          " let g:lsp_trigger_flag = 0
          " call g:LspShowSignature()
        " endif
      " endfunction

      " let g:lsp_trigger_flag = 0

      " autocmd InsertCharPre call g:LspShowSignature()
      " " autocmd InsertCharPre * if v:char ==# '(' | let g:lsp_trigger_flag = 1 | call timer_start(10, function('s:CheckSig')) | endif
      " " autocmd InsertCharPre * if v:char ==# '{' | let g:lsp_trigger_flag = 1 | call timer_start(10, function('s:CheckSig')) | endif
      " autocmd InsertEnter * call g:LspShowSignature()
    augroup END
  endif

" SET OPTIONS
  " FILETYPE SPECIFIC
    augroup config_settings | au!
      au BufNewFile,BufRead .yabairc,yabairc,.skhdrc set filetype=sh
      au BufNewFile,BufRead .tmux.conf,.tmux.statusline set filetype=tmux
      au BufNewFile,BufRead .ghosttyrc set filetype=toml
    augroup END

    augroup shell_settings | au!
      au BufNewFile,BufRead *.sh set filetype=bash
      " au BufNewFile,BufRead,BufReadPost *.sh setlocal nospell
    augroup END

    augroup python_settings | au!
      " au BufNewFile,BufRead,BufReadPost *.py setlocal nospell
      " au FileType python setlocal nospell
      au FileType python setlocal foldmethod=indent
      " au FileType python setlocal shiftwidth=2
      " au FileType python setlocal softtabstop=2
      " au FileType python setlocal tabstop=8
    augroup END

    augroup vim_settings | au!
      au FileType vim inoremap < <><c-g>U<left>
    augroup END

    augroup markdown_settings | au!
      " au FileType markdown setlocal shiftwidth=2
      " au FileType markdown setlocal softtabstop=2
      " au FileType markdown setlocal tabstop=8
    augroup END

    augroup text_settings | au!
      au BufNewFile,BufRead *.dat set filetype=csv
    augroup END

    augroup html_settings | au!
      au BufNewFile,BufRead *.svg set filetype=html
      au FileType html inoremap < <><c-g>U<left>
    augroup END

    augroup latex_settings | au!
      let g:tex_comment_nospell=1

      " let g:vimtex_compiler_enabled = 0
      " let g:vimtex_complete_enabled = 0
      " let g:vimtex_fold_enabled = 1
      " let g:vimtex_imaps_enabled = 0
      " let g:vimtex_mappings_enabled = 0
      " let g:vimtex_quickfix_enabled = 0
      " let g:vimtex_syntax_nospell_comments = 1
      " let g:vimtex_view_enabled = 0

      au BufNewFile,BufRead *.bib,*.tex,*.tikz set filetype=tex
      au BufNewFile,BufRead *.bib,*.tex,*.tikz set syntax=tex

      " au BufNewFile,BufRead *.bib,*.tex,*.tikz packadd! vimtex
      " packadd vimtex
      " let g:vimtex_is_loaded = 1

      " au FileType tex packadd vimtex

      au FileType tex imap ` <nop>
      au FileType tex iunmap `
    augroup END

  " GENERAL
    augroup set_settings | au!
      au BufNewFile,BufRead,BufEnter * set formatoptions=tjcrqn
    augroup END
    " augroup set_settings | au!
    "   au BufNewFile,BufRead * set formatoptions=tjcrqn
    "   " au BufNewFile,BufRead * set formatoptions-=c
    "   " au BufNewFile,BufRead * set formatoptions-=o
    "   " au BufNewFile,BufRead * set formatoptions+=r
    "   " au BufNewFile,BufRead * set formatoptions+=j
    " augroup END
    set background=dark
    set backspace=indent,eol,start
    set cursorline
    set display+=lastline
    " set formatoptions-=c
    " set formatoptions-=o
    " set formatoptions+=r
    " set formatoptions+=j
    set ignorecase
    set incsearch
    set nojoinspaces
    set laststatus=2
    set matchpairs+=<:>
    set mouse=""
    set number
    set numberwidth=3
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
    " set wildmode=list:longest,full
    " set number relativenumber
    " set scrolloff=2

  " POP-UP WINDOW

  " FOLDING
    set foldopen-=search
    set foldopen+=undo
    set foldcolumn=0
    " set foldignore=
    set foldlevelstart=99
    set foldmethod=indent
    " set foldmethod=manual

    " set fillchars+=foldsep:│,foldclose:╶
    " set fillchars+=foldopen:├,foldsep:│,foldclose:╶
    " set fillchars+=foldopen:┣,foldsep:┃,foldclose:╺
    " set fillchars+=foldopen:┏,foldsep:┃,foldclose:╺
    " set fillchars+=foldopen:▾,foldsep:│,foldclose:▸
    " set fillchars+=foldopen:▿,foldsep:│,foldclose:▷
    set fillchars+=fold:\ 
    " set foldtext=
    set foldtext=MyFoldText()

    function MyFoldText()
      let line = getline(v:foldstart)
      let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
      " let sub = substitute(sub, ' ', '+', '')
      return sub
    endfunction

  " INDENTATION
    au FileType * set autoindent
    au FileType * set expandtab
    au FileType * set shiftwidth=2
    au FileType * set softtabstop=2
    au FileType * set tabstop=8

  " LINES & WRAPPING
    set breakindent
    set breakindentopt=sbr
    set linebreak
    " let &showbreak='>'
    set sidescroll=10
    set textwidth=0
    " set list
    " set listchars=nbsp:_,eol:⋅
    " " set listchars=multispace:_,nbsp:_,eol:$


" PLUGIN SETTINGS
  let g:haskell_indent_if = 2
  let g:haskell_indent_case = 4
  let g:haskell_indent_guard = 5
  let g:incsearch#auto_nohlsearch = 1
  let g:latex_to_unicode_file_types = '.*'
  let g:python_highlight_all = 1
  let g:matchparen_timeout = 8
  let g:matchparen_insert_timeout = 8
  let g:tex_flavor = 'latex'
  let g:unicoder_cancel_normal = 1
  " let g:unicoder_cancel_insert = 1
  let g:unicoder_cancel_visual = 1


" TOGGLE MAPPINGS
  nnoremap <leader>tw <cmd>setlocal nowrap!<cr>
  nnoremap <leader>ts <cmd>setlocal spell!<cr>
  nnoremap <leader>tq <cmd>call ToggleQuote()<cr>
  nnoremap <leader>t' <cmd>call ToggleQuote()<cr>
  nnoremap <leader>t" <cmd>call ToggleQuote()<cr>
  nnoremap <leader>tg <cmd>call ToggleGMove()<cr>
  nnoremap <leader>ta <cmd>call ToggleAMove()<cr>
  nnoremap <leader>tfi <cmd>setlocal foldmethod=indent<cr>
  nnoremap <leader>tfm <cmd>setlocal foldmethod=manual<cr>
  " noremap <leader>h <cmd>noh<bar>:echo<cr>
  " nnoremap <leader>th <cmd>set nohlsearch!<cr>
  " nnoremap <leader>tb <cmd>call ToggleBackground()<cr>
  if g:rainbow_is_loaded
    nnoremap <leader>tr <cmd>RainbowToggle<cr>
  endif
  if g:gitgutter_is_loaded
    nnoremap <leader>tgit <cmd>GitGutterToggle<cr>
  endif

  " function! ToggleConcealLevel()
      " if &conceallevel == 0
          " setlocal conceallevel=1
      " else
          " setlocal conceallevel=0
      " endif
  " endfunction
  " nnoremap <silent> <leader>tc <cmd>call ToggleConcealLevel()<cr>

  " relative line numbers
  " nnoremap <leader>trln <cmd>set rnu!<cr>


" SEARCH MAPPINGS
  " augroup search_highlighting | au!
    " autocmd CmdlineEnter /,\? set hlsearch
    " autocmd CmdlineLeave /,\? set nohlsearch
    " autocmd InsertEnter * set nohlsearch
    " " autocmd InsertLeave * set nohlsearch
    " nnoremap <silent> gh <cmd>set hlsearch!<cr>
    " vnoremap <silent> gh <cmd>set hlsearch!<cr>
    " " cnoremap <expr> <cr> getcmdtype() == '/' ? '<cr>zz' : '<cr>'
  " augroup END
  " nnoremap <silent> gh <cmd>noh<cr>
  " vnoremap <silent> gh <cmd>noh<cr>
  nnoremap S :%s//gc<left><left><left>
  noremap ? //e<left><left>

  " vnoremap <leader>/ y/\V<c-r>=escape(@",'/\')<cr>
  vnoremap S y`<`>:<c-u>%s/\V<c-r>=escape(@",'/\')<cr>//gc<left><left><left>

  vnoremap * y/\V<c-r>=escape(@",'/\')<cr><cr>


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

    inoremap <c-]> <del>

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


" DELIMITER MAPPINGS
  augroup delimiter_mappings | au!
    au VimEnter * imap <silent> <c-g>a <
    au VimEnter * imap <silent> <c-g>b (
    au VimEnter * imap <silent> <c-g>B {
    au VimEnter * imap <silent> <c-g>r [
    au VimEnter * imap <silent> <c-g>g `
    au VimEnter * imap <silent> <c-g>h #
    au VimEnter * imap <silent> <c-g>d $
    au VimEnter * imap <silent> <c-g>x *
    au VimEnter * imap <silent> <c-g>u _
    " au VimEnter * inoremap <silent> ( ()<c-g>U<left>
    " au VimEnter * inoremap <silent> [ []<c-g>U<left>
    " au VimEnter * inoremap <silent> { {}<c-g>U<left>
    " au VimEnter * inoremap <silent> ) <c-g>U<c-r>=ClosePair(')')<cr>
    " au VimEnter * inoremap <silent> ] <c-g>U<c-r>=ClosePair(']')<cr>
    " au VimEnter * inoremap <silent> } <c-g>U<c-r>=ClosePair('}')<cr>
    " au VimEnter * inoremap <silent> > <c-g>U<c-r>=ClosePair('>')<cr>
    " au VimEnter * inoremap <silent> " <c-g>U<c-r>=QuoteDelim('"')<cr>
    " au VimEnter * " inoremap <silent> ' <c-g>U<c-r>=QuoteDelim("'")<cr>
    " au VimEnter * inoremap <silent> ` <c-g>U<c-r>=QuoteDelim('`')<cr>
    " au VimEnter * inoremap <silent> <c-g>q ``''<left><left>
    " au VimEnter * map <silent> ysiwd ysiw$
    au VimEnter * omap <silent> aa a<
    au VimEnter * xmap <silent> aa a<
    au VimEnter * omap <silent> ia i<
    au VimEnter * xmap <silent> ia i<
    au VimEnter * omap <silent> ad af$
    au VimEnter * xmap <silent> ad af$
    au VimEnter * omap <silent> id if$
    au VimEnter * xmap <silent> id if$
    au VimEnter * onoremap <silent> a` 2i`
    au VimEnter * onoremap <silent> a' 2i'
    au VimEnter * onoremap <silent> a" 2i"
    au VimEnter * xnoremap <silent> a` 2i`
    au VimEnter * xnoremap <silent> a' 2i'
    au VimEnter * xnoremap <silent> a" 2i"
  augroup END

  " VIM-SURROUND DEPENDENT MAPPINGS
  nmap ds    <Plug>Dsurround
  nmap cs    <Plug>Csurround
  nmap ys    <Plug>Ysurround
  nmap yss   <Plug>Yssurround
  xmap <c-s> <Plug>Vsurround
  imap <c-s> <Plug>Isurround

  " <s-s>(
  " <s-s>)
  " vmap ( <s-s>(<cr>
  " vmap ) <s-s>)<cr>
  " vmap <leader>( <s-s>(<cr>
  " vmap <leader>) <s-s>)<cr>
  " vmap <leader>( <s-s>(<cr>
  " vmap <leader>) <s-s>)<cr>

  " <s-s>[
  " <s-s>]
  " vmap [ <s-s>[<cr>
  " vmap ] <s-s>]<cr>
  " vmap <leader>[ <s-s>[<cr>
  " vmap <leader>] <s-s>]<cr>

  " <s-s>{
  " <s-s>}
  " vmap { <s-s>{<cr>
  " vmap } <s-s>}<cr>
  " vmap <leader>{ <s-s>{<cr>
  " vmap <leader>} <s-s>}<cr>

  " <s-s><
  " <s-s>>
  " vmap <leader>a <s-s>><cr>
  " vmap <leader>< <s-s><<cr>
  " vmap <leader>> <s-s>><cr>

  " vmap <c-g>m <s-s>$<cr>
  " vmap <leader>m <s-s>$<cr>
  " vmap <leader>$ <s-s>$<cr>

  " vmap " <s-s>"<cr>
  " vmap ' <s-s>'<cr>
  " vmap ` <s-s>`<cr>

  " vmap <c-g>q <s-s><c-q><cr>
  " vmap <leader>" <s-s>"<cr>
  " vmap <leader>' <s-s>'<cr>
  " vmap <leader>` <s-s>`<cr>
  " vmap <leader>q <s-s><c-q><cr>
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

augroup jump_settings | au!
  au VimEnter * :clearjumps
augroup END
