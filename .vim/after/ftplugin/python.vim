function UpdateFolds()
    call SimpylFold#Recache()
    " FastFoldUpdate!  " replace with `normal! zx` if you don't have FastFold
    normal! zx
endfunction
autocmd BufWritePre <buffer> call UpdateFolds()
