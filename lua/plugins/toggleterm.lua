require("toggleterm").setup{
  size = 10,
  open_mapping = [[<A-t>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_terminals = false,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = "horizontal",
  close_on_exit = true,
  shell = "pwsh",
}
