local status_cmp_ok, lspsaga = pcall(require, "lspsaga")
if not status_cmp_ok then
	return
end

lspsaga.init_lsp_saga({
	code_action_lightbulb = {
		enable = false,
	},
})
