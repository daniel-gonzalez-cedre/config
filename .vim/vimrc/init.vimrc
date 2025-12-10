filetype plugin indent on
syntax enable
silent
runtime ftplugin/man.vim

noremap <silent> <space> <nop>
let mapleader = "\<space>"

let keyprotocol = ""

augroup init_settings | au!
  " uncomment this line ∨∨∨
  " au VimEnter,BufEnter,BufNewFile,BufReadPost * set nospell
  " uncomment this line ∧∧∧

  " au BufEnter * set nospell
  " au BufEnter,BufNewFile,BufReadPost *.vimrc,*.vim setlocal nospell
  " au FileType vim set nospell
  " au FileType text,markdown,html,tex,vim,gitcommit set spell

  au VimEnter,BufEnter,BufNewFile,BufReadPost * syntax sync fromstart
  au VimEnter,BufEnter,BufNewFile,BufReadPost * set conceallevel=0
  " au BufEnter,BufNewFile,BufReadPost * set conceallevel=1
  " au FileType * syntax keyword Normal lambda conceal cchar=λ

  " au VimEnter * set completeopt=menuone,popup,noinsert,noselect,fuzzy
  au VimEnter * set completepopup=height:16,width:32
  au VimEnter * set previewpopup=height:16,width:32
  " au VimEnter * set completepopup=height:15,width:60,border:off,highlight:PMenuSbar
  " au VimEnter * set previewpopup=height:10,width:60,highlight:PMenuSbar

  au FileType gitcommit set nowrap
  au VimEnter,BufEnter,BufNewFile,BufReadPost,FileType * call SetQuote()

  " CUSTOM CURSORS
  " BLINKING BLOCK:     \e[0
  " BLINKING BLOCK:     \e[1
  " STEADY BLOCK:       \e[2
  " BLINKING UNDERLINE: \e[3
  " STEADY UNDERLINE:   \e[4
  " BLINKING BAR:       \e[5
  " STEADY BAR:         \e[6
  let &t_SI="\e[6 q"  " start insert mode
  let &t_EI="\e[2 q"  " end insert mode
augroup END

augroup set_settings | au!
  au VimEnter,BufEnter,BufNewFile,BufReadPost,FileType * set tw=0
augroup END

" set home config directory
if !isdirectory($HOME.'/.vim')
  call mkdir($HOME.'/.vim', '', 0770)
endif

" set directory for miscellaneous book-keeping files
if !isdirectory($HOME.'/.vim/vimfiles')
  call mkdir($HOME.'/.vim/vimfiles', '', 0700)
endif

" set swap directory
if !isdirectory($HOME.'/.vim/vimfiles/swapfiles')
  call mkdir($HOME.'/.vim/vimfiles/swapfiles', '', 0700)
endif
set directory=~/.vim/vimfiles/swapfiles//

" set views directory
if !isdirectory($HOME.'/.vim/vimfiles/viewfiles')
  call mkdir($HOME.'/.vim/vimfiles/viewfiles', '', 0700)
endif
set viewdir=~/.vim/vimfiles/viewfiles//
set viewoptions=cursor,folds
" set viewoptions=cursor
set sessionoptions=folds
" set sessionoptions=
augroup autosave_recovery | au!
  au BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  " au BufWinLeave * mkview
  au BufWinEnter ?* silent! loadview
augroup END

" set undo directory
if !isdirectory($HOME.'/.vim/vimfiles/undodir')
  call mkdir($HOME.'/.vim/vimfiles/undodir', '', 0700)
endif
set undodir=~/.vim/vimfiles/undodir
set undofile

" make sure colors are set correctly
" if $TERM_PROGRAM !=# 'Apple_Terminal' || $TMUX !=? ''
if $TERM_PROGRAM !=# 'Apple_Terminal'
  set termguicolors

  " UNDERCURL SUPPORT
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"

  " COLORED UNDERCURL SUPPORT
  " let &t_RB = "\<esc>]11;?\<C-G>"
  let &t_RV = "\<esc>[>c"

  if &term =~ "alacritty"
    let &t_fe = "\<esc>[?1004h"
    let &t_fd = "\<esc>[?1004l"
  endif

  if (has('nvim'))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
endif

" " reload if file has been edited elsewhere
" redir => capture
" silent au CursorHold
" redir END
" if match(capture, 'checktime') == -1
" augroup reload_settings
" au!
" au CursorHold * silent! checktime
" augroup END
" endif
