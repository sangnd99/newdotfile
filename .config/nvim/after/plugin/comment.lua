local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

local status_ok, ctxcomment = pcall(require, "ts_context_commentstring")
if not status_ok then
	return
end

vim.g.skip_ts_context_commentstring_module = true

comment.setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

ctxcomment.setup({
	enable_autocmd = false,
})
