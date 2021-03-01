autocmd filetype fugitive if !getbufvar('%', 'win_configured', 0) |
      \   execute "wincmd L | vertical resize 31" |
      \   call setbufvar("%", "win_configured", 1) |
      \ endif

nmap <A-k> :Git<CR>
autocmd filetype gitcommit nmap <buffer> <C-CR> :wq<CR>
autocmd filetype gitcommit nmap <buffer> <C-w>q :q!<CR>
