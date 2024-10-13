" run this in the vim command line
" just in case, run :helptags ALL afterwards
command! -nargs=0 -bar Helptags
    \  for p in glob('~/.vim/pack/bundle/opt/*', 1, 1)
    \|     exe 'packadd ' . fnamemodify(p, ':t')
    \| endfor
    \| helptags ALL
