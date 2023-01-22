local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {

		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs, -- show signs
		},
		update_in_insert = true,
		underline = true,
		serverity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "J", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format { async = true } <cr>", opts)
	keymap(bufnr, "n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opts)

	-- Code action
	keymap(bufnr, "n", "<leader>a", "<cmd>Lspsaga code_action<CR>", opts)
	keymap(bufnr, "v", "<leader>a", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)

	-- Hover doc
	keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	-- Signature help
	keymap(bufnr, "n", "gs", "<Cmd>Lspsaga signature_help<CR>", opts)
	-- Rename
	keymap(bufnr, "n", "gr", "<cmd>Lspsaga rename<CR>", opts)
	-- Preview definition
	keymap(bufnr, "n", "gD", "<cmd>Lspsaga preview_definition<CR>", opts)
	-- Jump to error
	keymap(bufnr, "n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	keymap(bufnr, "n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "html" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "sumneko_lua" then
		client.server_capabilities.document_formatting = false
	end

	if client.name == "gopls" then
		client.server_capabilities.document_formatting = false
	end

	lsp_keymaps(bufnr)
end

return M
