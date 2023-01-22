vim.keymap.set("n", "<leader>s", "<cmd>lua require('spectre').open()<CR>")
-- search current word
vim.keymap.set("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>")
vim.keymap.set("v", "<leader>s", "<esc>:lua require('spectre').open_visual()<CR>")
-- search in current file
vim.keymap.set("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>")
