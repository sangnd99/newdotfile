return {
	{ -- Telescope
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			local status_ok, telescope = pcall(require, "telescope")
			if not status_ok then
				return
			end
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local function telescope_buffer_dir()
				return vim.fn.expand("%:p:h")
			end

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
					},
					-- Now the picker_config_key will be applied every time you call this
					-- builtin picker
				},
				extensions = {
					file_browser = {
						theme = "dropdown",
						-- disables netrw and use telescope-file-browser in its place
						hijack_netrw = true,
					},
				},
			})

			telescope.load_extension("file_browser")
			telescope.load_extension("rest")

			vim.keymap.set("n", "'f", builtin.find_files, { desc = "Global find file" })
			vim.keymap.set("n", "'b", builtin.buffers, { desc = "Opened buffer" })
			vim.keymap.set("n", "<leader>e", function()
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = telescope_buffer_dir(),
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					previewer = false,
					initial_mode = "normal",
					layout_config = { height = 40 },
					dir_icon = "",
				})
			end, { desc = "Telescope file explorer" })
		end,
	},
}
