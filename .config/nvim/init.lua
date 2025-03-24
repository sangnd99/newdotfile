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
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.api.nvim_exec(
	[[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
    augroup END
  ]],
	false
)
vim.opt.statusline = "%!v:lua.StatusLine()"
vim.o.tabline = "%!v:lua.BufferLine()"

-- Tab bar
function _G.BufferLine()
	local s = ""
	local buffers = vim.api.nvim_list_bufs()
	local current_buf = vim.api.nvim_get_current_buf()
	local has_devicons, devicons = pcall(require, "nvim-web-devicons")

	local buf_index = 1
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_get_option(buf, "buflisted") then
			local bufname = vim.api.nvim_buf_get_name(buf)
			local filename = bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]"
			local modified = vim.api.nvim_buf_get_option(buf, "modified") and "[+]" or ""

			-- Get icon
			local icon = ""
			if has_devicons then
				local ext = vim.fn.fnamemodify(filename, ":e")
				icon = devicons.get_icon(filename, ext, { default = true }) or ""
			end

			local hl = (buf == current_buf) and "%#TabLine#" or "%#NonText#"

			s = s .. string.format("%%%dT%s %d: %s %s %s ", buf, hl, buf_index, icon, filename, modified)
			buf_index = buf_index + 1
		end
	end

	s = s .. "%#TabLineFill#%T"
	return s
end

-- Status line config
function _G.StatusLine()
	-- Variables
	local RESET = "%#Normal#"
	local SEPARATE_LEFT = " \\ "
	local SEPARATE_RIGHT = " / "
	-- Mapping mode
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
		vim.api.nvim_set_hl(0, "StatusLineIcon", { fg = icon_color, bg = "NONE" })
	end

	return table.concat({
		"%#PmenuSel# ",
		RESET,
		" ",
		mode_map[vim.fn.mode()],
		RESET,
		SEPARATE_LEFT,
		" %f",
		"%=",
		"%c:%l", -- line column
		SEPARATE_RIGHT,
		diagnostics,
		RESET,
		SEPARATE_RIGHT,
		"%#StatusLineIcon#",
		icon,
		" ",
		file_type,
	})
end

-- Explorer
local netrw_state = {}
function _G.ToggleNetrw()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "netrw" then
			-- Close the netrw buffer
			vim.api.nvim_buf_call(buf, function()
				vim.cmd("bwipeout!")
			end)
			-- Restore focus to the original window and buffer
			if netrw_state.origin_win and vim.api.nvim_win_is_valid(netrw_state.origin_win) then
				vim.api.nvim_set_current_win(netrw_state.origin_win)
			end
			if netrw_state.origin_buf and vim.api.nvim_buf_is_valid(netrw_state.origin_buf) then
				vim.api.nvim_set_current_buf(netrw_state.origin_buf)
			end
			-- Clear the state
			netrw_state.origin_buf = nil
			netrw_state.origin_win = nil
			return
		end
	end

	-- If netrw isn’t open, store the current state and open it
	netrw_state.origin_buf = vim.api.nvim_get_current_buf()
	netrw_state.origin_win = vim.api.nvim_get_current_win()

	-- Open Netrw if not open
	vim.cmd("Explore")
end

-- Customize Netrw
local TYPE_DIR = 0
local TYPE_FILE = 1
local TYPE_SYMLINK = 2

local get_node = function(line)
	if string.find(line, '^"') then
		return nil
	end
	-- When netrw is empty, there's one line in the buffer and it is empty.
	if line == "" then
		return nil
	end

	local curdir = vim.b.netrw_curdir
	local _, _, node, link = string.find(line, "^(.+)@\t%s*%-%->%s*(.+)")

	if node then
		return {
			dir = curdir,
			col = 0,
			node = node,
			extension = vim.fn.fnamemodify(node, ":e"),
			link = link,
			type = TYPE_SYMLINK,
		}
	end

	local _, _, dir = string.find(line, "^(.*)/")
	if dir then
		return {
			dir = curdir,
			col = 0,
			node = dir,
			type = TYPE_DIR,
		}
	end

	local ext = vim.fn.fnamemodify(line, ":e")
	if string.sub(ext, -1) == "*" then
		ext = string.sub(ext, 1, -2)
		line = string.sub(line, 1, -2)
	end

	return {
		dir = curdir,
		col = 0,
		node = line,
		extension = ext,
		type = TYPE_FILE,
	}
end

vim.api.nvim_create_autocmd("BufModifiedSet", {
	pattern = { "*" },
	callback = function()
		if not (vim.bo and vim.bo.filetype == "netrw") then
			return
		end

		if vim.b.netrw_liststyle ~= 0 and vim.b.netrw_liststyle ~= 1 and vim.b.netrw_liststyle ~= 3 then
			return
		end

		local namespace = vim.api.nvim_create_namespace("netrw")
		local bufnr = vim.api.nvim_get_current_buf()
		local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

		for i, line in ipairs(lines) do
			local node = get_node(line)
			if not node then
				goto continue
			end

			local opts = { id = i }
			local icon = ""
			local hl_group = ""

			if node.node ~= ".." and node.node ~= "." then
				if node.type == TYPE_FILE then
					icon = ""
					local has_devicons, devicons = pcall(require, "nvim-web-devicons")

					if has_devicons then
						local ic, hi = devicons.get_icon(node.node, nil, { strict = true, default = false })
						if ic then
							icon = ic
							hl_group = hi
						end
					end
				elseif node.type == TYPE_DIR then
					icon = ""
				elseif node.type == TYPE_SYMLINK then
					icon = ""
				end
			end

			if node.col == 0 then
				if hl_group then
					opts.sign_hl_group = hl_group
				end
				opts.sign_text = icon

				vim.api.nvim_buf_set_extmark(bufnr, namespace, i - 1, math.max(0, node.col - 2), opts)
			end
			::continue::
		end

		-- Fixes weird case where the cursor spawns inside of the sign column.
		vim.cmd([[norm lh]])

		-- Keymapping netrw
	end,
	group = vim.api.nvim_create_augroup("netrw", { clear = false }),
})

-- Netrw keybinding
vim.api.nvim_create_autocmd("filetype", {
	pattern = "netrw",
	desc = "Better mappings for netrw",
	callback = function()
		local bind = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
		end

		-- edit new file
		bind("c", "%")

		-- rename file
		bind("r", "R")

		-- create directory and enter it
		bind("d", function()
			-- Get current directory path
			local current_dir = vim.fn.expand("%:p:h")
			-- Prompt for directory name
			local dir_name = vim.fn.input("Directory name: ")
			if dir_name == "" then
				return
			end
			-- Create the directory
			local full_path = current_dir .. "/" .. dir_name
			vim.fn.mkdir(full_path, "p")
			-- Refresh netrw
			vim.cmd("call netrw#Call('NetrwRefresh', 1, '" .. full_path .. "')")
			-- Enter the new directory
			vim.cmd("edit " .. vim.fn.fnameescape(full_path))
			-- Debug output
			vim.notify("Entered: " .. full_path, vim.log.levels.INFO)
		end)
	end,
})

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function(args)
		vim.api.nvim_buf_call(args.buf, function()
			vim.cmd("setlocal nonumber norelativenumber")
		end)
	end,
})

-- Keymappings
vim.keymap.set("n", "<leader>e", "<cmd>lua ToggleNetrw()<cr>", { desc = "Explorer" })
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
