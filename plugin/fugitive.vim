autocmd filetype fugitive if !getbufvar('%', 'win_configured', 0) |
      \   execute "wincmd L | vertical resize 31" |
      \   call setbufvar("%", "win_configured", 1) |
      \ endif
