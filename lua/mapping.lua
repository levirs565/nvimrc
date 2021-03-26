local set = vim.api.nvim_set_keymap
local opts = {
  noremap = true,
  -- silent = true
}

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

local function map_telescope(key, fn_name)
  set("n", key, "<CMD>lua require('telescope.builtin')." .. fn_name .. "()<CR>", {})
end

map_telescope("<A-n>", "find_files")
map_telescope("<A-f>", "live_grep")
set("n", "<A-p>", "<CMD>lua require('telescope').extensions.project.project()<CR>", opts)


local function map_lsp(key, fn_name)
  set("n", key, "<CMD>lua vim.lsp." .. fn_name .. "()<CR>", opts)
end

local function map_lsp_saga(key, module, fn_name)
  set("n", key, "<CMD>lua require('lspsaga." .. module .. "')." .. fn_name .. "()<CR>", opts)
end

local function map_lsp_buf(key, fn_name)
  map_lsp(key, "buf." .. fn_name)
end

local function map_lsp_diag(key, fn_name)
  map_lsp_saga(key, "diagnostic", fn_name)
end

map_lsp_buf("gd", "type_definition")
map_lsp_buf("gD", "definition")
map_lsp_buf("gi", "implementation")
map_lsp_buf("gr", "references")
map_lsp_saga("K", "hover", "render_hover_doc")
map_lsp_saga("<C-k>", "signaturehelp", "signature_help")
map_lsp_saga("<leader>rn", "rename" , "rename")
map_lsp_buf("<leader>f", "formatting")
map_lsp_diag("<leader>d", "show_line_diagnostics")
map_lsp("<leader>ld", "diagnostic.set_loclist")
map_lsp_diag("[d", "lsp_jump_diagnostic_prev")
map_lsp_diag("]d", "lsp_jump_diagnostic_next")
