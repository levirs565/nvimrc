"set termguicolors
if exists('+termguicolors')
  "let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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
lua require("setting")

"set shell=powershell
"let g:neoterm_shell='C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe'

let g:srootdir=expand("<sfile>:p:h")

call plug#begin(g:srootdir . '/plugged')
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'kassio/neoterm'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'mhinz/vim-startify'
Plug 'sheerun/vim-polyglot'
Plug 'romgrk/lib.kom'
Plug 'terrortylor/nvim-comment'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

"autocmd vimenter * NERDTree

function! SourceLocal(relativePath)
  let fullPath = g:srootdir . '/'. a:relativePath
  exec 'source ' . fullPath
endfunction

call SourceLocal('init.d/filetype.vim')

colorscheme gruvbox
if filereadable(fnamemodify("~/.nvim_color", ":p"))
  source ~/.nvim_color
endif

lua require("plugins.comment")
lua require("plugins.tree")
lua require("plugins.telescope")
lua require("mapping")
lua require("window")
