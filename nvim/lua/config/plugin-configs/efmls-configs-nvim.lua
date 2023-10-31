local utils = require('config/keybindings/utils')
local printInspect = utils.printInspect

local base_eslint_d_linter = require('efmls-configs.linters.eslint_d')
local eslint_d_linter = vim.tbl_extend('force', base_eslint_d_linter, {
  lintCommand = 'yarn ' .. base_eslint_d_linter.lintCommand .. ' --cache',
})

local base_eslint_d_formatter = require('efmls-configs.formatters.eslint_d')
local eslint_d_formatter = vim.tbl_extend('force', base_eslint_d_formatter, {
  formatCommand = 'yarn ' .. base_eslint_d_formatter.formatCommand .. ' --cache',
  rootMarkers = { ".eslintrc", ".eslintrc.cjs", ".eslintrc.js", ".eslintrc.json", ".eslintrc.yaml", ".eslintrc.yml", "package.json" }
})

local base_prettier_formatter = require('efmls-configs.formatters.prettier')
-- local prettier_formatter = vim.tbl_extend('force', base_prettier_formatter, {
  -- formatCommand = 'yarn prettier --cache --cache-location .prettiercache' .. base_prettier_formatter.formatCommand,
-- })
local prettier_formatter = vim.tbl_extend('force', base_prettier_formatter, {
  formatCommand = 'yarn ' .. base_prettier_formatter.formatCommand .. ' --cache --cache-location .prettiercache',
})
-- local prettier_formatter = {
  -- -- formatCanRange = true,
  -- -- formatCommand = "yarn prettier --cache --cache-location .prettiercache --stdin --stdin-filepath '${INPUT}' ${--range-start:charStart} ${--range-end:charEnd} ${--tab-width:tabSize} ${--use-tabs:!insertSpaces}",
  -- formatCommand = "yarn prettier --cache --cache-location .prettiercache --stdin --stdin-filepath '${INPUT}'",
  -- formatStdin = true,
  -- rootMarkers = { ".prettierrc", ".prettierrc.json", ".prettierrc.js", ".prettierrc.yml", ".prettierrc.yaml", ".prettierrc.json5", ".prettierrc.mjs", ".prettierrc.cjs", ".prettierrc.toml" }
-- }

-- local base_prettier_d_formatter = require('efmls-configs.formatters.prettier_d')
-- local prettier_d_formatter = vim.tbl_extend('force', base_prettier_d_formatter, {
  -- formatCommand = 'yarn ' .. base_prettier_d_formatter.formatCommand .. ' --cache --cache-location .prettiercache',
-- })

local stylua = require('efmls-configs.formatters.stylua')

local jsTools = {
  eslint_d_linter,
  eslint_d_formatter,
  prettier_formatter,
  -- prettier_d_formatter,
}

local languages = {
  javascript = jsTools,
  typescript = jsTools,
  json = { prettier_formatter },
  jsonc = { prettier_formatter },
  -- json = { prettier_d_formatter },
  -- jsonc = { prettier_d_formatter },
  lua = { stylua },
}
-- printInspect(eslint_d_linter)
-- printInspect(eslint_d_formatter)
-- printInspect(prettier_formatter)
-- printInspect(prettier_d_formatter)

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require('efmls-configs.defaults').languages()

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    -- rootMarkers = { '.git/', 'yarn.lock' },
    rootMarkers = { '.git/' },
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

-- local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
-- vim.api.nvim_create_autocmd('BufWritePost', {
  -- group = lsp_fmt_group,
  -- callback = function(ev)
    -- local efm = vim.lsp.get_active_clients({ name = 'efm', bufnr = ev.buf })

    -- if vim.tbl_isempty(efm) then
      -- return
    -- end

    -- vim.lsp.buf.format({ name = 'efm' })
    -- vim.lsp.buf.format({  async = false, timeout_ms = 60000 })
  -- end,
-- })
