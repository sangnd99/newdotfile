local g = vim.g

vim.o.termguicolors = true

g.gruvbox_material_palette = "mix"
g.gruvbox_material_transparent_background = 1
g.gruvbox_material_enable_italic = 1
g.gruvbox_material_diagnostic_text_highlight = 1
g.gruvbox_material_diagnostic_line_highlight = 1
g.gruvbox_material_diagnostic_virtual_text = 1

vim.api.nvim_exec(
	[[
  colorscheme gruvbox-material
]],
	false
)
