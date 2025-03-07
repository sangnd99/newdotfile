return {
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			vim.g.webdevicons_enable = 1
			vim.g.webdevicons_enable_netrw = 1
		end,
	}, -- Icons
	{ "sindrets/diffview.nvim", opts = {} },
	{ "windwp/nvim-ts-autotag", opts = {} },
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh yarn",
		-- if on windows
		-- build = 'pwsh install.ps1 yarn',
		config = true,
	},
}
