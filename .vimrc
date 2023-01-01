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
set hlsearch
set ignorecase
set laststatus=2
set linebreak
set matchpairs+=<:>
set number
set ruler
set scrolloff=1
set signcolumn=number
set shiftround
set shiftwidth=4
let &showbreak="> "
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
set wrapmargin=1
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
let g:python_highlight_all = 1
let g:rainbow_active = 1
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
map <C-b> <Nop>
map! <C-b> <Nop>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
nnoremap <C-f> za
nnoremap <C-j> gj
nnoremap <C-k> gk
nnoremap F zA

nnoremap <C-l> :ALELint<CR>

imap <C-c> <ESC>
inoremap <C-]> <Del>
inoremap <expr> <CR> pumvisible() ? !empty(v:completed_item) ? "<C-y><C-c>" : "<C-y><CR>" : "<CR>"

inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ) <C-r>=ClosePair(')')<CR>
inoremap ] <C-r>=ClosePair(']')<CR>
inoremap } <C-r>=ClosePair('}')<CR>
inoremap " <C-r>=QuoteDelim('"')<CR>
inoremap ' <C-r>=QuoteDelim("'")<CR>
vnoremap ( <C-c>`>a)<C-c>`<i(<C-c>
vnoremap [ <C-c>`>a]<C-c>`<i[<C-c>
vnoremap { <C-c>`>a}<C-c>`<i{<C-c>
vnoremap ) <C-c>`<i(<C-c>`><RIGHT>a)<C-c>
vnoremap ] <C-c>`<i[<C-c>`><RIGHT>a]<C-c>
vnoremap } <C-c>`<i{<C-c>`><RIGHT>a}<C-c>

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

vnoremap <BS> <Nop>

vnoremap " <C-c>`>a"<C-c>`<i"<C-c>
vnoremap ' <C-c>`>a'<C-c>`<i'<C-c>
vnoremap ` <C-c>`>a`<C-c>`<i`<C-c>
vnoremap <C-u> y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""P

if has('clipboard')
    vnoremap y "+y
    vnoremap Y "+Y
    vnoremap x "+x
    vnoremap X "+X
    noremap p "+p
    noremap P "+P
endif

" custom cursor: start insert mode with underline
let &t_SI="\e[4 q"
" custom cursor: end insert mode with block
let &t_EI="\e[2 q"

" auto closing of paired chars
function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
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
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
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

map <LEADER><C-t> :call ToggleBG()<CR>
map <LEADER>n :ALENextWrap<CR>
map <LEADER>N :ALEPreviousWrap<CR>
map <LEADER>m :ALEDetail<CR>

" search & replace
nnoremap <LEADER>s :%s//gc<LEFT><LEFT><LEFT>
" search & replace visual selection
vnoremap <LEADER>s y`<`>:<C-u>%s/<C-r>0//gc<LEFT><LEFT><LEFT>
vnoremap <LEADER><C-s> :%s//gc<LEFT><LEFT><LEFT>
" remove all highlighting highlighting
noremap <LEADER>h :noh<CR>

set fillchars=stl:⋅,stlnc:⋅,vert:│,fold:۰,diff:·
