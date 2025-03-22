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
					["<Tab>"] = { "select_next", "fallback_to_mappings" },
					["<S-Tab>"] = { "select_prev", "fallback_to_mappings" },
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
						-- experimental auto-brackets support
						auto_brackets = {
							enabled = true,
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
