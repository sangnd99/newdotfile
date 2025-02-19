return {
	{
		'nvimtools/none-ls.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			local null_ls = require('null-ls')
			null_ls.setup({
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.completion.spell
			})

			vim.keymap.set('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Formatting' })
		end
	}
}
