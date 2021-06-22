local set = vim.api.nvim_set_keymap
local opts = {
  -- noremap = true,
  silent = true
}

local M = {}

local function cmd(str)
  return "<CMD>" .. str .. "<CR>"
end

local function lua(str)
  return cmd("lua " .. str)
end

local mapping = {
  -- Disabled keys
  { "n", "<Up>", "<Nop>"},
  { "n", "<Left>", "<Nop>"},
  { "n", "<Right>", "<Nop>"},
  { "n", "<Down>", "<Nop>"},

  -- Buffer close
  { "n", "<Leader>xx", cmd("BufferClose") },
  { "n", "<Leader>xo", cmd("BufferCloseAllButCurrent") },
  { "n", "<Leader>xa", cmd("bufdo BufferClose") },
  { "n", "<Leader>xA", cmd("bufdo! BufferClose!") },

  -- Buffer write
  { "n", "<Leader>w", cmd("write") },
  { "n", "<Leader>f", cmd("FormatWrite") },

  -- Buffer navigation
  { "n", "<A-h>", cmd("BufferPrevious") },
  { "n", "<A-l>", cmd("BufferNext")},

  -- Window
  { "n", "<A-1>", lua([[require('window').toggle_tree()]])},
  { "n", "<A-k>", lua([[require('window').toggle_git()]])},

  -- List
  { "n", "<Leader>lt", cmd("TodoTrouble") },
  { "n", "<Leader>ld", cmd("TroubleToggle lsp_document_diagnostics") },
  { "n", "<Leader>lD", cmd("TroubleToggle lsp_workspace_diagnostics") },

  -- Fuzzy finder
  { "n", "<A-n>", cmd("Telescope find_files") },
  { "n", "<A-f>", cmd("Telescope live_grep") },
  { "n", "<A-p>", cmd("Telescope project") },

  -- Terminal
  { "t", "<Esc>", "<C-\\><C-N>" },

  { "n", "<Leader>mp", cmd("MarkdownPreviewToggle") },
  { "n", "<Leader>mz", cmd("Goyo") },
  { "n", "<Leader>ni", cmd("cd ~/VimWiki | e index.md") },

  -- LSP Buf
  { "n", "gd", lua("vim.lsp.buf.definition()") },
  { "n", "gD", lua("vim.lsp.buf.type_definition()") },
  { "n", "gi", lua("vim.lsp.buf.implementation()") },
  { "n", "gr", cmd("TroubleToggle lsp_references") }
}

local floaterm_mapping = {
  { "n", "<A-h>", cmd("FloatermPrev") },
  { "t", "<A-h>", "<C-\\><C-n>:FloatermPrev<CR>" },
  { "n", "<A-l>", cmd("FloatermNext") },
  { "t", "<A-l>", "<C-\\><C-n>:FloatermNext<CR>" },
}

for _, info in ipairs(mapping) do
  set(info[1], info[2], info[3], opts)
end

M.apply_floaterm = function ()
  local buf = vim.api.nvim_get_current_buf()
  for _, info in ipairs(floaterm_mapping) do
    vim.api.nvim_buf_set_keymap(buf, info[1], info[2], info[3], opts)
  end
end


local function map_cmd(mode, key, cmd, opts)
  set(mode, key, "<CMD>" .. cmd .. "<CR>", opts)
end

vim.g.is_fullscreen = 0
set("n", "<Leader>mf", 
  [[<CMD>let g:is_fullscreen = !g:is_fullscreen | call GuiWindowFullScreen(g:is_fullscreen)<CR>]],
  opts)

local function map_module(mode, key, module, call, opts)
  map_cmd(mode, key, "lua require('" .. module .. "')." .. call, opts)
end

local gitui_cmd = "cmd/c \"set \"TERM=\" && cmd /c gitui\""
map_cmd(
  "n", "<A-K>", 
  "FloatermNew --name=gitui --title=GitUI --disposable --autoclose=1 " .. gitui_cmd,
  opts
)

local function map_telescope(key, fn_name)
  map_module("n", key, 'telescope.builtin', fn_name, opts)
end

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

map_lsp_saga("K", "hover", "render_hover_doc()")
map_lsp_saga("<C-k>", "signaturehelp", "signature_help()")
map_lsp_saga("<leader>rn", "rename" , "rename()")
map_lsp_saga("<leader>ca", "codeaction", "code_action()") 
set("v", "<leader>ca", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
map_lsp_diag("<leader>d", "show_line_diagnostics()")
map_lsp_diag("[d", "lsp_jump_diagnostic_prev()")
map_lsp_diag("]d", "lsp_jump_diagnostic_next()")

return M
