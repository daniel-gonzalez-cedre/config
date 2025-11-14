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

  " echo @%
  echo ''
endfunction

augroup focus | au!
  " let g:focus_status = 0
  " au VimResized * call s:toggle_focus()
  au FocusGained * call s:focus_gained_buffer()
  au FocusLost * call s:focus_lost_buffer()
augroup END

function! s:gruvbox_settings()
  let g:gruvbox_improved_strings = 1  " (0), 1
  let g:gruvbox_improved_warnings = 1  " (0), 1
  let g:gruvbox_hls_cursor = 'orange'
  let g:gruvbox_contrast_dark = 'medium'  " soft, (medium), hard
  let g:gruvbox_contrast_light = 'hard'  " soft, (medium), hard
endfunction

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

function! s:gruvbox_material_settings()
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
  " let g:gruvbox_material_better_performance = 1  " (0), 1
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

  call gruvbox_material#highlight('LeadingSpace', l:palette.none, l:palette.red)
  " match LeadingSpace /^\s\+/

  " call gruvbox_material#highlight('TrailingSpace', l:palette.none, l:palette.bg1)
  " match TrailingSpace / \+$/

  " call gruvbox_material#highlight('HighlightedyankRegion', l:palette.none, l:palette.bg3)
  " highlight HighlightedyankRegion cterm=reverse gui=reverse

  " highlight ExtraWhitespace ctermbg=red guibg=red
  call gruvbox_material#highlight('ExtraWhitespace', l:palette.none, l:palette.bg2)
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
  " au ColorScheme gruvbox call s:gruvbox_settings()
  " au ColorScheme gruvbox call s:gruvbox_colors()

  au ColorScheme gruvbox-material call s:gruvbox_material_settings()
  au ColorScheme gruvbox-material call s:gruvbox_material_colors()
augroup END

packadd! gruvbox-material
colorscheme gruvbox-material
