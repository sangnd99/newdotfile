vim.g.netrw_banner = 0
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

