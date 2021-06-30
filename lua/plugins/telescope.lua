local telescope = require("telescope")

telescope.setup {
  defaults = {
    borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
  }
}


require'telescope'.load_extension('project')
