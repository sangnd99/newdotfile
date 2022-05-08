local g = vim.g

g.nord_contrast = true
g.nord_borders = true
g.nord_disable_background = true
g.nord_italic = true

vim.api.nvim_exec(
	[[
  set termguicolors
  autocmd colorscheme * hi BufferLineFill guibg=NONE
  colorscheme nord
]],
	false
)
