local lint = require('guard.lint')
local ft = require('guard.filetype')

local lint_eslint = {
  cmd = 'yarn',
  args = { 'eslint_d', '--format', 'json', '--stdin', '--stdin-filename' },
  stdin = true,
  fname = true,
  find = {
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
  },
  parse = lint.from_json({
    get_diagnostics = function(...) return vim.json.decode(...)[1].messages end,
    attributes = {
      lnum = 'line',
      end_lnum = 'endLine',
      col = 'column',
      end_col = 'endColumn',
      message = 'message',
      code = 'ruleId',
    },
    severities = {
      lint.severities.warning,
      lint.severities.error,
    },
    source = 'eslint_d',
  }),
}
local format_eslint = {
  cmd = 'yarn',
  args = { 'eslint_d', '--fix-to-stdout', '--stdin', '--stdin-filename' },
  fname = true,
  stdin = true,
  find = {
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
  },
}
local format_prettier = {
  cmd = 'yarn',
  args = { 'prettier', '--stdin-filepath' },
  fname = true,
  stdin = true,
  find = { '.prettierrc' },
}

-- Assuming you have guard-collection
ft('typescript,javascript,typescriptreact')
  :lint(lint_eslint)
  :fmt(format_eslint)
  :append(format_prettier)

-- Call setup() LAST!
require('guard').setup({
  -- the only options for the setup function
  fmt_on_save = true,
  -- Use lsp if no formatter was defined for this filetype
  lsp_as_default_formatter = false,
})
