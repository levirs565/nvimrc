let g:vimwiki_list = [{'path': '~/VimWiki/',
                      \ 'syntax': 'markdown', 
		      \ 'ext': '.md',
		      \ 'path_html': '~/VimWiki/site_html',
		      \ 'custom_wiki2html': 'vimwiki_markdown'}]
let g:vimwiki_auto_chdir = 1
let g:vimwiki_dir_link = 'index'
let g:vimwiki_global_ext = 0

autocmd filetype vimwiki nmap <buffer><silent> <Backspace> 
			\:let lastbuffer=bufnr("%")<CR> 
			\:VimwikiGoBackLink<CR>
			\:if bufnr("%") != lastbuffer<CR>
			\exe "bdelete".lastbuffer<CR>
			\endif<CR>
autocmd filetype vimwiki setlocal spell spelllang=id
