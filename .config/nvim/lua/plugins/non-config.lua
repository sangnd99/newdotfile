return {
	"nvim-tree/nvim-web-devicons", -- Icons
	{ "sindrets/diffview.nvim", opts = {} },
	"windwp/nvim-ts-autotag",
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh yarn",
		-- if on windows
		-- build = 'pwsh install.ps1 yarn',
		config = true,
	},
}
