" ┏┓ ╻  ┏━┓┏━┓╻ ╻┏━╸   ┏┳┓┏━┓┏━╸╻┏━╸╻┏ 
" ┣┻┓┃  ┣━┫┃┓┃┃ ┃┣╸    ┃┃┃┣━┫┃╺┓┃┃  ┣┻┓
" ┗━┛┗━╸╹ ╹┗┻┛┗━┛┗━╸   ╹ ╹╹ ╹┗━┛╹┗━╸╹ ╹
" blaque magick by xero harrison (http://blaquemagick.xero.nu)
" modified by 高明俊

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name="blaquemagick"

hi ColorColumn  term=NONE       cterm=NONE      ctermfg=NONE    ctermbg=242
hi Comment      term=NONE       cterm=NONE      ctermfg=232     ctermbg=NONE
hi Constant     term=NONE       cterm=NONE      ctermfg=101     ctermbg=233
hi Cursor       term=NONE       cterm=NONE      ctermfg=242     ctermbg=NONE
hi CursorLine   term=NONE       cterm=NONE      ctermfg=NONE    ctermbg=234
hi DiffAdd      term=NONE       cterm=NONE      ctermfg=103     ctermbg=NONE
hi DiffChange   term=NONE       cterm=NONE      ctermfg=NONE    ctermbg=16
hi DiffDelete   term=NONE       cterm=NONE      ctermfg=251     ctermbg=16
hi DiffText     term=NONE       cterm=NONE      ctermfg=251     ctermbg=101
hi Directory    term=NONE       cterm=NONE      ctermfg=101     ctermbg=16
hi Error        term=NONE       cterm=NONE      ctermfg=238     ctermbg=66
hi ErrorMsg     term=NONE       cterm=NONE      ctermfg=52      ctermbg=NONE
hi FoldColumn   term=NONE       cterm=NONE      ctermfg=238     ctermbg=NONE
hi Folded       term=NONE       cterm=NONE      ctermfg=238     ctermbg=NONE
hi Function     term=NONE       cterm=NONE      ctermfg=124     ctermbg=NONE
hi Identifier   term=NONE       cterm=NONE      ctermfg=66      ctermbg=NONE
hi IncSearch    term=NONE       cterm=NONE      ctermfg=247     ctermbg=247
hi MatchParen   term=NONE       cterm=NONE      ctermfg=0       ctermbg=66
hi NonText      term=NONE       cterm=NONE      ctermfg=101     ctermbg=NONE
hi Normal       term=NONE       cterm=NONE      ctermfg=238     ctermbg=NONE
hi PreProc      term=NONE       cterm=NONE      ctermfg=66      ctermbg=NONE
hi Search       term=NONE       cterm=NONE      ctermfg=251     ctermbg=247
hi Special      term=NONE       cterm=NONE      ctermfg=66      ctermbg=NONE
hi SpecialKey   term=NONE       cterm=NONE      ctermfg=101     ctermbg=NONE
hi SpellBad     term=NONE       cterm=REVERSE   ctermfg=52      ctermbg=16
hi SpellCap     term=NONE       cterm=REVERSE   ctermfg=23      ctermbg=16
hi Statement    term=NONE       cterm=NONE      ctermfg=250     ctermbg=NONE
hi StatusLine   term=NONE       cterm=NONE      ctermfg=66      ctermbg=233
hi StatusLineNC term=NONE       cterm=NONE      ctermfg=238     ctermbg=NONE
hi String       term=NONE       cterm=NONE      ctermfg=66      ctermbg=233
hi TabLineSel   term=NONE       cterm=NONE      ctermfg=251     ctermbg=NONE
hi Todo         term=NONE       cterm=NONE      ctermfg=251     ctermbg=66
hi Type         term=NONE       cterm=NONE      ctermfg=52      ctermbg=NONE
hi VertSplit    term=NONE       cterm=NONE      ctermfg=236     ctermbg=16
hi Visual       term=NONE       cterm=NONE      ctermfg=16      ctermbg=101
hi WarningMsg   term=NONE       cterm=NONE      ctermfg=52      ctermbg=NONE
hi LineNr       term=NONE       cterm=NONE      ctermfg=238     ctermbg=16
hi CursorLineNr term=NONE       cterm=NONE      ctermfg=16      ctermbg=237
hi Pmenu        term=NONE       cterm=NONE      ctermfg=249     ctermbg=16
hi PmenuSel     term=NONE       cterm=NONE      ctermfg=238     ctermbg=66
hi PmenuSbar    term=NONE       cterm=NONE      ctermfg=238     ctermbg=66
hi PmenuThumb   term=NONE       cterm=NONE      ctermfg=238     ctermbg=66
hi Underlined   term=UNDERLINE  cterm=UNDERLINE ctermfg=NONE    ctermbg=NONE

hi! link diffAdded       DiffAdd
hi! link diffRemoved     DiffDelete
hi! link diffChanged     DiffChange
hi! link Title           Normal
hi! link MoreMsg         Normal
hi! link Question        DiffChange
hi! link TabLine         StatusLineNC
hi! link TabLineFill     StatusLineNC
hi! link VimHiGroup      VimGroup
