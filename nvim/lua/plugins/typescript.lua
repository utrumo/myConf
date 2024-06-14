return {
  "neovim/nvim-lspconfig",
  opts = {
    -- inlay_hints = { enabled = false },
    servers = {
      vtsls = {
        settings = {
          typescript = {
            tsdk = "./.yarn/sdks/typescript/lib",
          },
        },
      },
    },
  },
}
