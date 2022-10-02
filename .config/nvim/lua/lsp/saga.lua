local status_cmp_ok, lspsaga = pcall(require, "lspsaga")
if not status_cmp_ok then
	return
end

lspsaga.init_lsp_saga({
	finder_action_keys = {
		open = "o",
		vsplit = "v",
		split = "s",
	},
	code_action_lightbulb = {
		enable = false,
	},
})
