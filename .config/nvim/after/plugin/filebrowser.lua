local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local key = vim.keymap
local opts = { noremap = true, silent = true }
local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end
local builtin = require("telescope.builtin")

key.set("n", "<space>e", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
    dir_icon = ""
	})
end, opts)
key.set("n", "'f", builtin.find_files, opts)
key.set("n", "'b", builtin.buffers, opts)
