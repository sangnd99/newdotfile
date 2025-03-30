vim.o.tabline = "%!v:lua.TabLine()"

function TabLine()
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
