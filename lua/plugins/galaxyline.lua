local gruvbox = require("gruvbox")
local line = require("galaxyline")
local fileinfo = require("galaxyline.provider_fileinfo")
local buffer = require("galaxyline.provider_buffer")
local condition = require("galaxyline.condition")

local function get_color(name)
  return gruvbox["Gruvbox" .. name].fg
end

line.section.left = {
  {
    FileName = {
      provider = fileinfo.get_current_file_name,
      condition = condition.buffer_not_empty
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
