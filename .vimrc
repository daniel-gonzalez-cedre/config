filetype plugin indent on
silent
syntax on
au FileType * set conceallevel=0
autocmd BufEnter * :syntax sync fromstart
set autoindent
set background=dark
set backspace=indent,eol,start
set breakindent
set breakindentopt=sbr
set virtualedit=block
set previewpopup=height:10,width:60,highlight:PMenuSbar
set completeopt+=popup
set completepopup=height:15,width:60,border:off,highlight:PMenuSbar
set conceallevel=0
set cursorline
set display+=lastline
set expandtab
set foldignore=
set foldlevelstart=99
set foldmethod=indent
set formatoptions-=t
set hlsearch
set ignorecase
set is
set laststatus=2
set linebreak
set matchpairs+=<:>
set number
set ruler
set scrolloff=0
set signcolumn=number
set shiftround
set shiftwidth=4
let &showbreak=">>> "
set showcmd
set smartcase
set smartindent
set softtabstop=4
set spell
set spelllang+=cjk
set splitbelow
set splitright
set tabstop=4
set textwidth=0
set ttimeoutlen=10
set wildmenu
set wildmode=list:longest,full
set wrap
set wrapmargin=0
" tex: chktek, lacheck
let g:ale_linters = {"python": ["flake8", "pylint"], "lua": ["luacheck", "luac"], "tex": ["lacheck"]}
let g:ale_lint_on_text_changed = "never"
let g:ale_lint_on_insert_leave = 0
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_guard = 4
let g:incsearch#auto_nohlsearch = 1
let g:latex_to_unicode_file_types = ".*"
let g:matchparen_timeout = 8
let g:matchparen_insert_timeout = 8
let g:NERDCommentEmptyLines = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDToggleCheckAllLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:python_highlight_all = 1
let g:rainbow_active = 1
let g:tex_flavor = "latex"
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
colorscheme gruvbox
hi StatusLine ctermbg=none ctermfg=237 cterm=none
hi StatusLineNC ctermbg=none ctermfg=237 cterm=none
" highlight ALEErrorSign ctermfg=none cterm=inverse
" highlight ALEWarningSign ctermfg=none cterm=inverse
highlight ALEErrorLine ctermbg=234 cterm=none
highlight ALEWarningLine ctermbg=none cterm=none
highlight ALEError ctermbg=none cterm=inverse
highlight ALEWarning ctermbg=none cterm=inverse

nnoremap <leader>l :ALELint<cr>

map <C-b> <nop>
map! <C-b> <nop>

nnoremap <C-c> :noh<bar>:echo<cr><esc>
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
nnoremap <C-v> :noh<bar>:echo<cr><C-v>
nnoremap <silent> <bs> :noh<bar>:echo<cr>
nnoremap <silent> <space> :noh<bar>:echo<cr>
" nnoremap <silent> k :noh<CR>k  " might cause cursor to disappear when holding down
" nnoremap <silent> j :noh<CR>j
" nnoremap <silent> h :noh<CR>h
" nnoremap <silent> l :noh<CR>l
" nnoremap <C-k> gk
" nnoremap <C-j> gj

nnoremap <C-f> za
nnoremap F zA

inoremap <C-c> <esc>:noh<bar>:echo<cr>
inoremap <C-]> <del>
inoremap <expr> <cr> pumvisible() ? !empty(v:completed_item) ? "<C-y><C-c>" : "<C-y><cr>" : "<cr>"

inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ) <C-r>=ClosePair(')')<cr>
inoremap ] <C-r>=ClosePair(']')<cr>
inoremap } <C-r>=ClosePair('}')<cr>
inoremap " <C-r>=QuoteDelim('"')<cr>
inoremap ' <C-r>=QuoteDelim("'")<cr>
" vnoremap ( <C-c>`>a)<C-c>`<i(<C-c>
" vnoremap [ <C-c>`>a]<C-c>`<i[<C-c>
" vnoremap { <C-c>`>a}<C-c>`<i{<C-c>
" vnoremap ) <C-c>`<i(<C-c>`><right>a)<C-c>
" vnoremap ] <C-c>`<i[<C-c>`><right>a]<C-c>
" vnoremap } <C-c>`<i{<C-c>`><right>a}<C-c>
vnoremap // y/\V<C-r>=escape(@",'/\')<cr>
vnoremap = g_
nnoremap = g_

" think about this later
" vnoremap <C-[> <C-c>`>a<C-r>=ReplaceDelim(']')<CR><C-c>`<i<C-r>=ReplaceDelim('[')<CR><C-c>
" matchstr(getline('.'), '\%' . col('.') . 'c.')
" function! ReplaceDelim(repl)
"     let char = matchstr(getline('.'), '\%' . col('.') . 'c.')
"     if char == "(" ||  char == "{" || char == "["
"         return "\<DEL>".a:repl
"     elseif char == ")" || char == "}" ||char == "]"
"         return "\<BS>".a:repl
"     else
"         return a:repl
" endf

vnoremap <bs> <nop>

vnoremap " <C-c>`>a"<C-c>`<i"<C-c>
vnoremap ' <C-c>`>a'<C-c>`<i'<C-c>
vnoremap ` <C-c>`>a`<C-c>`<i`<C-c>

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
let &t_SI="\e[5 q"  " LINE: start insert mode
" let &t_SI="\e[4 q"  "  UNDERLINE: start insert mode
let &t_EI="\e[1 q"  "  UNDERLINE: end insert mode
" let &t_EI="\e[2 q"  "  BLOCK: end insert mode

" auto closing of paired chars
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<right>"
    else
        return a:char
    endif
endf
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
        highlight ALEErrorLine ctermbg=234 cterm=none
        highlight ALEWarningLine ctermbg=none cterm=none
        highlight ALEError ctermbg=none cterm=inverse
        highlight ALEWarning ctermbg=none cterm=inverse
    else
        set bg=light
        highlight ALEErrorLine ctermbg=15 cterm=none
        highlight ALEWarningLine ctermbg=none cterm=none
        highlight ALEError ctermbg=none cterm=inverse
        highlight ALEWarning ctermbg=none cterm=inverse
    endif
    hi StatusLine ctermbg=none ctermfg=237 cterm=none
    hi StatusLineNC ctermbg=none ctermfg=237 cterm=none
endfunction

map <leader><C-t> :call ToggleBG()<cr>
map <leader>n :ALENextWrap<cr>
map <leader>N :ALEPreviousWrap<cr>
map <leader>m :ALEDetail<cr>

""vnoremap // y/\V<C-r>=escape(@",'/\')<cr>

" search & replace
nnoremap <leader>s :%s//gc<left><left><left>
" search & replace visual selection
vnoremap <leader>s y`<`>:<C-u>%s/\V<C-r>=escape(@",'/\')<cr>//gc<left><left><left>
vnoremap <leader><C-s> :%s//gc<left><left><left>
" remove all highlighting highlighting
noremap <leader>h :noh<cr>

set fillchars=stl:⋅,stlnc:⋅,vert:│,fold:۰,diff:·
