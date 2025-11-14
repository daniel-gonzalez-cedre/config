packadd vim-commentary
" nnoremap <silent> gC o.<esc><plug>Commentary kJi<space><esc>$s
nnoremap <silent> gcs i<enter>.<esc><plug>Commentary kJi<space><esc>
nnoremap <silent> gce i<enter>.<esc><plug>Commentary kJi<space><left>
" append comment to end of line with space
nnoremap <silent> gcA o.<esc><plug>Commentary kJi<space><esc>$s
" append comment to end of line without space
nnoremap <silent> gcL o.<esc><plug>Commentary kJx$xx
nnoremap <silent> gcO O.<esc><plug>Commentary $s
nnoremap <silent> gco o.<esc><plug>Commentary $s
