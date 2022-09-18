local status_ok, fzflua = pcall(require, "fzf-lua")
if not status_ok then
	return
end

fzflua.setup({
	files = {
		path_shorten = 1, -- 'true' or number, shorten path?
	},
})
