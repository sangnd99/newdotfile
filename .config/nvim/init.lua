--[[
Name: Sang's quick vim
Description: Neovim config file
Author: Sang Nguyen(gnas129)
--]]

-- Global settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.netrw_banner = 0

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
vim.o.statusline = "%!v:lua.StatusLine()"

-- status line config
function _G.StatusLine()
	-- Variables
	local RESET = "%#Normal#"
	-- Mapping mode
	local mode_map = {
		n = "%#PmenuSel# NORMAL ",
		i = "%#PmenuSel# INSERT ",
		v = "%#PmenuSel# VISUAL ",
		V = "%#PmenuSel# V-LINE ",
		[""] = "%#PmenuSel# V-BLOCK ",
		c = "%#PmenuSel# COMMAND ",
		s = "%#PmenuSel# SELECT ",
		S = "%#PmenuSel# S-LINE ",
		[""] = "%#PmenuSel# S-BLOCK ",
		R = "%#PmenuSel# REPLACE ",
		t = "%#PmenuSel# TERMINAL ",
	}
	-- Get diagnostics
	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	local diagnostics = string.format("%%#DiagnosticError#:%d %%#DiagnosticWarn#:%d", errors, warnings)

	-- Get file type
	local file_name = vim.fn.expand("%:t") ~= "" and vim.fn.expand("%:t") or "[No Name]"
	local file_type = vim.bo.filetype
	local devicons = require("nvim-web-devicons")
	local icon, icon_color = devicons.get_icon_color(file_name, vim.fn.expand("%:e"), { default = true })
	if icon_color then
		vim.api.nvim_set_hl(0, "StatusLineIcon", { fg = icon_color, bg = "#1E1E2E" })
	end

	return table.concat({
		mode_map[vim.fn.mode()],
		RESET,
		" ",
		" %f",
		"%=",
		"%c:%l", -- line column
		" ",
		diagnostics,
		" ",
		RESET,
		" ",
		"%#StatusLineIcon#",
		icon,
		" ",
		file_type,
	})
end

-- Explorer
function _G.ToggleNetrw()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "netrw" then
			vim.cmd("bd")
			return
		end
	end

	-- Open Netrw if not open
	vim.cmd("Explore")
end

-- Keymappings
vim.keymap.set("n", "<leader>e", "<cmd>lua ToggleNetrw()<cr>", { desc = "Explorer" })
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
