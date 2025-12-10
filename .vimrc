" ☡

source ~/.vim/vimrc/init.vimrc

source ~/.vim/vimrc/map/nop.vimrc
source ~/.vim/vimrc/map/delimit.vimrc
source ~/.vim/vimrc/map/search.vimrc
source ~/.vim/vimrc/map/toggle.vimrc
source ~/.vim/vimrc/map/qol.vimrc

source ~/.vim/vimrc/colors.vimrc

source ~/.vim/vimrc/functions.vimrc

source ~/.vim/vimrc/pack.vimrc

source ~/.vim/vimrc/pack/capslock.vimrc

source ~/.vim/vimrc/pack/delimitmate.vimrc
source ~/.vim/vimrc/pack/commentary.vimrc
source ~/.vim/vimrc/pack/surround.vimrc

source ~/.vim/vimrc/pack/fanfingtastic.vimrc
source ~/.vim/vimrc/pack/highlightedyank.vimrc
source ~/.vim/vimrc/pack/rainbow.vimrc
source ~/.vim/vimrc/pack/lightline.vimrc
source ~/.vim/vimrc/pack/tmuxline.vimrc

source ~/.vim/vimrc/pack/latex_unicoder.vimrc
source ~/.vim/vimrc/pack/nrrwrgn.vimrc
source ~/.vim/vimrc/pack/tabular.vimrc

source ~/.vim/vimrc/set.vimrc
" source ~/.vim/vimrc/filetypes.vimrc

augroup jump_settings | au!
  au VimEnter * :clearjumps
augroup END
