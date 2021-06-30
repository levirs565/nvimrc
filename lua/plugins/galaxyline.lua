local line = require("galaxyline")
local fileinfo = require("galaxyline.provider_fileinfo")
local buffer = require("galaxyline.provider_buffer")
local condition = require("galaxyline.condition")

-- local config = require("tokyonight.config")
-- local colors = require("tokyonight.colors").setup(config)

local mode_alias = {
  n = "NORMAL",
  i = "INSERT",
  t = "TERMINAL",
  v = "VISUAL",
  V = "VISUAL-LINE",
  [""] = "VISUAL-BLOCK",
  c = "COMMAND",
}
local mode_color = {}
local color = {}

local function call_get_color(name)
  return function()
    return color[name]
  end
end

local function update_color()
  if vim.g.colors_name == "gruvbox" then
    local gruvbox = require("gruvbox")
    mode_color.n = gruvbox["GruvboxYellow"].fg
    mode_color.i = gruvbox["GruvboxBlue"].fg
    mode_color.t = gruvbox["GruvboxBlue"].fg
    mode_color.v = gruvbox["GruvboxOrange"].fg
    mode_color.V = gruvbox["GruvboxOrange"].fg
    mode_color[""] = gruvbox["GruvboxOrange"].fg
    mode_color.c = gruvbox["GruvboxGray"].fg
    color.mode_fg = gruvbox["GruvboxBg0"].fg
    color.bg_1 = gruvbox["GruvboxBg2"].fg
    color.fg_1 = gruvbox["GruvboxFg2"].fg
    color.bg_2 = gruvbox["GruvboxBg1"].fg
    color.fg_2 = gruvbox["GruvboxFg1"].fg
  end
  if vim.g.colors_name == "tokyonight" then
    local config = require("tokyonight.config")
    local colors = require("tokyonight.colors").setup(config)
    local util = require("tokyonight.util")
    mode_color.n = util.getColor(colors.blue)
    mode_color.i = util.getColor(colors.green)
    mode_color.t = util.getColor(colors.green)
    mode_color.v = util.getColor(colors.magenta)
    mode_color.V = util.getColor(colors.magenta)
    mode_color[""] = util.getColor(colors.magenta)
    mode_color.c = util.getColor(colors.yellow)
    color.mode_fg = util.getColor(colors.black)
    color.bg_1 = util.getColor(colors.bg_search)
    color.fg_1 = util.getColor(colors.black)
    color.bg_2 = util.getColor(colors.bg_statusline)
    color.fg_2 = util.getColor(colors.fg_gutter)
  end
end

line.section.left = {
  {
    Mode = {
      provider = function()
        local mode = vim.fn.mode()
        local color = mode_color[mode]
        local text = mode_alias[mode]
        if color == nil then
          color = mode_color.n
        end
        if text == nil then
          text = "UNKNOWN:" .. mode
        end
        vim.api.nvim_command("hi GalaxyMode guibg=" .. color)
        return "  " .. text .. " "
      end,
      highlight = {
        call_get_color("mode_fg"), -- Unused
        "#FFFFFF",
        "bold",
      },
    },
  },
  {
    FileIcon = {
      provider = function()
        return "  " .. fileinfo.get_file_icon()
      end,
      highlight = { call_get_color("fg_1"), call_get_color("bg_1")},
      condition = condition.buffer_not_empty,
    },
  },
  {
    FileName = {
      provider = fileinfo.get_current_file_name,
      condition = condition.buffer_not_empty,
      highlight = { call_get_color("fg_1"), call_get_color("bg_1") },
    },
  },
  {
    Blank = {
      provider = function()
        return " "
      end,
      highlight = { call_get_color("fg_2"), call_get_color("bg_2") },
    },
  },
}

line.section.right = {
  {
    LineColumn = {
      provider = function()
        return string.format("   %s ", fileinfo.line_column())
      end,
      highlight = { call_get_color("fg_1"), call_get_color("bg_1") },
    },
  },
  {
    LinePercent = {
      provider = function()
        return "  " .. fileinfo.current_line_percent() .. " "
      end,
      highlight = "GalaxyMode",
    },
  },
}

local function condition_is_special_ft()
  return vim.fn.index(line.short_line_list, vim.bo.filetype) ~= -1
end

local function condition_is_not_special_ft()
  return not condition_is_special_ft()
end

line.short_line_list = { "dashboard", "NvimTree", "NeogitStatus", "gitcommit" }
line.section.short_line_left = {
  {
    BufferIcon = {
      provider = function()
        local icon = buffer.get_buffer_type_icon()
        if icon == nil then
          icon = ""
        end
        return " " .. icon
      end,
      highlight = { call_get_color("fg_1"), call_get_color("bg_1") },
      condition = condition_is_special_ft,
    },
  },
  {
    BufferType = {
      provider = function()
        return buffer.get_buffer_filetype() .. " "
      end,
      highlight = { call_get_color("fg_1"), call_get_color("bg_1") },
      condition = condition_is_special_ft,
    },
  },
  {
    InactiveFileIcon = {
      provider = function()
        return "  " .. fileinfo.get_file_icon()
      end,
      highlight = { call_get_color("fg_1"), call_get_color("bg_1") },
      condition = condition_is_not_special_ft,
    },
  },
  {
    InactiveFileName = {
      provider = fileinfo.get_current_file_name,
      condition = condition_is_not_special_ft,
      highlight = { call_get_color("fg_1"), call_get_color("bg_1") },
    },
  },
  {
    InactiveBlank = {
      provider = function()
        return " "
      end,
      highlight = { call_get_color("fg_2"), call_get_color("bg_2") },
    },
  },
}

return {
  update_color = update_color,
}
