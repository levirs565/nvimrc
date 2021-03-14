local set = vim.api.nvim_set_keymap

set("n", "<A-l>", "<CMD>BufferNext<CR>", {noremap = true, silent = true})
set("n", "<A-h>", "<CMD>BufferPrevious<CR>", {noremap = true, silent = true})
set("n", "<Leader>q", "<CMD>BufferClose<CR>", {noremap = true, silent = true})
set("n", "<Leader>qo", "<CMD>BufferCloseAllButCurrent<CR>", {noremap = true, silent = true})
set("n", "<Leader>qq", "<CMD>bufdo BufferClose<CR>", {noremap = true, silent = true})
set("n", "<Leader>qa", "<CMD>bufdo! BufferClose!<CR>", {noremap = true})
