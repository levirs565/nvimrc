let g:vimwiki_list = [{'path': '~/VimWiki/',
                      \ 'template_path': '~/VimWiki/templates/',
                      \ 'template_default': 'default',
                      \ 'template_ext': '.html',
                      \ 'syntax': 'markdown', 
		      \ 'ext': '.md',
		      \ 'path_html': '~/VimWiki/site_html',
		      \ 'custom_wiki2html': 'vimwiki_markdown'}]
let g:vimwiki_auto_chdir = 1
let g:vimwiki_dir_link = 'index'
let g:vimwiki_global_ext = 0

call setenv('VIMWIKI_MARKDOWN_EXTENSIONS', 'pymdownx.arithmatex')

autocmd filetype vimwiki nmap <buffer><silent> <Backspace> 
			\:let lastbuffer=bufnr("%")<CR> 
			\:VimwikiGoBackLink<CR>
			\:if bufnr("%") != lastbuffer<CR>
			\exe "bdelete".lastbuffer<CR>
			\endif<CR>
autocmd filetype vimwiki setlocal spell spelllang=id
