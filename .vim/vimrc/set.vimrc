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
set hlsearch

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
au FileType * set smarttab
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

" FILETYPE SPECIFIC
augroup rc_settings | au!
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

  au FileType tex imap ` <nop>
  au FileType tex iunmap `
augroup END
