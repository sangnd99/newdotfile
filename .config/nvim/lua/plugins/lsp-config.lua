-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ buffer = bufnr })
	end
end

return {
	{ -- Lsp configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ -- LSP manager
				"williamboman/mason.nvim",
				opts = {},
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							winblend = 0,
							x_padding = 0,
						},
					},
				},
			},
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(attach_event)
					local client = vim.lsp.get_client_by_id(attach_event.data.client_id)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = attach_event.buf, desc = "LSP: " .. desc })
					end
					map("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
					map("gD", vim.lsp.buf.declaration, "[G]o to [D]eclaration")
					map("]d", vim.diagnostic.goto_next, "Goto next [D]iagnostics")
					map("[d", vim.diagnostic.goto_prev, "Goto prev [D]iagnostics")
					map("<C-j>", vim.diagnostic.open_float, "Open diagnostic in float window")
					map("<leader>rn", vim.lsp.buf.rename, "[R]ename")
					map("<leader>ld", vim.diagnostic.setqflist, "[L]ist [D]iagnostics")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Avoiding LSP formatting conflicts
					if client then
						on_attach(client, attach_event.buf)
					end
				end,
			})

			vim.diagnostic.config({
				update_in_insert = false,
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
			})

			-- Set border for textDocument/hover
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "rounded",
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			})

			-- Language server
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

			local servers = {
				cssls = {},
				html = {},
				ts_ls = {
					single_file_support = false,
					commands = {
						OrganizeImports = {
							function()
								local params = {
									command = "_typescript.organizeImports",
									arguments = { vim.api.nvim_buf_get_name(0) },
									title = "",
								}
								vim.lsp.buf.execute_command(params)
							end,
							description = "Organize Imports",
						},
					},
				},
				eslint = {
					settings = {
						format = false,
						workingDirectories = { mode = "auto" },
					},
					flags = {
						allow_incremental_sync = false,
						debounce_text_changes = 1000,
					},
				},
				jsonls = {},
				bashls = {},
				tailwindcss = {
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								},
							},
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
