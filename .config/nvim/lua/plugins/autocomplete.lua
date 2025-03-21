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
				keymap = { preset = "enter" },
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
					menu = {
						border = "rounded",
						winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
					},
					documentation = {
						window = {
							border = "rounded",
						},
					},
				},
			})
		end,
	},
}
