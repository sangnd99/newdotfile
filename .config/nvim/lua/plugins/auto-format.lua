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
				local mode = vim.api.nvim_get_mode().mode
				if mode == "v" or mode == "V" or mode == "<C-v>" then
					-- Visual mode: format only the selected range
					local start_pos = vim.api.nvim_buf_get_mark(0, "<")
					local end_pos = vim.api.nvim_buf_get_mark(0, ">")
					vim.lsp.buf.format({
						range = {
							["start"] = { start_pos[1], start_pos[2] },
							["end"] = { end_pos[1], end_pos[2] },
						},
						filter = function(client)
							return client.name == "null-ls" or client.name == "none-ls"
						end,
						async = true,
					})
				else
					-- Normal mode: format the whole file
					vim.lsp.buf.format({
						filter = function(client)
							return client.name == "null-ls" or client.name == "none-ls"
						end,
						async = true,
					})
				end
			end, { desc = "Formatting" })
		end,
	},
}
