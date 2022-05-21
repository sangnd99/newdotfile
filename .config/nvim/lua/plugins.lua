local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function(use)
	-- File explorer
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-tree").setup({})
		end,
	})
	-- Colorscheme
	-- use("gruvbox-community/gruvbox")
	-- use("sainnhe/gruvbox-material")
	use("shaunsingh/nord.nvim")
	use("navarasu/onedark.nvim")
	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("windwp/nvim-ts-autotag")
	use("andymass/vim-matchup")
	-- LSP
	use("jose-elias-alvarez/null-ls.nvim")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("williamboman/nvim-lsp-installer")
	use({ "tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp" })
	use("b0o/SchemaStore.nvim")

	-- Snippet
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use({ "dsznajder/vscode-es7-javascript-react-snippets", run = "yarn install --frozen-lockfile && yarn compile" })
	use("rafamadriz/friendly-snippets")
	-- Autopairs
	use("windwp/nvim-autopairs")
	-- Gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})
	-- Git conflict
	use({
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup()
		end,
	})
	-- Lualine
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- Colorizer
	use("norcalli/nvim-colorizer.lua")
	-- Comment
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	-- Tmux
	use({
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	})
	-- Code action ui
	use({ "weilbith/nvim-code-action-menu", cmd = "CodeActionMenu" })
	-- Tabline
	use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
	-- Terminal
	use({ "akinsho/toggleterm.nvim" })
	if packer_bootstrap then
		require("packer").sync()
	end
	-- Indent line
	use("lukas-reineke/indent-blankline.nvim")
	-- Regex explain
	use({
		"bennypowers/nvim-regexplainer",
		config = function()
			require("regexplainer").setup()
		end,
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"MunifTanjim/nui.nvim",
		},
	})
end)
