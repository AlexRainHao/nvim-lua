local M = {}

M.inlay_hints = {
  includeInlayEnumMemberValueHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayParameterNameHints = 'all',
  includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayVariableTypeHints = true,
}

function M.setup()
  local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server',
    languages = { 'vue' },
    configNamespace = 'typescript',
    enableForWorkspaceTypeScriptVersions = true,
  }

  vim.lsp.config('vue_ls', {
    -- cmd = { 'vue-language-server', '--stdio' },
    init_options = {
      vue = {
        hybridMode = true,
      }
    },
    on_attach = function(client, _)
      client.server_capabilities.documentFormattingProvider = nil
    end
  })

  -- TypeScript Language Server
  vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
    },
    root_markers = {
      'package.json',
      'tsconfig.json',
      'jsconfig.json',
      'nuxt.config.ts',
      'vite.config.ts',
      '.git',
    },
    settings = {
      javascript = { inlayHints = M.inlay_hints },
      typescript = { inlayHints = M.inlay_hints },
    },
    init_options = {
      plugins = {
        vue_plugin,
      },
      preferences = {
        disableSuggestions = true,
      },
    },
    on_attach = function(client, bufnr)
      -- Disable formatting for ts_ls if not JavaScript file
      if client.name == 'ts_ls' and vim.bo[bufnr].filetype ~= 'javascript' then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end

      -- Disable semantic tokens
      client.server_capabilities.semanticTokensProvider = nil
    end,
  })

  -- Biome Language Server
  vim.lsp.config('biome', {
    cmd = { 'biome', 'lsp-proxy' },
    filetypes = {
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'typescript',
      'typescriptreact',
    },
    root_markers = { 'biome.json', 'biome.jsonc', '.git' },
  })

  -- ESLint Language Server
  vim.lsp.config('eslint', {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
    },
    root_markers = {
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.cjs',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      '.eslintrc.json',
      'eslint.config.js',
      'eslint.config.mjs',
      'package.json',
      '.git',
    },
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = 'separateLine',
        },
        showDocumentation = {
          enable = true,
        },
      },
      codeActionOnSave = {
        enable = true,
        mode = 'all',
      },
      experimental = {
        useFlatConfig = true,
      },
      format = true,
      autoFixOnSave = true,
      nodePath = '',
      onIgnoredFiles = 'off',
      packageManager = 'npm',
      problems = {
        shortenToSingleLine = false,
      },
      quiet = false,
      rulesCustomizations = {},
      run = 'onType',
      useESLintClass = false,
      validate = 'on',
      workingDirectory = {
        mode = 'location',
      },
    },
  })

  -- Enable the servers
  vim.lsp.enable({ 'ts_ls', 'biome', 'eslint' })
end

return M
