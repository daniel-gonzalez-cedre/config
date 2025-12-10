augroup set_settings | au!
  au BufEnter * set formatoptions=tjcrqn

  au BufEnter * set autoindent
  au BufEnter * set expandtab
  au BufEnter * set smarttab
  au BufEnter * set shiftwidth=2
  au BufEnter * set softtabstop=2
  au BufEnter * set tabstop=8
augroup END

set background=dark
set backspace=indent,eol,start
set cursorline
set display+=lastline

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

set foldopen-=search
set foldopen+=undo
set foldcolumn=0
set foldlevelstart=99
set foldmethod=indent

set fillchars+=fold:\ 
set foldtext=ShowFoldText()
" set foldtext=

set breakindent
set breakindentopt=sbr
set linebreak
set sidescroll=10
set textwidth=0
" set list
" set listchars=nbsp:_,eol:⋅
" " set listchars=multispace:_,nbsp:_,eol:$

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
