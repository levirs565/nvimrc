if vim.o.shell == "cmd.exe" then
  vim.g.floaterm_shell = "pwsh"
else
  vim.g.floaterm_shell = "bash"
end

vim.g.floaterm_width = 0.9
vim.g.floaterm_height = 0.9
vim.g.floaterm_autohide = 2
vim.g.floaterm_keymap_toggle = '<A-t>'
vim.g.floaterm_keymap_new = "<A-T>"
