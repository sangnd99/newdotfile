return {
	{
		"saghen/blink.cmp",
		version = "*",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("blink.cmp").setup({
				keymap = {
					preset = "enter",
					["<C-o>"] = { "show", "show_documentation", "hide_documentation" },
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				snippets = {
					preset = "luasnip",
				},
				appearance = {
					nerd_font_variant = "mono",
					use_nvim_cmp_as_default = true,
				},
				fuzzy = { implementation = "prefer_rust_with_warning" },
				signature = { enabled = true, window = { border = "rounded" } },
				completion = {
					accept = {
						auto_brackets = {
							enabled = false,
						},
					},
					menu = {
						min_width = 10, -- max_width controlled by draw-function
						max_height = 10,
						border = "rounded",
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 250,
						window = {
							border = "rounded",
						},
					},
				},
			})
		end,
	},
}
