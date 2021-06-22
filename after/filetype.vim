autocmd FileType sh setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType markdown setlocal textwidth=100 colorcolumn=100

autocmd FileType NvimTree setlocal cursorline

" Make below buffers not listed in barbar and also not deleted when use bbye
augroup HiddenBuffer
  autocmd!
  autocmd FileType neoterm,Neogit*,gitcommit setlocal nobuflisted
augroup END

autocmd filetype NeogitStatus lua require("window").configure_fugitive_window()

autocmd filetype gitcommit nmap <buffer> <C-CR> :wq<CR>
autocmd filetype gitcommit nmap <buffer> <M-CR> <C-CR>
autocmd filetype gitcommit nmap <buffer> <C-w>q :q!<CR>

autocmd FileType floaterm lua require("mapping").apply_floaterm()
