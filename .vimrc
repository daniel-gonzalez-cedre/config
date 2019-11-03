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
set laststatus=2
set number
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
let g:python_highlight_all = 1
let g:latex_to_unicode_file_types = ".*"
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_guard = 4
let g:alduin_Shout_Become_Ethereal = 1
colorscheme alduin
"colorscheme blaquemagick
inoremap <C-c> <Esc>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap $ <c-r>=QuoteDelim("$")<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>
vnoremap ( <C-c>`>a)<C-c>`<i(<C-c>
vnoremap [ <C-c>`>a]<C-c>`<i[<C-c>
vnoremap { <C-c>`>a}<C-c>`<i{<C-c>
vnoremap $ <C-c>`>a$<C-c>`<i$<C-c>
vnoremap " <C-c>`>a"<C-c>`<i"<C-c>
vnoremap ' <C-c>`>a'<C-c>`<i'<C-c>
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
