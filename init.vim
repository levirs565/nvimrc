if exists('+termguicolors')
  set termguicolors
endif

filetype plugin on
syntax on
lua require("setting")

let g:srootdir=expand("<sfile>:p:h")

call plug#begin(g:srootdir . '/plugged')
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-gitgutter'
Plug 'kassio/neoterm'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'sheerun/vim-polyglot'
Plug 'romgrk/lib.kom'
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
call plug#end()

colorscheme gruvbox
if filereadable(fnamemodify("~/.nvim_color", ":p"))
  source ~/.nvim_color
endif

lua require("plugins.comment")
lua require("plugins.tree")
lua require("plugins.telescope")
lua require("plugins.compe")
lua require("plugins.lspconfig")
lua require("plugins.lspsaga")
lua require("plugins.dashboard")
lua require("mapping")
lua require("window")
