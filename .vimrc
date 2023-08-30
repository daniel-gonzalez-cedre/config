filetype plugin indent on
silent
syntax enable
au FileType * set conceallevel=0
autocmd BufEnter * :syntax sync fromstart

if has('nvim')
    packadd! nvim-treesitter
else
    packadd! ale
    let g:ale_sign_error = ' ✘'
    let g:ale_sign_warning = ' ⋅'
    let g:ale_linters = {'vim': ['vint'], 'python': ['pylint'], 'lua': ['luacheck', 'luac'], 'tex': ['lacheck']}  " pyright, chktek, lachek
    let g:ale_lint_on_text_changed = 'normal'
    let g:ale_lint_on_insert_leave = 1
    let g:ale_lint_delay = 0
    let g:ale_lint_on_save = 1
    let g:ale_virtualtext_cursor = 'current'
    map ]a :ALENextWrap<cr>
    map [a :ALEPreviousWrap<cr>
    map <leader>an :ALENextWrap<cr>
    map <leader>aN :ALEPreviousWrap<cr>
    map <leader>al :ALELint<cr>
    map <leader>ad :ALEDetail<cr>
endif

packadd! vimtex

set background=dark
set backspace=indent,eol,start
" set completeopt+=popup
" set completepopup=height:15,width:60,border:off,highlight:PMenuSbar
set conceallevel=0
set cursorline
set display+=lastline
set fillchars=stl:⋅,stlnc:⋅,vert:│,fold:۰,diff:·
" set fillchars=stl:-,stlnc:⋅,vert:│,fold:\ ,diff:·
set formatoptions+=1jp
" set formatoptions-=t
set hlsearch
set ignorecase
set incsearch
set laststatus=2
let mapleader=','
set matchpairs+=<:>
set mouse=
set spell
" set nospell
" set number relativenumber
set number
set numberwidth=3
" set previewpopup=height:10,width:60,highlight:PMenuSbar
set ruler
" set scrolloff=2
set signcolumn=yes
set shiftround
set showcmd
set smartcase
set spelllang+=cjk
set spellsuggest=best,5
set splitbelow
set splitright
set notimeout nottimeout
" set timeout timeoutlen=3000 ttimeoutlen=10
set updatetime=200
set wildmenu
set wildmode=list:longest,full

" folding
set foldignore=
set foldlevelstart=99
set foldmethod=indent

" indentation
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" line wrapping
" set breakindent
" set breakindentopt=sbr
set linebreak
" set list
set listchars=tab:__,nbsp:⋅,eol:⋅
let &showbreak='⋅⋅⋅⋅'
set sidescroll=10
set textwidth=0
set wrap linebreak
set wrapmargin=0


" plugin settings
let g:gitgutter_map_keys = 0
let g:gruvbox_improved_strings = 1
let g:gruvbox_improved_warnings = 1
let g:gruvbox_hls_cursor = 'orange'
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_guard = 4
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

" bindings for LaTeX unicoder
nnoremap <leader>l :call unicoder#start(0)<cr>
vnoremap <leader>l :<c-u>call unicoder#selection()<cr>
" inoremap <leader>l <esc>:call unicoder#start(1)<cr>

" <c-y> to jump forward (opposite of <c-o>)
nnoremap <c-y> <c-i>
" <c-i> to scroll up (opposite of <c-e>)
nnoremap <c-i> <c-y>

nnoremap ZZ <nop>
nnoremap Zz <nop>
nnoremap ZX <nop>
nnoremap Zx <nop>

" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz

map <leader>w :setlocal nowrap!<cr>
map <leader>ts :setlocal spell!<cr>
map zs :setlocal spell!<cr>
map <c-f> za
map <s-f> zA
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

function! s:gruvbox_custom()
    hi clear SignColumn
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellLocal
    hi clear SpellRare
    hi SpellBad ctermbg=235 cterm=none
    hi SpellCap ctermbg=235 cterm=none
    hi SpellLocal ctermbg=235 cterm=none
    hi SpellRare ctermbg=235 cterm=none
    hi CursorLine ctermbg=none ctermfg=none cterm=none
    hi CursorLineNR ctermbg=none
    hi StatusLine ctermbg=none cterm=none
    hi StatusLineNC ctermbg=none cterm=none
    " hi MatchParen cterm=inverse
    hi Folded ctermbg=none ctermfg=238

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
    highlight GitGutterAdd ctermbg=none ctermfg=142
    highlight GitGutterChange ctermbg=none ctermfg=109
    highlight GitGutterDelete ctermbg=none ctermfg=167
    highlight GitGutterChangeDelete ctermbg=none ctermfg=175
    " highlight GitGutterAdd ctermbg=none
    " highlight GitGutterChange ctermbg=none
    " highlight GitGutterDelete ctermbg=none
    " highlight GitGutterChangeDelete ctermfg=108
endfunction

augroup custom_colors
    autocmd!
    autocmd ColorScheme gruvbox call s:gruvbox_custom()
    autocmd ColorScheme gruvbox call s:gitgutter_custom()
augroup END

colorscheme gruvbox

" unmap tmux leader key
map <c-b> <nop>
map! <c-b> <nop>

nnoremap i :noh<bar>:echo<cr>i
nnoremap I :noh<bar>:echo<cr>I
nnoremap a :noh<bar>:echo<cr>a
nnoremap A :noh<bar>:echo<cr>A
nnoremap gi :noh<bar>:echo<cr>gi
nnoremap gI :noh<bar>:echo<cr>gI
nnoremap o :noh<bar>:echo<cr>o
nnoremap O :noh<bar>:echo<cr>O
nnoremap s :noh<bar>:echo<cr>s
nnoremap S :noh<bar>:echo<cr>S
nnoremap v :noh<bar>:echo<cr>v
nnoremap V :noh<bar>:echo<cr>V
noremap <silent> <c-c> <esc>
nnoremap <silent> <c-c> :noh<bar>:echo<cr><esc>
nnoremap <c-v> :noh<bar>:echo<cr><c-v>
nnoremap <silent> <cr> :noh<bar>:echo<cr>
nnoremap <silent> <bs> :noh<bar>:echo<cr>
nnoremap <silent> <space> :noh<bar>:echo<cr>
vnoremap <bs> <nop>
vnoremap <space> <nop>


inoremap <c-c> <esc>:noh<bar>:echo<cr>
inoremap <c-]> <del>
inoremap <expr> <cr> pumvisible() ? !empty(v:completed_item) ? "<c-y><c-c>" : "<c-y><cr>" : "<cr>"

