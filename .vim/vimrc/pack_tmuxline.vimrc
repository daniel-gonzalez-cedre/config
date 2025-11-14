packadd tmuxline.vim

if executable('tmux') && filereadable(expand('~/.zshrc')) && $TMUX !=# ''
  let g:vim_is_in_tmux = 1
  " let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
  " let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
else
  let g:vim_is_in_tmux = 0
endif

if g:vim_is_in_tmux == 1 && !has('win32')
  " let g:tmuxline_powerline_separators = 0
  let g:tmuxline_status_justify = 'left'
  let g:tmuxline_theme = 'lightline'
  let g:tmuxline_preset = {
        \'a'    : '#S',
        \'b'    : '#P',
        \'win'  : '#W',
        \'cwin' : '#W',
        \'x'    : '%a',
        \'y'    : '%h %d',
        \'z'    : '%R'
        \}
  " let g:tmuxline_preset = {
  " \'a'    : '#S',
  " \'b'    : '#{b:pane_current_path}',
  " \'win'  : '#W',
  " \'cwin' : '#W',
  " \'x'    : '%a',
  " \'y'    : '%h %d',
  " \'z'    : '%R'
  " \}
  " let g:tmuxline_preset = {
  " \'a'    : '#S',
  " \'b'    : '#{d:pane_current_path}',
  " \'c'    : '#{b:pane_current_path}',
  " \'win'  : '#W',
  " \'cwin' : '#W',
  " \'x'    : '%a',
  " \'y'    : '%h %d',
  " \'z'    : '%R'
  " \}
  " let g:tmuxline_separators = {
  " \ 'left' : '',
  " \ 'left_alt': '',
  " \ 'right' : '',
  " \ 'right_alt' : '',
  " \ 'space' : ' '}
  let g:tmuxline_separators = {
        \ 'left' : '',
        \ 'left_alt': '',
        \ 'right' : '',
        \ 'right_alt' : '',
        \ 'space' : ' '}
  " let g:tmuxline_theme = {
  " \   'a'    : [ 236, 103 ],
  " \   'b'    : [ 253, 239 ],
  " \   'c'    : [ 244, 236 ],
  " \   'x'    : [ 244, 236 ],
  " \   'y'    : [ 253, 239 ],
  " \   'z'    : [ 236, 103 ],
  " \   'win'  : [ 103, 236 ],
  " \   'cwin' : [ 236, 103 ],
  " \   'bg'   : [ 244, 236 ],
  " \ }
endif
