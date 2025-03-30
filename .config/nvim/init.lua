--[[
Name: Sang's quick vim
Description: Neovim config file
Author: Sang Nguyen(gnas129)
--]]

-- Global settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- Settings
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.cmdheight = 2
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.ruler = true
vim.opt.pumheight = 10
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.colorcolumn = "80"
vim.api.nvim_exec(
	[[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
    augroup END
  ]],
	false
)

-- Keymappings
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Explorer" })
vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", { desc = "Set no hilighting" })
vim.keymap.set("i", "jk", "<esc>", { desc = "Set to normal mode" })
vim.keymap.set("i", "kj", "<esc>", { desc = "Set to normal mode" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Moving block to top" })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Moving block to bottom" })
vim.keymap.set("v", "<", "<gv", { desc = "Untab block" })
vim.keymap.set("v", ">", ">gv", { desc = "Tab block" })
vim.keymap.set("n", "]b", "<cmd>bn<cr>", { desc = "Move to next buffer" })
vim.keymap.set("n", "[b", "<cmd>bp<cr>", { desc = "Move to prev buffer" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up but keep cursor center" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down but keep cursor center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next match but keep cursor center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to prev match but keep cursor center" })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>", { desc = "Go to vim mode in terminal" })
vim.keymap.set("n", "<leader>t", "<cmd>term<cr>", { desc = "Open a new terminal" })
vim.keymap.set("n", "<leader>l", "<cmd>term lazygit<cr>", { desc = "Open a lazygit inside terminal" })

-- Plugins
-- [[ Using `lazy.nvim` for plugins manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
