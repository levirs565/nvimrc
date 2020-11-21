set number

"set termguicolors
if exists('+termguicolors')
  "let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set nocompatible
filetype plugin on
syntax on
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

"set shell=powershell
"let g:neoterm_shell='C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe'


call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'paulondc/vim-nerdtree-open-externally'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'qpkorr/vim-bufkill'
Plug 'kassio/neoterm'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
call plug#end()

let g:vimwiki_list = [{'path': '~/VimWiki/',
                      \ 'syntax': 'markdown', 
		      \ 'ext': '.md',
		      \ 'path_html': '~/VimWiki/site_html',
		      \ 'custom_wiki2html': 'vimwiki_markdown'}]
let g:vimwiki_auto_chdir = 1
let g:vimwiki_dir_link = 'index'
let g:vimwiki_global_ext = 0
let g:startify_bookmarks = systemlist("cut -sd\" \" -f 2 ".$HOME."/.NERDTreeBookmarks")
let g:startify_commands = [['VimWiki Index', 'VimwikiIndex']]
let g:startify_lists = [
			\ { 'type': 'commands',  'header': ['   Commands'       ]},
			\ { 'type': 'bookmarks', 'header': ['   Bookmakrs'      ]},
			\ { 'type': 'sessions',  'header': ['   Sessions'       ]},
			\ { 'type': 'files',     'header': ['   MRU'            ]},
			\ { 'type': 'dir',       'header': ['   MRU ' . getcwd()]}
			\]
"autocmd vimenter * NERDTree

let g:gitgutter_grep = $GIT_INSTALL_ROOT . '\usr\bin\grep.exe'
let g:gitgutter_git_executable = $GIT_INSTALL_ROOT . '\cmd\git.exe'
let g:airline_powerline_fonts = 1

let g:srootdir=expand("<sfile>:p:h")
function SourceLocal(relativePath)
  let fullPath = g:srootdir . '/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call SourceLocal('util/index.vim') 
call SourceLocal('init.d/filetype.vim')

colorscheme gruvbox
nmap <M-1> :NERDTreeToggle<CR>
autocmd filetype fugitive execute "wincmd L | vertical resize 31" 
autocmd filetype fzf tnoremap <buffer>  <ESC> <C-c> 
autocmd filetype vimwiki nmap <buffer><silent> <Backspace> 
			\:let lastbuffer=bufnr("%")<CR> 
			\:VimwikiGoBackLink<CR>
			\:if bufnr("%") != lastbuffer<CR>
			\exe "bdelete".lastbuffer<CR>
			\endif<CR>
