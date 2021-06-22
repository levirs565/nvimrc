local lspconfig = require("lspconfig")
local lsp_signature = require("lsp_signature")
local mapping = require("mapping")

local function on_attach(client, bufnr)
  lsp_signature.on_attach()
  mapping.apply_lsp(bufnr)
end

lspconfig.hls.setup {
  on_attach = on_attach
}
lspconfig.tsserver.setup {
  on_attach = on_attach
}

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('data')..'/lsp/sumneko_lua'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  on_attach = on_attach;
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local configs = require("lspconfig/configs")
local utils = require("lspconfig/util")

configs["kasten_note"] = {
  default_config = {
    cmd = {"kasten-lsp.cmd", "--stdio"};
    filetypes = { "markdown" };
    root_dir = function(fname)
      return utils.root_pattern("kasten.yml", "kasten.yaml")(fname)
    end
  };
}

configs["kasten_note"].setup {
  on_attach = function (client, bufnr) 
    vim.api.nvim_command("setlocal spell spelllang=id")
  end
}
