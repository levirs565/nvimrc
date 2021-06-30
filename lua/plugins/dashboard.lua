local function fill(str)
  return string.format("%-20s", str)
end

vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_header = {
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}
vim.g.dashboard_custom_section = {
  marked_projects = {
    description = { fill(" Marked Projects") },
    command = "lua require('telescope').extensions.project.project()",
  },
  new_file = {
    description = { fill(" New File") },
    command = "DashboardNewFile",
  },
}
