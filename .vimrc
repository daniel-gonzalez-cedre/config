filetype plugin indent on
silent
syntax on
au FileType * set conceallevel=0
autocmd BufEnter * :syntax sync fromstart
set autoindent
set background=dark
set backspace=indent,eol,start
set conceallevel=0
set display+=lastline
set expandtab
set foldignore=
set foldlevelstart=99
set foldmethod=indent
set hlsearch
set laststatus=2
set linebreak
set matchpairs+=<:>
set number
set relativenumber
set ruler
set scrolloff=5
set shiftround
set shiftwidth=4
set smartindent
set softtabstop=4
set spell
set splitbelow
set splitright
set tabstop=4
set wildmenu
set wildmode=list:longest,full
set wrap
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_guard = 4
let g:incsearch#auto_nohlsearch = 1
let g:latex_to_unicode_file_types = ".*"
let g:matchparen_timeout = 8
let g:matchparen_insert_timeout = 8
let g:python_highlight_all = 1
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_number_column = "black"
colorscheme gruvbox
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
noremap <C-f> za
nnoremap <C-j> gj
nnoremap <C-k> gk
noremap F zA
inoremap <C-c> <Esc>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ) <C-r>=ClosePair(')')<CR>
inoremap ] <C-r>=ClosePair(']')<CR>
inoremap } <C-r>=ClosePair('}')<CR>
au BufNewFile *.tex inoremap $ <C-r>=QuoteDelim("$")<CR>
au BufRead *.tex inoremap $ <C-r>=QuoteDelim("$")<CR>
inoremap " <C-r>=QuoteDelim('"')<CR>
inoremap ' <C-r>=QuoteDelim("'")<CR>
vnoremap ( <C-c>`>a)<C-c>`<i(<C-c>
vnoremap [ <C-c>`>a]<C-c>`<i[<C-c>
vnoremap { <C-c>`>a}<C-c>`<i{<C-c>
vnoremap <BS> <Nop>
au BufNewFile *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
au BufRead *.tex vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
vnoremap " <C-c>`>a"<C-c>`<i"<C-c>
vnoremap ' <C-c>`>a'<C-c>`<i'<C-c>
vnoremap ` <C-c>`>a`<C-c>`<i`<C-c>
vnoremap <C-u> y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""P
if has('clipboard')
    vnoremap y "+y
    vnoremap Y "+y
    noremap x "+x
    noremap X "+x
    noremap d "+d
    noremap p "+p
    noremap P "+P
    noremap s "+s
    noremap S "+S
endif
augroup keymap_ft
  au!
  autocmd BufNewFile,BufRead *.keymap   set syntax=keymap
augroup END

" START CUSTOM CURSORS
let &t_SI="\e[4 q" " start insert mode: underline
let &t_EI="\e[2 q" " end insert mode: block
" END CUSTOM CURSORS

" START NVIM-R SETTINGS
    " start with \rf
    " quit with \rq
    " <C-w> to switch panes
let R_assign_map = "--"
let R_external_term = 1
vmap <Space> <Plug>RSendSelection
nmap <LocalLeader><Space> <Plug>RSendLine
" END NVIM-R SETTINGS

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
function! TwiddleCase(str)
    return substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
endfunction
