local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

lsp_installer.on_server_ready(function(server)
	opts = {
		on_attach = require("lsp.lsp-handlers").on_attach,
		capabilities = require("lsp.lsp-handlers").capabilities,
	}

	--tsserver
	if server.name == "tsserver" then
		opts.root_dir = function()
			return vim.loop.cwd()
		end
	end

	--emmetls
	if server.name == "emmet_ls" then
		local emmet_ls_opts = require("lsp.settings.emmetls")
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
