require("onedark").setup({
	style = "cool",
	transparent = true,
})

vim.api.nvim_exec(
	[[
  set termguicolors
  colorscheme onedark
]],
	false
)
