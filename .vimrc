filetype plugin indent on
silent
syntax on
autocmd BufEnter * :syntax sync fromstart
set autoindent
set background=dark
set expandtab
set number
set ruler
set shiftround
set shiftwidth=4
set smartindent
set softtabstop=4
set spell
set splitbelow
set splitright
set tabstop=4
let g:latex_to_unicode_file_types = ".*"
let g:haskell_indent_if = 4
let g:haskell_indent_case = 4
let g:haskell_indent_guard = 4
let g:alduin_Shout_Dragon_Aspect = 1
colorscheme alduin
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
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
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
