local utils = require('config/keybindings/utils')
local printInspect = utils.printInspect

-- Register linters and formatters per language
local base_eslint_d_linter = require('efmls-configs.linters.eslint_d')
local base_eslint_d_formatter = require('efmls-configs.formatters.eslint_d')
local base_prettier_d_formatter = require('efmls-configs.formatters.prettier_d')

local eslint_d_linter = vim.tbl_extend('force', base_eslint_d_linter, {
  lintCommand = 'yarn eslint_d' .. base_eslint_d_linter.lintCommand,
})
local eslint_d_formatter = vim.tbl_extend('force', base_eslint_d_formatter, {
  formatCommand = 'yarn eslint_d' .. base_eslint_d_formatter.formatCommand,
})
local prettier_d_formatter = vim.tbl_extend('force', base_prettier_d_formatter, {
  formatCommand = 'yarn prettierd' .. base_prettier_d_formatter.formatCommand,
})

-- local stylua = require('efmls-configs.formatters.stylua')

local languages = {
  typescript = {
    eslint_d_linter,
    eslint_d_formatter,
    prettier_d_formatter,
  },
  -- lua = { stylua },
}
-- printInspect(prettier_d_formatter)

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require('efmls-configs.defaults').languages()

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/', 'yarn.lock' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}

require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
  -- Pass your custom lsp config below like on_attach and capabilities
  --
  -- on_attach = on_attach,
  -- capabilities = capabilities,
}))

local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = lsp_fmt_group,
  callback = function()
    local efm = vim.lsp.get_active_clients({ name = 'efm' })

    if vim.tbl_isempty(efm) then return end

    vim.lsp.buf.format({ name = 'efm' })
  end,
})
