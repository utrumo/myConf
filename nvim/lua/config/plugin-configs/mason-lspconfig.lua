local masonLspConfig = require('mason-lspconfig')
local lspConfig = require('lspconfig')

local on_attach = function(client, bufnr)
  vim.api.nvim_create_autocmd('CursorHold', {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end

masonLspConfig
  .setup({
    ensure_installed = { 'vimls', 'lua_ls', 'tsserver' },
  })
  .setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      lspConfig[server_name].setup({
        on_attach = on_attach,
      })
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    -- ['rust_analyzer'] = function() require('rust-tools').setup({}) end,
  })
