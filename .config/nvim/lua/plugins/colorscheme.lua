return { -- Vscode color scheme
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				-- Alternatively set style in setup
				-- style = 'light'

				-- Enable transparent background
				transparent = true,

				-- Enable italic comment
				italic_comments = true,

				-- Underline `@markup.link.*` variants
				underline_links = true,

				-- Disable nvim-tree background color
				disable_nvimtree_bg = true,

				-- Override colors (see ./lua/vscode/colors.lua)
				-- color_overrides = {
				--     vscLineNumber = '#FFFFFF',
				-- },

				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
					EndOfBuffer = { fg = c.vscBack },
					CursorLine = { bg = c.vscCursorDark },
					CursorColumn = { fg = "NONE", bg = c.vscCursorDark },
					ColorColumn = { fg = "NONE", bg = c.vscCursorDark },
					GitSignsCurrentLineBlame = { fg = c.vscCursorLight },
				},
			})
			vim.api.nvim_exec(
				[[
					set termguicolors
					colorscheme vscode
				]],
				false
			)
		end,
	},
}
