return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
				},
			})

			vim.keymap.set({ "n", "v" }, "<leader>f", function()
				vim.lsp.buf.format({
					filter = function(client)
						return client.name == "null-ls" or client.name == "none-ls"
					end,
					async = true,
				})
			end, { desc = "Formatting" })
		end,
	},
}
