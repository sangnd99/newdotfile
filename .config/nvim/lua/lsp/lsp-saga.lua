local status_cmp_ok, lspsaga = pcall(require, "lspsaga")
if not status_cmp_ok then
	return
end

lspsaga.setup({
	finder_action_keys = {
		open = "o",
		vsplit = "v",
		split = "s",
	},
	code_action_lightbulb = {
		enable = false,
	},
	ui = {
		winblend = 10,
		border = "rounded",
		colors = {
			--float window normal background color
			normal_bg = "#2a324a",
		},
	},
})
