local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

lspconfig.jsonls.setup {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
    },
  },
}

require("lsp.lsp-mason")
require("lsp.lsp-handlers").setup()
require("lsp.null-ls")
