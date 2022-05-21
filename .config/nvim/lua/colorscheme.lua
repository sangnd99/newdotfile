local g = vim.g

require("onedark").setup({
	style = "cool",
	transparent = true,
})

vim.api.nvim_exec(
	[[
  set termguicolors
  autocmd colorscheme * hi BufferLineFill guibg=NONE
  " colorscheme nord
  colorscheme onedark
]],
	false
)
