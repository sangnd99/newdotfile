return {
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = {
				preset = "enter",
				["<C-o>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-l>"] = { "snippet_forward", "fallback" },
				["<C-h"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				accept = { auto_brackets = { enabled = false } },
				menu = { border = "rounded" },
				documentation = { auto_show = true, auto_show_delay_ms = 250, window = { border = "rounded" } },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			signature = { enabled = true, window = { border = "rounded", show_documentation = false } },
		},
	},
}
