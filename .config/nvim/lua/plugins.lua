local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
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

-- Install your plugins here
return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	-- My plugins here
	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	use("jose-elias-alvarez/null-ls.nvim")
	use("b0o/SchemaStore.nvim")
	-- Treesitter
	use("nvim-treesitter/nvim-treesitter")
	use("windwp/nvim-ts-autotag")
	use("andymass/vim-matchup")
	-- Autopairs
	use("windwp/nvim-autopairs")
	-- Completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	-- Snippets
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" })
	use("rafamadriz/friendly-snippets")
	-- Telescope and file browser
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.1" })
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	-- Colorscheme
	use("navarasu/onedark.nvim")
	-- Icons
	use("kyazdani42/nvim-web-devicons")
	-- Tmux
	use({
		"numToStr/Navigator.nvim",
		config = function()
			require("Navigator").setup()
		end,
	})
	-- Tabline
	use("akinsho/bufferline.nvim")
	-- Comment
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	-- Lualine
	use("hoob3rt/lualine.nvim")
	-- Colorizer
	use("norcalli/nvim-colorizer.lua")
	-- Git conflict
	use({
		"akinsho/git-conflict.nvim",
		config = function()
			require("git-conflict").setup()
		end,
	})
	-- Git diff view
	use("sindrets/diffview.nvim")
	-- Spectre
	use("windwp/nvim-spectre")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
