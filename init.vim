if exists('+termguicolors')
  set termguicolors
endif

filetype plugin on
syntax on
lua require("setting")

let g:srootdir=expand("<sfile>:p:h")

call plug#begin(g:srootdir . '/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'vim-pandoc/vim-pandoc-syntax'
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
Plug 'junegunn/goyo.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'folke/trouble.nvim'
Plug 'folke/todo-comments.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'TimUntersberger/neogit'
Plug 'lewis6991/gitsigns.nvim'
" TODO: Use 'iamcco/markdown-preview.nvim', see https://github.com/iamcco/markdown-preview.nvim/pull/342
Plug 'GregBowyer/markdown-preview.nvim', { 'branch': 'katex', 'do': 'cd app && pnpm install --shamefully-hoist'  }
Plug 'folke/tokyonight.nvim'
Plug 'akinsho/nvim-toggleterm.lua'
" Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'windwp/nvim-ts-autotag'
call plug#end()

lua require("plugins.comment")
lua require("plugins.tree")
lua require("plugins.telescope")
lua require("plugins.compe")
lua require("plugins.lspconfig")
lua require("plugins.lspsaga")
lua require("plugins.dashboard")
lua require("plugins.galaxyline")
lua require("plugins.trouble")
lua require("plugins.todo")
lua require("plugins.format")
lua require("plugins.signature")
lua require("plugins.neogit")
lua require("plugins.gitsigns")
lua require("plugins.markdown")
lua require("plugins.toggleterm")
lua require("plugins.treesitter")
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

autocmd! ColorScheme * lua require("plugins.galaxyline").update_color() 

if filereadable(fnamemodify("~/.nvim_color", ":p"))
  source ~/.nvim_color
endif
colorscheme tokyonight
