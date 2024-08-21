let s:palette = {'normal': {}, 'inactive': {}}
let s:palette.normal.left = [ [ '#262626', 'NONE', '0', 'NONE' ] ]
let s:palette.normal.middle = [ [ '#262626', 'NONE', '0', 'NONE' ] ]
let s:palette.normal.right = [ [ '#262626', 'NONE', '0', 'NONE' ] ]
let s:palette.inactive.left = s:palette.normal.left
let s:palette.inactive.middle = s:palette.normal.middle
let s:palette.inactive.right = s:palette.normal.right
let g:lightline#colorscheme#blank#palette = s:palette
