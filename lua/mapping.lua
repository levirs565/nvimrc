local set = vim.api.nvim_set_keymap
local opts = {
  noremap = true,
  silent = true
}

local function disable_key(key)
  set("n", key, "<Nop>", opts)
end

disable_key("<Up>")
disable_key("<Left>")
disable_key("<Right>")
disable_key("<Down>")

local function map_buf_nav(key, buffer, floaterm)
  local cmd = string.format(
    [[<CMD>if &filetype == "floaterm" | exe "Floaterm%s" | else | exe "Buffer%s" | endif<CR>]],
    floaterm, buffer)
  set("n", key, cmd, opts)
  set("t", key, "<C-\\><C-n>:Floaterm" .. floaterm .. "<CR>", opts)
end
map_buf_nav("<A-l>", "Next", "Next")
map_buf_nav("<A-h>", "Previous", "Prev")

local function map_cmd(mode, key, cmd, opts)
  set(mode, key, "<CMD>" .. cmd .. "<CR>", opts)
end

map_cmd("n", "<Leader>q", "BufferClose", opts)
map_cmd("n", "<Leader>qo", "BufferCloseAllButCurrent", opts)
map_cmd("n", "<Leader>qq", "bufdo BufferClose", opts)
map_cmd("n", "<Leader>qa", "bufdo! BufferClose!", opts)

map_cmd("n", "<Leader>w", "write", opts)
map_cmd("n", "<Leader>f", "FormatWrite", opts)

map_cmd("n", "<Leader>lt", "TodoTrouble", opts)
map_cmd("n", "<Leader>ld", "TroubleToggle lsp_document_diagnostics", opts)
map_cmd("n", "<Leader>lD", "TroubleToggle lsp_workspace_diagnostics", opts)

vim.g.is_fullscreen = 0
set("n", "<Leader>mf", 
  [[<CMD>let g:is_fullscreen = !g:is_fullscreen | call GuiWindowFullScreen(g:is_fullscreen)<CR>]],
  opts)
set("n", "<Leader>mz", "<CMD>Goyo<CR>", opts)

local function map_module(mode, key, module, call, opts)
  map_cmd(mode, key, "lua require('" .. module .. "')." .. call, opts)
end

local function map_window(key, fn_name) 
  map_module("n", key, 'window', fn_name, opts)
end

map_window("<A-1>", "toggle_tree()")
map_window("<A-k>", "toggle_git()")
local gitui_cmd = "cmd/c \"set \"TERM=\" && cmd /c gitui\""
map_cmd(
  "n", "<A-K>", 
  "FloatermNew --name=gitui --title=GitUI --disposable --autoclose=1 " .. gitui_cmd,
  opts
)

set("t", "<Esc>", "<C-\\><C-N>", opts)

local function map_telescope(key, fn_name)
  map_module("n", key, 'telescope.builtin', fn_name, opts)
end

map_telescope("<A-n>", "find_files()")
map_telescope("<A-f>", "live_grep()")
map_module("n", "<A-p>", 'telescope', "extensions.project.project()", opts)


local function map_lsp(key, fn_name)
  map_cmd("n", key, "lua vim.lsp." .. fn_name, opts)
end

local function map_lsp_saga(key, module, fn_name)
  map_module("n", key, "lspsaga." .. module, fn_name, opts)
end

local function map_lsp_buf(key, fn_name)
  map_lsp(key, "buf." .. fn_name)
end

local function map_lsp_diag(key, fn_name)
  map_lsp_saga(key, "diagnostic", fn_name)
end

map_lsp_buf("gd", "definition()")
map_lsp_buf("gD", "type_definition()")
map_lsp_buf("gi", "implementation()")
map_cmd("n", "gr", "TroubleToggle lsp_references", opts)
map_lsp_saga("K", "hover", "render_hover_doc()")
map_lsp_saga("<C-k>", "signaturehelp", "signature_help()")
map_lsp_saga("<leader>rn", "rename" , "rename()")
map_lsp_saga("<leader>ca", "codeaction", "code_action()") 
set("v", "<leader>ca", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
map_lsp_diag("<leader>d", "show_line_diagnostics()")
map_lsp_diag("[d", "lsp_jump_diagnostic_prev()")
map_lsp_diag("]d", "lsp_jump_diagnostic_next()")
