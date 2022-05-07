require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"typescript",
		"tsx",
		"javascript",
		"scss",
		"lua",
		"html",
		"json",
		"json5",
		"css",
	},
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		-- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
		disable = { "latex" },
	},
	context_commentstring = {
		enable = true,
		config = { css = "// %s" },
		enable_autocmd = false,
	},
	autotag = {
		enable = true,
	},
})
