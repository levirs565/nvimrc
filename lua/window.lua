local tree = require("nvim-tree")
local M = {}

local function smart_toggle(filetype, open, close)
  if vim.bo.filetype == filetype then
    close()
    return
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    
    if vim.bo[buf].filetype == filetype then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  
  open()
end

function M.toggle_tree()
  smart_toggle("NvimTree", tree.open, tree.close)
end

function M.toggle_terminal()
  smart_toggle(
    "neoterm",
    function() vim.api.nvim_command("Topen") end,
    function() vim.api.nvim_command("Tclose") end
  )
end

function M.toggle_git()
  smart_toggle(
    "fugitive",
    function() vim.api.nvim_command("Git") end,
    function() vim.api.nvim_command("wincmd q") end
  )
end

function M.configure_fugitive_window()
  if not vim.b.win_configured then
    vim.api.nvim_command("wincmd L | vertical resize 31" )
    vim.b.win_configured = true
  end
end

return M
