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
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("onedark").setup({
	-- 			style = "cool",
	-- 			transparent = true,
	-- 		})
	--
	-- 		vim.api.nvim_exec(
	-- 			[[
	--                set termguicolors
	--                colorscheme onedark
	--            ]],
	-- 			false
	-- 		)
	-- 	end,
	-- },
	-- LSP
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"nvimtools/none-ls.nvim",
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
	"akinsho/bufferline.nvim",
	-- Colorizer
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
  -- Import cost
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh yarn",
		-- if on windows
		-- build = 'pwsh install.ps1 yarn',
		config = true,
	},
  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>l", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  }
})