" auto closing of paired chars
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<right>"
    else
        return a:char
    endif
endf

inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ) <c-r>=ClosePair(')')<cr>
inoremap ] <c-r>=ClosePair(']')<cr>
inoremap } <c-r>=ClosePair('}')<cr>
inoremap " <c-r>=ClosePair('"')<cr>
inoremap ' <c-r>=ClosePair("'")<cr>
inoremap ` <c-r>=ClosePair('`')<cr>
inoremap $ <c-r>=ClosePair('$')<cr>

" add quotes around visual selection
" vnoremap " <c-c>`>a"<c-c>`<i"<c-c>
" vnoremap ' <c-c>`>a'<c-c>`<i'<c-c>
" vnoremap ` <c-c>`>a`<c-c>`<i`<c-c>

if has('clipboard')
    noremap y "+y
    noremap Y "+Y
    noremap d "+d
    noremap dd "+dd
    noremap D "+D
    noremap x "+x
    noremap X "+X
    noremap p "+p
    noremap P "+P
endif

" custom cursors
" LINE: \e[5
" BLOCK:
" UNDERLINE: \e[4
let &t_SI="\e[5 q"      " LINE: start insert mode
" let &t_SI="\e[4 q"    " UNDERLINE: start insert mode
let &t_EI="\e[1 q"      " UNDERLINE: end insert mode
" let &t_EI="\e[2 q"    " BLOCK: end insert mode

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
endf

" camel-case selected text
function! TwiddleCase(str)
    return substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
endfunction

" toggle dark/light background
function! ToggleBG()
    if (&background == 'light')
        set background=dark
    else
        set background=light
        hi SpellBad ctermbg=229 cterm=none
        hi SpellCap ctermbg=229 cterm=none
        hi SpellLocal ctermbg=229 cterm=none
        hi SpellRare ctermbg=229 cterm=none
    endif
endfunction

map <leader>tbg :call ToggleBG()<cr>

" toggle relative line numbers
nnoremap <leader>rln :set rnu!<cr>

" search & replace (blank)
nnoremap <leader>s :%s//gc<left><left><left>
" search visual selection
vnoremap // y/\V<c-r>=escape(@",'/\')<cr>
" search & replace visual selection
vnoremap <leader>s y`<`>:<c-u>%s/\V<c-r>=escape(@",'/\')<cr>//gc<left><left><left>

noremap <leader>h :set nohlsearch!<cr>

" silence macro recording
noremap <leader>q q
map q <nop>

noremap = g_

" text object for current line
xnoremap il g_o^
onoremap il :normal vil<cr>
xnoremap al $o^
onoremap al :normal val<cr>

" NERDCommenter mappings
autocmd! VimEnter * call s:nerdcommenter_mappings()
function! s:nerdcommenter_mappings()
    map <leader>cc <plug>NERDCommenterToggle
    map <leader>ct <plug>NERDCommenterInvert
    map <leader>c<space> <plug>NERDCommenterInvert
    noremap <leader>ci <plug>NERDCommenterAppend
    noremap <leader>ca A<space><c-c><plug>NERDCommenterAppend
    noremap <leader>co o<space><bs><c-c><plug>NERDCommenterAppend<c-o><<<c-o>$
    noremap <leader>cO O<space><bs><c-c><plug>NERDCommenterAppend<c-o><<<c-o>$
endfunction

function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
" set statusline+=%{GitStatus()}
