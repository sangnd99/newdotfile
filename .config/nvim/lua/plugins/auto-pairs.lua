return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				check_ts = true, -- treesitter integration
				disable_filetype = { "TelescopePrompt" },
			})
		end,
	},
}
