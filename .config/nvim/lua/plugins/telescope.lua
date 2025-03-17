return {
	{ -- Telescope
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local status_ok, telescope = pcall(require, "telescope")
			if not status_ok then
				return
			end
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")

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
						theme = "ivy",
						layout_config = { height = 100 },
					},
					buffers = {
						theme = "ivy",
						layout_config = { height = 100 },
					},
					-- Now the picker_config_key will be applied every time you call this
					-- builtin picker
				},
				extensions = {},
			})

			telescope.load_extension("rest")

			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Global find file" })
			vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Opened buffer" })
			vim.keymap.set("n", "<leader>ps", function()
				local opts = require("telescope.themes").get_ivy({
					layout_config = {
						height = 100
					},
					search = vim.fn.input("Grep > "),
				})
				builtin.grep_string(opts)
			end, { desc = "Grep search" })
		end,
	},
}
