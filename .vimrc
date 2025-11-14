" ☡

noremap <silent> <space> <nop>
let mapleader = "\<space>"

source ~/.vim/vimrc/init.vimrc

source ~/.vim/vimrc/map_delimit.vimrc  " TODO
source ~/.vim/vimrc/map_nop.vimrc      " TODO
source ~/.vim/vimrc/map_search.vimrc   " TODO
source ~/.vim/vimrc/map_toggle.vimrc   " TODO
source ~/.vim/vimrc/map_qol.vimrc      " TODO

source ~/.vim/vimrc/colors.vimrc

source ~/.vim/vimrc/functions.vimrc

source ~/.vim/vimrc/pack.vimrc
source ~/.vim/vimrc/pack_capslock.vimrc
source ~/.vim/vimrc/pack_commentary.vimrc
source ~/.vim/vimrc/pack_delimitmate.vimrc
source ~/.vim/vimrc/pack_highlightedyank.vimrc
source ~/.vim/vimrc/pack_latex_unicoder.vimrc
source ~/.vim/vimrc/pack_nrrwrgn.vimrc
source ~/.vim/vimrc/pack_rainbow.vimrc
source ~/.vim/vimrc/pack_tabular.vimrc
source ~/.vim/vimrc/pack_lightline.vimrc
source ~/.vim/vimrc/pack_tmuxline.vimrc

source ~/.vim/vimrc/set.vimrc

augroup jump_settings | au!
  au VimEnter * :clearjumps
augroup END
