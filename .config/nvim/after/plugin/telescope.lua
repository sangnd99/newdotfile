local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local key = vim.keymap
local opts = { noremap = true, silent = true }
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
    initial_mode = "normal",

		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-c>"] = actions.close,
			},
			n = {
				["<space>e"] = actions.close,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		find_files = {
      theme = "dropdown",
      previewer = false,
      layout_config = { height = 40 },
		},
		buffers = {
      theme = "dropdown",
      previewer = false,
      layout_config = { height = 40 },
		}
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
		},
    conventional_commits = {
      theme = "dropdown"
    }
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
})

-- Telescope extentions
telescope.load_extension("file_browser")
telescope.load_extension("conventional_commits")

-- Keymapping
key.set("n", "'f", builtin.find_files, opts)
key.set("n", "'b", builtin.buffers, opts)
