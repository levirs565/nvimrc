local tree = require("nvim-tree")
local M = {
  sidebar_width = 35
}

local buffer_data = {
  fugitive = {
    open = function() vim.api.nvim_command("Git") end,
    close = function(win) vim.api.nvim_win_close(win, false) end
  },
  NvimTree = {
    open = tree.open,
    close = function(win) tree.close() end
  }
}

local function find_window(filetype) 
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    
    if vim.bo[buf].filetype == filetype then
      return win
    end
  end
  return nil
end

local function smart_toggle(filetype)
  if vim.bo.filetype == filetype then
    buffer_data[filetype].close()
    return
  end

  local win = find_window(filetype)
  if win ~= nil then
    vim.api.nvim_set_current_win(win)
    return
  end

  for ft, data in pairs(buffer_data) do
    if ft ~= filetype then
      local win = find_window(ft)
      if win ~= nil then
        data.close(win)
      end
    end
  end
  
  buffer_data[filetype].open()
end

function M.toggle_tree()
  smart_toggle("NvimTree")
end

function M.toggle_git()
  smart_toggle("fugitive")
end

function M.configure_fugitive_window()
  if not vim.b.win_configured then
    vim.api.nvim_command("wincmd H | vertical resize " .. M.sidebar_width )
    vim.b.win_configured = true
  end
end

return M
