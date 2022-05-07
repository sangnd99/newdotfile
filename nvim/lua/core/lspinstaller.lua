local lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("lsp").on_attach,
	}

	-- (optional) Customize the options passed to the server
	-- cssls
	if server.name == "cssls" then
		opts.capabilities = capabilities
	end
	-- html
	if server.name == "html" then
		opts.capabilities = capabilities
	end

	--tsserver
	if server.name == "tsserver" then
		opts.root_dir = function()
			return vim.loop.cwd()
		end
	end

	--emmetls
	if server.name == "emmet_ls" then
		local emmet_ls_opts = require("lsp.settings.emmet-ls")
		opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	end

	--jsonls
	if server.name == "jsonls" then
		local jsonls_opts = require("lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	-- Tailwindcss
	if server.name == "tailwindcss" then
		opts.settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						"tw`([^`]*)", -- tw`...`
						'tw="([^"]*)', -- <div tw="..." />
						'tw={"([^"}]*)', -- <div tw={"..."} />
						"tw\\.\\w+`([^`]*)", -- tw.xxx`...`
						"tw\\(.*?\\)`([^`]*)",
					},
				},
			},
		}
	end

	-- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
	server:setup(opts)
	vim.cmd([[ do User LspAttachBuffers ]])
end)
