local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Leader key
vim.g.mapleader = " "

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

-- Window movement
-- map('n', '<C-j>', '<C-w>j', opts)
-- map('n', '<C-k>', '<C-w>k', opts)
-- map('n', '<C-h>', '<C-w>h', opts)
-- map('n', '<C-l>', '<C-w>l', opts)

-- I NEED THIS
map("n", ":Wq", ":wq", opts)
map("n", ":Q", ":q", opts)
map("n", ":W", ":w", opts)
map("n", ":Q!", ":q!", opts)

-- Better tabbing
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Explorer
-- map('n', '<Leader>e', ':NvimTreeToggle<cr>', opts)
-- map('n', '<Leader>E', ':NvimTreeFindFile<cr>', opts)
map("n", "<Leader>e", ":NvimTreeFindFileToggle<cr>", opts)

-- Telescope
map("n", "'f", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
map("n", "'g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
map("n", ";", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)

-- Tmux navigation
vim.keymap.set("n", "<C-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set("n", "<C-l>", "<CMD>NavigatorRight<CR>")
vim.keymap.set("n", "<C-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set("n", "<C-j>", "<CMD>NavigatorDown<CR>")
vim.keymap.set("n", "<C-p>", "<CMD>NavigatorPrevious<CR>")
