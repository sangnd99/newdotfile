--[[
Name: Sang's quick vim
Description: Neovim config file
Author: Sang Nguyen(gnas129)
--]]

-- [[ Global settings ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_sort_by = 'none'

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
vim.opt.cmdheight = 0
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
function _G.short_filepath()
	local path = vim.fn.expand("%:~:.")
	local parts = vim.split(path, "/")
	if #parts <= 3 then
		return path
	end

	local last_parts = { unpack(parts, #parts - 2, #parts) }
	return "~../" .. table.concat(last_parts, "/")
end
function _G.mode()
	local mode_map = {
		n = "NORMAL ",
		i = "INSERT ",
		v = "VISUAL ",
		V = "V-LINE ",
		[""] = "V-BLOCK ",
		c = "COMMAND ",
		s = "SELECT ",
		S = "S-LINE ",
		[""] = "S-BLOCK ",
		R = "REPLACE ",
		t = "TERMINAL ",
	}
	local mode = vim.fn.mode()
	return mode_map[mode] or mode
end
function _G.recording_status()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	else
		return "[Recording @" .. reg .. "]"
	end
end
vim.o.statusline = table.concat({
	"%#PmenuSel#",
	" ",
	"%{%v:lua.mode()%}",
	"%#StatusLine#",
	"%{%v:lua.recording_status()%}",
	" ",
	"%{%v:lua.short_filepath()%}",
	"%m",
	"%=",
	" ",
	"%{&filetype}",
	" ",
	"[%p%%]",
	" ",
})
-- [[ Terminal ]]
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

-- [[ Netrw ]]
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.wo.signcolumn = "no"
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
vim.keymap.set("n", "<leader>lg", "<cmd>term lazygit<cr>", { desc = "Open a lazygit inside terminal", silent = true })
vim.keymap.set("n", "<C-,>", "<C-w><", { desc = "Resize window horizontal", silent = true })
vim.keymap.set("n", "<C-.>", "<C-w>>", { desc = "Resize window horizontal", silent = true })
vim.keymap.set("n", "<C-=>", "<C-w>+", { desc = "Resize window vertical", silent = true })
vim.keymap.set("n", "<C-->", "<C-w>-", { desc = "Resize window vertical", silent = true })
vim.keymap.set("n", "ss", "<C-w>s<C-w>p", { desc = "Split window", silent = true })
vim.keymap.set("n", "sv", "<C-w>v<C-w>p", { desc = "Vertical split window", silent = true })

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

require("lazy").setup({
	import = "plugins",
}, {
	change_detection = {
		notify = false,
	},
})
