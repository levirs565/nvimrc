local gruvbox = require("gruvbox")
local line = require("galaxyline")
local fileinfo = require("galaxyline.provider_fileinfo")
local buffer = require("galaxyline.provider_buffer")
local condition = require("galaxyline.condition")

local function get_color(name)
  return gruvbox["Gruvbox" .. name].fg
end

local mode_alias = {
  n = "NORMAL",
  i = "INSERT",
  t = "TERMINAL",
  v = "VISUAL",
  V = "VISUAL-LINE",
  [""] = "VISUAL-BLOCK",
  c = "COMMAND"
}
local mode_color = {
  n = "Yellow",
  i = "Blue",
  t = "Blue",
  v = "Orange",
  V = "Orange",
  [""] = "Orange",
  c = "Gray"
}

line.section.left = {
  {
    Mode = {
      provider = function () 
        local mode = vim.fn.mode()
        local color = mode_color[mode]
        local text = mode_alias[mode]
        if color == nil then
          color = "Yellow"
        end
        if text == nil then
          text = "UNKNOWN:" .. mode
        end
        vim.api.nvim_command('hi GalaxyMode guibg='..get_color(color))
        return "  " .. text .. " "
      end,
      highlight = {
        function () 
          return get_color("Bg0")
        end
      }
    }
  },
  {
    FileName = {
      provider = function ()
        return "  " .. fileinfo.get_current_file_name() .. " "
      end,
      condition = condition.buffer_not_empty
    }
  },
  {
    Blank = {
      provider = function ()
        return " "
      end
    }
  }
}

line.section.right = {
  {
    LineColumn = {
      provider = function ()
        return string.format("  %s ", fileinfo.line_column())
      end
    }
  },
  {
    LinePercent = {
      provider = fileinfo.current_line_percent
    }
  }
}

line.short_line_list = {"dashboard", "NvimTree", "fugitive", "gitcommit"}
line.section.short_line_left = {
  {
    BufferIcon = {
      provider = buffer.get_buffer_type_icon
    }
  },
  {
    BufferType = {
      provider = buffer.get_buffer_filetype
    }
  }
}
