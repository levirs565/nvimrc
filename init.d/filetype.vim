autocmd FileType sh setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType markdown setlocal textwidth=100 colorcolumn=100

" Make below buffers not listed in barbar and also not deleted when use bbye
augroup HiddenBuffer
  autocmd!
  autocmd FileType neoterm setlocal nobuflisted
  autocmd FileType fugitive setlocal nobuflisted
augroup END
