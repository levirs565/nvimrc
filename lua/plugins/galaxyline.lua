local line = require("galaxyline")
local fileinfo = require("galaxyline.provider_fileinfo")
local buffer = require("galaxyline.provider_buffer")
local condition = require("galaxyline.condition")

local function get_color(name)
  return require("gruvbox")["Gruvbox" .. name].fg
end

local function call_get_color(name)
  return function () 
    return get_color(name) 
  end
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
        end,
        "#FFFFFF",
        "bold"
      }
    }
  },
  {
    FileIcon = {
      provider = function ()
        return "  " .. fileinfo.get_file_icon()
      end,
      highlight = {fileinfo.get_file_icon_color, call_get_color("Bg1")},
      condition = condition.buffer_not_empty
    }
  },
  {
    FileName = {
      provider = fileinfo.get_current_file_name,
      condition = condition.buffer_not_empty,
      highlight = {call_get_color("Fg1"), call_get_color("Bg1")},
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
        return string.format("   %s ", fileinfo.line_column())
      end,
      highlight = {call_get_color("Fg1"), call_get_color("Bg1")},
    }
  },
  {
    LinePercent = {
      provider = fileinfo.current_line_percent,
      highlight = {call_get_color("Fg1"), call_get_color("Bg1")},
    }
  }
}

local function condition_is_special_ft()
  return vim.fn.index(line.short_line_list, vim.bo.filetype) ~= -1
end


local function condition_is_not_special_ft()
  return not condition_is_special_ft()
end
  

line.short_line_list = {"dashboard", "NvimTree", "fugitive", "gitcommit"}
line.section.short_line_left = {
  {
    BufferIcon = {
      provider = buffer.get_buffer_type_icon,
      highlight = {call_get_color("Fg1"), call_get_color("Bg1")},
      condition = condition_is_special_ft
    }
  },
  {
    BufferType = {
      provider = buffer.get_buffer_filetype,
      highlight = {call_get_color("Fg1"), call_get_color("Bg1")},
      condition = condition_is_special_ft
    }
  },
  {
    InactiveFileIcon = {
      provider = function ()
        return "  " .. fileinfo.get_file_icon()
      end,
      highlight = {call_get_color("Fg1"), call_get_color("Bg1")},
      condition = condition_is_not_special_ft
    }
  },
  {
    InactiveFileName = {
      provider = fileinfo.get_current_file_name,
      condition = condition_is_not_special_ft,
      highlight = {call_get_color("Fg1"), call_get_color("Bg1")},
    }
  },
}
