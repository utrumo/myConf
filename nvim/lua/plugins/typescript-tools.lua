return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        tsserver = {
          autostart = false,
        },
      },
    },
    keys = {
      {
        "<leader>k",
        function()
          vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
        end,
        desc = "Toggle inlay hints",
      },
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        -- https://github.com/microsoft/TypeScript/blob/v5.3.3/src/server/protocol.ts#L3518
        tsserver_file_preferences = {
          -- disableSuggestions = false,
          -- quotePreference = "auto",
          -- includeCompletionsForModuleExports = true,
          -- includeCompletionsForImportStatements = true,
          -- includeCompletionsWithSnippetText = true,
          -- includeCompletionsWithInsertText = true,
          -- includeAutomaticOptionalChainCompletions = true,
          -- includeCompletionsWithClassMemberSnippets = true,
          -- includeCompletionsWithObjectLiteralMethodSnippets = true,
          -- useLabelDetailsInCompletionEntries = true,
          -- allowIncompleteCompletions = true,
          -- importModuleSpecifierPreference = "shortest",
          -- importModuleSpecifierEnding = "auto",
          -- allowTextChangesInNewFiles = true,
          -- lazyConfiguredProjectsFromExternalProject = true,
          -- providePrefixAndSuffixTextForRename = true,
          -- provideRefactorNotApplicableReason = true,
          -- allowRenameOfImportPath = true,
          -- includePackageJsonAutoImports = 'auto',
          -- jsxAttributeCompletionStyle = 'auto',
          -- displayPartsForJSDoc = true,
          -- generateReturnInDocTemplate = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
          -- interactiveInlayHints = true, unsupported by project 5.2 ts
          -- organizeImportsIgnoreCase = true,
          -- organizeImportsCollation = 'ordinal',
          -- organizeImportsCollationLocale = 'en',
          -- organizeImportsNumericCollation = false,
          -- organizeImportsAccentCollation = true,
          -- organizeImportsCaseFirst = false,
          -- disableLineTextInReferences = true,
          -- excludeLibrarySymbolsInNavTo = true,
        },
        -- https://github.com/microsoft/TypeScript/blob/v5.3.3/src/server/protocol.ts#L3496
        -- tsserver_format_options = {
        --   allowIncompleteCompletions = false,
        --   allowRenameOfImportPath = false,
        -- },
        -- code_lens = "all",
        -- disable_member_code_lens = false,
      },
    },
  },
}
