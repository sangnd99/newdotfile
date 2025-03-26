return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {

			indent = { char = "│" },
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
				injected_languages = false,
				highlight = { "Function", "Label" },
				priority = 500,
			},
			exclude = {
				buftypes = { "nofile", "prompt", "popup", "terminal" },
				filetypes = { "TelescopePrompt", "cmp_menu", "cmp_docs", "blink-cmp", "snippets" },
			}
		},
	},
}
