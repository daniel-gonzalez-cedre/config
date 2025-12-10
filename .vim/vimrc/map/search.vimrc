 noremap ? //e<left><left>
vnoremap * y/\V<c-r>=escape(@",'/\')<cr><cr>

nnoremap S :%s//gc<left><left><left>
vnoremap S y`<`>:<c-u>%s/\V<c-r>=escape(@",'/\')<cr>//gc<left><left><left>
