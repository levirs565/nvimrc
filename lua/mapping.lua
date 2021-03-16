local set = vim.api.nvim_set_keymap

set("n", "<A-l>", "<CMD>BufferNext<CR>", {noremap = true, silent = true})
set("n", "<A-h>", "<CMD>BufferPrevious<CR>", {noremap = true, silent = true})
set("n", "<Leader>q", "<CMD>BufferClose<CR>", {noremap = true, silent = true})
set("n", "<Leader>qo", "<CMD>BufferCloseAllButCurrent<CR>", {noremap = true, silent = true})
set("n", "<Leader>qq", "<CMD>bufdo BufferClose<CR>", {noremap = true, silent = true})
set("n", "<Leader>qa", "<CMD>bufdo! BufferClose!<CR>", {noremap = true})

local function map_window(key, fn_name) 
  set("n", key, "<CMD>lua require('window')." .. fn_name .. "()<CR>", {})
end

map_window("<A-1>", "toggle_tree")
map_window("<A-t>", "toggle_terminal")
map_window("<A-k>", "toggle_git")

set("t", "<Esc>", "<C-\\><C-N>", {noremap = true})
