vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	pattern = "*",
	callback = function(args)
		vim.api.nvim_buf_call(args.buf, function()
			vim.cmd("startinsert")
			vim.cmd("setlocal nonumber norelativenumber")
		end)
	end,
})
