-- Boostrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	return
end

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
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
		end,
	},
	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"b0o/SchemaStore.nvim",
	-- Completion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/nvim-cmp",
	-- Snippets
	{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
	"saadparwaiz1/cmp_luasnip",
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "VeryLazy" },
	},
	"windwp/nvim-ts-autotag",
	"andymass/vim-matchup",
	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},
	-- Telescope and file browser
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"nvim-telescope/telescope-file-browser.nvim",
	-- Dev icon
	"nvim-tree/nvim-web-devicons",
	{
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	},
	-- Git diff view
	{
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup()
		end,
	},
	-- Spectre
	"windwp/nvim-spectre",
	-- Gitsigns
	"lewis6991/gitsigns.nvim",
	-- Comment
	{ "numToStr/Comment.nvim", lazy = false },
	"JoosepAlviste/nvim-ts-context-commentstring",
	-- Lualine
	"hoob3rt/lualine.nvim",
	-- Git conflict
	{
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup({
				default_mappings = {
					next = "]x",
					prev = "[x",
				},
			})
		end,
	},
  -- Tabline
  "akinsho/bufferline.nvim"
})
