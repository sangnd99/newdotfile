local g = vim.g
local tree_cb = require("nvim-tree.config").nvim_tree_callback

vim.o.termguicolors = true

g.nvim_tree_allow_resize = 1

require("nvim-tree").setup({
  open_on_setup = false,
  open_on_tab = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  view = {
    width = 30,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
        { key = "h", cb = tree_cb("close_node") },
        { key = "v", cb = tree_cb("vsplit") },
        { key = "s", cb = tree_cb("split") },
      },
    },
  },
  -- show_icons = {
  -- 	git = 1,
  -- 	folders = 1,
  -- 	files = 1,
  -- 	folder_arrows = 1,
  -- },
  -- icons = {
  -- 	default = "",
  -- 	symlink = "",
  -- 	git = {
  -- 		unstaged = "",
  -- 		staged = "S",
  -- 		unmerged = "",
  -- 		renamed = "➜",
  -- 		deleted = "",
  -- 		untracked = "U",
  -- 		ignored = "◌",
  -- 	},
  -- 	folder = {
  -- 		default = "",
  -- 		open = "",
  -- 		empty = "",
  -- 		empty_open = "",
  -- 		symlink = "",
  -- 	},
  -- },
})
