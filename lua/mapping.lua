local set = vim.api.nvim_set_keymap
local opts = {
  -- noremap = true,
  silent = true
}

local M = {}
local gitui_cmd = "cmd/c \"set \"TERM=\" && cmd /c gitui\""

vim.g.is_fullscreen = 0

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
  { "n", "<A-g>", lua([[require('window').toggle_git()]])},
  { "n", "<A-e>", lua([[require('window').toggle_tree()]])},

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
  { 
    "n", 
    "<A-K>", 
    cmd("FloatermNew --name=gitui --title=GitUI --disposable --autoclose=1 " .. gitui_cmd)
  },

  { "n", "<Leader>mp", cmd("MarkdownPreviewToggle") },
  { "n", "<Leader>mz", cmd("Goyo") },
  { "n", 
    "<Leader>mf", 
    [[<CMD>let g:is_fullscreen = !g:is_fullscreen | call GuiWindowFullScreen(g:is_fullscreen)<CR>]]
  },
  { "n", "<Leader>ni", cmd("cd ~/VimWiki | e index.md") },
}

local floaterm_mapping = {
  { "n", "<A-h>", cmd("FloatermPrev") },
  { "t", "<A-h>", "<C-\\><C-n>:FloatermPrev<CR>" },
  { "n", "<A-l>", cmd("FloatermNext") },
  { "t", "<A-l>", "<C-\\><C-n>:FloatermNext<CR>" },
}

local lsp_mapping = {
  { "n", "gd", lua("vim.lsp.buf.definition()") },
  { "n", "gD", lua("vim.lsp.buf.type_definition()") },
  { "n", "gi", lua("vim.lsp.buf.implementation()") },
  { "n", "gr", cmd("TroubleToggle lsp_references") },

  { "n", "K", lua([[require("lspsaga.hover").render_hover_doc()]]) },
  { "n", "<C-k>", lua([[require("lspsaga.signaturehelp").signature_help()]]) },
  { "n", "<leader>rn", lua([[require("lspsaga.rename").rename()]]) },
  { "n", "<leader>ca", lua([[require("lspsaga.codeaction").code_action()]]) },
  { "v", "<leader>ca", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>"},
  { "n", "<leader>d", lua([[require("lspsaga.diagnostic").show_line_diagnostics()]]) },
  { "n", "[d", lua([[require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()]]) },
  { "n", "]d", lua([[require("lspsaga.diagnostic").lsp_jump_diagnostic_next()]]) },
}

for _, info in ipairs(mapping) do
  set(info[1], info[2], info[3], opts)
end

local function apply_to_buffer(mapping, bufnr)
  for _, info in ipairs(mapping) do
    vim.api.nvim_buf_set_keymap(bufnr, info[1], info[2], info[3], opts)
  end
end

M.apply_floaterm = function ()
  local buf = vim.api.nvim_get_current_buf()
  apply_to_buffer(floaterm_mapping, buf)
end

M.apply_lsp = function (bufnr)
  apply_to_buffer(lsp_mapping, bufnr)
end

return M
