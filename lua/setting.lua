vim.o.number = true
vim.o.compatible = false
vim.o.linebreak = true
vim.o.autoread = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.title = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.updatetime = 1000
vim.o.completeopt = "menu,menuone,preview,noinsert,noselect"
vim.o.relativenumber = true
vim.o.mouse = "a"

if not vim.o.shell == 'cmd.exe' then
  vim.o.shcf = "-c"
  vim.o.sxq = ""
  vim.o.ssl = true
end
