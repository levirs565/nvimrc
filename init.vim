if exists('+termguicolors')
  set termguicolors
endif

filetype plugin on
syntax on
lua require("setting")

let g:srootdir=expand("<sfile>:p:h")

call plug#begin(g:srootdir . '/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
Plug 'terrortylor/nvim-comment'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'rktjmp/lush.nvim'
Plug 'npxbr/gruvbox.nvim'
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/goyo.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'folke/todo-comments.nvim'
call plug#end()

if filereadable(fnamemodify("~/.nvim_color", ":p"))
  source ~/.nvim_color
endif
colorscheme gruvbox

lua require("plugins.comment")
lua require("plugins.tree")
lua require("plugins.telescope")
lua require("plugins.compe")
lua require("plugins.lspconfig")
lua require("plugins.lspsaga")
lua require("plugins.dashboard")
lua require("plugins.galaxyline")
lua require("plugins.floaterm")
lua require("plugins.todo")
lua require("mapping")
lua require("window")

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  lua vim.defer_fn(require("galaxyline").disable_galaxyline, 10)
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  lua require("galaxyline").galaxyline_augroup()
endfunction

autocmd! User GoyoEnter call s:goyo_enter()
autocmd! User GoyoLeave call s:goyo_leave()
