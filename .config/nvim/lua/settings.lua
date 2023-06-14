local opt = vim.opt

vim.cmd("set shortmess+=c")

vim.cmd("set ts=2 sw=2")
opt.cmdheight = 2
opt.completeopt = { "menuone", "noselect" }
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true
opt.smarttab = true
opt.smartcase = true
opt.viewoptions = "cursor,folds,slash,unix"
opt.termguicolors = true
opt.pumheight = 10
opt.hidden = true
opt.wrap = false
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.ruler = true
opt.pumheight = 10
opt.laststatus = 2
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.number = true
opt.showmode = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 300
opt.timeoutlen = 300
opt.scrolloff = 8
opt.clipboard = "unnamedplus"
opt.relativenumber = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.cursorline = true
opt.mouse = "a"
opt.conceallevel = 0
opt.title = true
opt.spell = false
opt.spelllang = "en"

-- Highlight when yank
vim.api.nvim_exec(
  [[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
    augroup END
  ]],
  false
)
