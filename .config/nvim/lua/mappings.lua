local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
-- No highlight
map("n", "<Space>h", ":noh<cr>", opts)
-- No esc
map("i", "jk", "<esc>", opts)
map("i", "kj", "<esc>", opts)
map("i", "jj", "<esc>", opts)
-- Moving block
map("v", "J", ":m '>+1<cr>gv=gv", opts)
map("v", "K", ":m '<-2<cr>gv=gv", opts)
-- Resize window
map("n", "˚", ":resize -2<cr>", opts)
map("n", "∆", ":resize +2<cr>", opts)
map("n", "˙", ":vertical resize -2<cr>", opts)
map("n", "¬", ":vertical resize +2<cr>", opts)
-- I NEED THIS
map("n", ":Wq", ":wq", opts)
map("n", ":Q", ":q", opts)
map("n", ":W", ":w", opts)
map("n", ":Q!", ":q!", opts)
-- Better tabbing
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- Tmux navigation
map("n", "<C-h>", "<CMD>NavigatorLeft<CR>", opts)
map("n", "<C-l>", "<CMD>NavigatorRight<CR>", opts)
map("n", "<C-k>", "<CMD>NavigatorUp<CR>", opts)
map("n", "<C-j>", "<CMD>NavigatorDown<CR>", opts)
map("n", "<C-p>", "<CMD>NavigatorPrevious<CR>", opts)
-- Buffer line traveling
map("n", "]b", ":BufferLineCycleNext<CR>", opts)
map("n", "[b", ":BufferLineCyclePrev<CR>", opts)
