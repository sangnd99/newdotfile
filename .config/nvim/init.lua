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
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.cmdheight = 2
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.relativenumber = true
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
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.api.nvim_exec(
	[[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
    augroup END
  ]],
	false
)
-- status line config
vim.o.statusline = table.concat({
	"%#PmenuSel#",
	" %{%v:lua.Mode()%} ",
	"%#Normal#", -- Mode
	" %f",
	"%m", -- File path & modified flag
	" %=", -- Right alignment
	"%c:%l",
	"%{%v:lua.LspDiagnostics()%} ", -- LSP Diagnostics
	"%{%v:lua.Cwd()%} ", -- Current working directory
	"%y ",
})

function _G.Cwd()
	return "%#PmenuSel#  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. " %#Normal#"
end

-- Function to show Vim mode
function _G.Mode()
	local mode_map = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		[""] = "V-BLOCK",
		c = "COMMAND",
		s = "SELECT",
		S = "S-LINE",
		[""] = "S-BLOCK",
		R = "REPLACE",
		t = "TERMINAL",
	}
	return mode_map[vim.fn.mode()] or "UNKNOWN"
end

-- Function to count LSP diagnostics
function _G.LspDiagnostics()
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

	return table.concat({
		"%#DiagnosticError#",
		" :",
		errors,
		" ",
		"%#DiagnosticWarn#",
		" :",
		warnings,
		" ",
		"%#Normal#", -- Reset highlight to default
	})
end

-- Keymappings
vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", { desc = "Set no hilighting" })
vim.keymap.set("i", "jk", "<esc>", { desc = "Set to normal mode" })
vim.keymap.set("i", "kj", "<esc>", { desc = "Set to normal mode" })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { desc = "Moving block to top" })
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { desc = "Moving block to bottom" })
vim.keymap.set("v", "<", "<gv", { desc = "Untab block" })
vim.keymap.set("v", ">", ">gv", { desc = "Tab block" })

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
