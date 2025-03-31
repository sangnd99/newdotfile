return {
	{ -- Telescope
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"aaronhallaert/advanced-git-search.nvim",
				dependencies = {
					"tpope/vim-fugitive",
					"tpope/vim-rhubarb",
				},
			},
		},
		config = function()
			local status_ok, telescope = pcall(require, "telescope")
			if not status_ok then
				return
			end
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local themes = require("telescope.themes")

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
							["<C-c>"] = actions.close,
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
				extensions = {
					advanced_git_search = {
						telescope_theme = {
							diff_commit_file = themes.get_ivy({ layout_config = { height = 100 } }),
						},
					},
				},
			})
			-- load extensions
			telescope.load_extension("advanced_git_search")

			local function ivy_opts(opts)
				return themes.get_ivy(vim.tbl_deep_extend("force", {
					layout_config = {
						height = 100,
					},
				}, opts or {}))
			end

			vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Global find file" })
			vim.keymap.set("n", "<leader>pb", builtin.buffers, { desc = "Opened buffer" })
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string(ivy_opts({
					search = vim.fn.input("Grep > "),
				}))
			end, { desc = "Grep search" })
			vim.keymap.set(
				"n",
				"<leader>gdf",
				"<cmd>Telescope advanced_git_search diff_commit_file<cr>",
				{ desc = "Open git commit diff file" }
			)
		end,
	},
}
