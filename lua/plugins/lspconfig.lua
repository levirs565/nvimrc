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
