local lspconfig = require("lspconfig")
local lsp_signature = require("lsp_signature")

local function on_attach()
  lsp_signature.on_attach()
end

lspconfig.hls.setup {
  on_attach = on_attach
}
lspconfig.tsserver.setup {
  on_attach = on_attach
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

configs["kasten_note"].setup {}
