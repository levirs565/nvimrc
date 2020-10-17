set number

"set termguicolors
if exists('+termguicolors')
  "let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

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
call plug#end()

autocmd vimenter * NERDTree

let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'

let g:srootdir=expand("<sfile>:p:h")
function SourceLocal(relativePath)
  let fullPath = g:srootdir . '/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call SourceLocal('util/index.vim') 

colorscheme gruvbox
nmap <M-1> :NERDTreeToggle<CR>
