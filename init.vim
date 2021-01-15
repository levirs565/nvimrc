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
set linebreak
set autoread
set expandtab
set shiftwidth=4
set softtabstop=4
set title
set splitright
set splitbelow
set updatetime=1000
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

if &shell != 'cmd.exe'
  set shcf=-c
  set sxq=
  set ssl
endif

let g:srootdir=expand("<sfile>:p:h")

call plug#begin(g:srootdir . '/plugged')
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'paulondc/vim-nerdtree-open-externally'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'qpkorr/vim-bufkill'
Plug 'kassio/neoterm'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
Plug 'sheerun/vim-polyglot'
call plug#end()

"autocmd vimenter * NERDTree

function! SourceLocal(relativePath)
  let fullPath = g:srootdir . '/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call SourceLocal('util/index.vim') 
call SourceLocal('init.d/filetype.vim')

colorscheme gruvbox
nmap <M-1> :NERDTreeToggle<CR>
