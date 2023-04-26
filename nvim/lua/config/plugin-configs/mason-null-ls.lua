local nullLs = require('null-ls')
local nullLsUtils = require('null-ls.utils')
local masonnullLs = require('mason-null-ls')

local sourceNames = {
  'stylua',
  'prettierd',
  'eslint_d',
}
-- for check run :lua print(require("null-ls.client").get_client().config.root_dir)
local rootDir = nullLsUtils.root_pattern('yarn.lock', '.git')

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local onAttach = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        -- vim.lsp.buf.formatting_sync()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

masonnullLs.setup({
  ensure_installed = sourceNames,
  handlers = {},
})

nullLs.setup({
  on_attach = onAttach,
  root_dir = rootDir,
})

-- for i, sourceName in ipairs(sourceNames) do
-- local source = nullLs.get_source(sourceName)
-- nullLs.deregister(sourceName)
-- nullLs.register(source)
-- end
