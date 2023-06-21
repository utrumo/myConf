local null_ls = require('null-ls')
local nullLsUtils = require('null-ls.utils')
local masonnullLs = require('mason-null-ls')

local sourceNames = {
  'stylua',
  'prettierd',
  'eslint_d',
}
-- for check run :lua print(require("null-ls.client").get_client().config.root_dir)
local rootDir = nullLsUtils.root_pattern('package-lock.json', 'yarn.lock', '.git')

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == 'null-ls'
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function() lsp_formatting(bufnr) end,
    })
  end
end

masonnullLs.setup({
  ensure_installed = sourceNames,
  handlers = {},
})

null_ls.setup({
  on_attach = on_attach,
  root_dir = rootDir,
  sources = {
    -- null_ls.builtins.formatting.eslint_d,
    -- null_ls.builtins.code_actions.eslint_d,
    -- null_ls.builtins.diagnostics.eslint_d,

    -- null_ls.builtins.formatting.eslint,
    -- null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.diagnostics.eslint,

    -- null_ls.builtins.formatting.prettier,
    -- null_ls.builtins.formatting.prettier.with({
    -- disabled_filetypes = {
    -- 'vue',
    -- 'javascriptreact',
    -- 'javascript',
    -- 'typescriptreact',
    -- 'typescript',
    -- },
    -- }),
  },
})

-- for i, sourceName in ipairs(sourceNames) do
-- local source = null_ls.get_source(sourceName)
-- null_ls.deregister(sourceName)
-- null_ls.register(source)
-- end
