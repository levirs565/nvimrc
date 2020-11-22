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

"autocmd vimenter * NERDTree

let g:gitgutter_grep = $GIT_INSTALL_ROOT . '\usr\bin\grep.exe'
let g:gitgutter_git_executable = $GIT_INSTALL_ROOT . '\cmd\git.exe'

let g:srootdir=expand("<sfile>:p:h")
function SourceLocal(relativePath)
  let fullPath = g:srootdir . '/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call SourceLocal('util/index.vim') 
call SourceLocal('init.d/filetype.vim')
call SourceLocal('plugin/airline.vim')
call SourceLocal('plugin/fugitive.vim')
call SourceLocal('plugin/fzf.vim')
call SourceLocal('plugin/startify.vim')
call SourceLocal('plugin/vimwiki.vim')

colorscheme gruvbox
nmap <M-1> :NERDTreeToggle<CR>
