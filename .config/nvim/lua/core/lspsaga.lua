local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

local status_ok, action = pcall(require, "lspsaga.action")
if not status_ok then
	return
end

saga.init_lsp_saga({
	-- put modified options in there
	finder_action_keys = {
		open = "o",
		vsplit = "v",
		split = "s",
	},
})

-- Keymapping

-- Lsp finder
vim.keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
vim.keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("v", "<leader>a", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

-- Hover doc
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "<C-f>", function()
	action.smart_scroll_with_saga(1)
end, { silent = true })
-- scroll up hover doc
vim.keymap.set("n", "<C-b>", function()
	action.smart_scroll_with_saga(-1)
end, { silent = true })
-- Signature help
vim.keymap.set("n", "gs", "<Cmd>Lspsaga signature_help<CR>", { silent = true })
-- Rename
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
-- Preview definition
vim.keymap.set("n", "gD", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
-- Jump to error
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
