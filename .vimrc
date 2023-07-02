filetype plugin indent on
silent
syntax enable
au FileType * set conceallevel=0
autocmd BufEnter * :syntax sync fromstart

set background=dark
set backspace=indent,eol,start
" set completeopt+=popup
" set completepopup=height:15,width:60,border:off,highlight:PMenuSbar
set conceallevel=0
set cursorline
set display+=lastline
set hlsearch
set ignorecase
set is
set laststatus=2
set matchpairs+=<:>
set mouse=
set number relativenumber
set numberwidth=4
" set previewpopup=height:10,width:60,highlight:PMenuSbar
set ruler
set scrolloff=0
set signcolumn=number
set shiftround
set showcmd
set smartcase
set spell
set spelllang+=cjk
set splitbelow
set splitright
set ttimeoutlen=10
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
set smartindent
set softtabstop=4
set tabstop=4

" line wrapping
" set breakindent
" set breakindentopt=sbr
set formatoptions-=t
set linebreak
" set list
set listchars=tab:__,nbsp:⋅,eol:⋅
let &showbreak=" ~~ "
set sidescroll=10
set textwidth=0
set wrap linebreak
set wrapmargin=0


let g:ale_linters = {"python": ["flake8", "pylint"], "lua": ["luacheck", "luac"], "tex": ["lacheck"]}
" tex: chktek, lacheck
" let g:ale_lint_on_text_changed = "always"
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_delay = 0
let g:ale_lint_on_save = 1
let g:ale_virtualtext_cursor = 'current'
let g:gitgutter_map_keys = 0
let g:gruvbox_improved_warnings = 1
let g:gruvbox_hls_cursor = "orange"
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_guard = 4
let g:incsearch#auto_nohlsearch = 1
let g:latex_to_unicode_file_types = ".*"
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
let g:tex_flavor = "latex"

function! s:gruvbox_custom()
    highlight clear SignColumn
    hi CursorLine ctermbg=none ctermfg=none cterm=none
    hi CursorLineNR ctermbg=none
    hi StatusLine ctermbg=none cterm=none
    hi StatusLineNC ctermbg=none cterm=none
    hi MatchParen cterm=inverse
    hi Folded ctermbg=none
    hi ALEErrorLine ctermbg=none cterm=none
    hi ALEWarningLine ctermbg=none cterm=none
    hi ALEError ctermbg=none cterm=none
    hi ALEWarning ctermbg=none cterm=none
    hi ALEErrorSign ctermfg=167 ctermbg=none
    hi ALEWarningSign ctermfg=214 ctermbg=none
    hi ALEInfoSign ctermfg=109 ctermbg=none
    hi ALEVirtualTextError ctermfg=238
    hi ALEVirtualTextWarning ctermfg=238
    hi SignColumn ctermbg=black
endfunction
function! s:gitgutter_custom()
    highlight clear SignColumn
    highlight GitGutterAdd ctermbg=black
    highlight GitGutterChange ctermbg=black
    highlight GitGutterDelete ctermbg=black
    highlight GitGutterChangeDelete ctermfg=108
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

nnoremap <c-c> :noh<bar>:echo<cr><esc>
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
nnoremap <c-v> :noh<bar>:echo<cr><c-v>
nnoremap <silent> <bs> :noh<bar>:echo<cr>
" nnoremap <silent> <space> :noh<bar>:echo<cr>
" nnoremap <silent> <space> @=(foldlevel('.')?'za':"\<space>")<cr>
" nnoremap <silent> <space> @=(foldlevel('.')?'za':"")<cr>:noh<bar>:echo<cr>
nnoremap <silent> <space> :noh<bar>:echo<cr>

" nnoremap <c-k> gk
" nnoremap <c-j> gj

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

vnoremap <bs> <nop>
vnoremap <space> <nop>

if has('clipboard')
    vnoremap y "+y
    vnoremap Y "+Y
    vnoremap x "+x
    vnoremap X "+X
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
    if (&bg == "light")
        set bg=dark
    else
        set bg=light
    endif
endfunction

map <leader>tt :call ToggleBG()<cr>

" toggle relative line numbers
nnoremap <leader>nn :set rnu!<cr>
" search visual selection
vnoremap // y/\V<c-r>=escape(@",'/\')<cr>
" search & replace
nnoremap <leader>s :%s//gc<left><left><left>
" search & replace visual selection
vnoremap <leader>s y`<`>:<c-u>%s/\V<c-r>=escape(@",'/\')<cr>//gc<left><left><left>
" remove all highlighting highlighting
noremap <leader>h :noh<cr>
" silence macro recording
noremap <leader>q q
map q <nop>

noremap = g_

" text object for current line
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>

" NERDCommenter mappings
autocmd! VimEnter * call s:nerdcommenter_mappings()
function! s:nerdcommenter_mappings()
    map <leader>cc <plug>NERDCommenterToggle
    map <leader>ct <plug>NERDCommenterInvert
    map <leader>c<space> <plug>NERDCommenterInvert
    noremap <leader>ci <plug>NERDCommenterAppend
    noremap <leader>ca A<space><c-c><plug>NERDCommenterAppend
    noremap <leader>co o<c-c><plug>NERDCommenterAppend
    noremap <leader>cO O<c-c><plug>NERDCommenterAppend
endfunction

" ALE mappings
map <leader>ll :ALENextWrap<cr>
map <leader>lL :ALEPreviousWrap<cr>
map <leader>LL :ALEPreviousWrap<cr>
map <leader>ld :ALEDetail<cr>

set fillchars=stl:⋅,stlnc:⋅,vert:│,fold:۰,diff:·

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
" set statusline+=%{GitStatus()}
