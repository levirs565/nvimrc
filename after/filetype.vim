autocmd FileType sh setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType markdown setlocal textwidth=100 colorcolumn=100

autocmd FileType NvimTree setlocal cursorline

" Make below buffers not listed in barbar and also not deleted when use bbye
augroup HiddenBuffer
  autocmd!
  autocmd FileType neoterm,NeogitStatus setlocal nobuflisted
augroup END

autocmd filetype NeogitStatus lua require("window").configure_fugitive_window()
