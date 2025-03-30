vim.opt.statusline = "%!v:lua.StatusLine()"

function StatusLine()
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
	local file_encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or vim.o.encoding
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
		file_encoding,
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
