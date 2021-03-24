local kmap = vim.api.nvim_set_keymap

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'disable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    nvim_lsp = true;
  };
}

kmap('i', '<C-Space>', 'compe#complete()', { expr = true })
