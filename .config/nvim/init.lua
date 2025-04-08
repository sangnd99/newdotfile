--[[
Name: Sang's quick vim
Description: Neovim config file
Author: Sang Nguyen(gnas129)
--]]

-- [[ Global settings ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0

-- [[ Vim settings ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.cmdheight = 1
vim.opt.hidden = true
vim.opt.wrap = false
vim.opt.mouse = "a"
vim.opt.ruler = true
vim.opt.pumheight = 10
vim.opt.showmode = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.scrolloff = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.laststatus = 2
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = { tab = "│ ", trail = "·", nbsp = "␣" }
vim.opt.confirm = true

-- [[ Builtins config ]]
-- Status line
local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
local diagnostics = string.format("%%#DiagnosticError#E:%d %%#DiagnosticWarn#W:%d%%#StatusLine#", errors, warnings)
vim.o.statusline = table.concat({
	" ",
	" %t",
	"%m",
	"%=",
	diagnostics,
	" ",
	"[col:%c,ln:%l]",
	" ",
	"%{&fileencoding?&fileencoding:&encoding}",
	" ",
	"[%{&filetype}]",
	" ",
})
-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	pattern = "*",
	callback = function(args)
		vim.api.nvim_buf_call(args.buf, function()
			vim.cmd("startinsert")
			vim.cmd("setlocal nonumber norelativenumber")
		end)
	end,
})

-- [[ Keymappings ]]
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Explorer", silent = true })
vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", { desc = "Set no hilighting", silent = true })
vim.keymap.set("i", "jk", "<esc>", { desc = "Set to normal mode", silent = true })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Moving block to top", silent = true })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Moving block to bottom", silent = true })
vim.keymap.set("v", "<", "<gv", { desc = "Untab block", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Tab block", silent = true })
vim.keymap.set("n", "]b", "<cmd>bn<cr>", { desc = "Move to next buffer", silent = true })
vim.keymap.set("n", "[b", "<cmd>bp<cr>", { desc = "Move to prev buffer", silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up but keep cursor center", silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down but keep cursor center", silent = true })
vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next match but keep cursor center", silent = true })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to prev match but keep cursor center", silent = true })
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>", { desc = "Go to vim mode in terminal", silent = true })
vim.keymap.set("n", "<leader>t", "<cmd>term<cr>", { desc = "Open a new terminal", silent = true })
vim.keymap.set("n", "<leader>l", "<cmd>term lazygit<cr>", { desc = "Open a lazygit inside terminal", silent = true })

-- [[ Helpers ]]
-- Highlight on yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Plugins ]]
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
