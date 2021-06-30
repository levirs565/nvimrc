local function prettier()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", '"' .. vim.api.nvim_buf_get_name(0) .. '"', "--single-quote" },
    stdin = true,
  }
end

local function stylua()
  return {
    exe = "stylua",
    args = { "-s", "--stdin-filepath", '"' .. vim.api.nvim_buf_get_name(0) .. '"', "-" },
    stdin = true,
  }
end

require("formatter").setup({
  logging = true,
  filetype = {
    markdown = {
      prettier,
    },
    vimwiki = {
      prettier,
    },
    typescript = {
      prettier,
    },
    javascript = {
      prettier,
    },
    lua = {
      stylua,
    },
  },
})
