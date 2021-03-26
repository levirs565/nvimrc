autocmd filetype fugitive lua require("window").configure_fugitive_window()
autocmd filetype gitcommit nmap <buffer> <C-CR> :wq<CR>
autocmd filetype gitcommit nmap <buffer> <C-w>q :q!<CR>
