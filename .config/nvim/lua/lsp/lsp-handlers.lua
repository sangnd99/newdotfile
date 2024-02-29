local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local signs = {

    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn",  text = "" },
    { name = "DiagnosticSignHint",  text = "" },
    { name = "DiagnosticSignInfo",  text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    virtual_text = false,
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    serverity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set
  keymap("n", "J", vim.diagnostic.open_float, opts)
  keymap("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
  keymap("v", "<leader>f", function()
    local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, "<"))
    local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, ">"))
    vim.lsp.buf.format({
      range = {
        ["start"] = { start_row, 0 },
        ["end"] = { end_row, 0 },
      },
      async = true,
    })
  end, opts)
  keymap("n", "gd", vim.lsp.buf.definition, opts)

  -- Code action
  keymap("n", "<leader>a", vim.lsp.buf.code_action, opts)

  -- Hover doc
  keymap("n", "K", vim.lsp.buf.hover, opts)
  -- Rename
  keymap("n", "gr", vim.lsp.buf.rename, opts)
  -- Preview definition
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  -- Show all errors in bottom sheet
  keymap("n", "ge", vim.diagnostic.setqflist, opts)
  -- Jump to error
  keymap("n", "]e", vim.diagnostic.goto_next, opts)
  keymap("n", "[e", vim.diagnostic.goto_prev, opts)
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == "html" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == "gopls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  lsp_keymaps(bufnr)
end

return M
