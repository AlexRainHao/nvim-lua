local M = {}

function M.setup()
  -- TypeScript Language Server
  vim.lsp.config('ts_ls', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
    init_options = {
      preferences = {
        disableSuggestions = true,
      }
    },
    on_attach = function(client, bufnr)
      -- Disable formatting for ts_ls if not JavaScript file
      if client.name == "ts_ls" and vim.bo[bufnr].filetype ~= "javascript" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
      -- Disable semantic tokens
      client.server_capabilities.semanticTokensProvider = nil
    end,

    on_new_config = function(new_config, new_root_dir)
      new_config.init_options = new_config.init_options or {}
      new_config.init_options.plugins = new_config.init_options.plugins or {}
      table.insert(new_config.init_options.plugins, {
        name = "@vue/typescript-plugin",
        location = new_root_dir .. "/node_modules/@vue/typescript-plugin",
        languages = { "vue" }
      })
    end
  })

  -- Biome Language Server
  vim.lsp.config('biome', {
    cmd = { 'biome', 'lsp-proxy' },
    filetypes = { 'javascript', 'javascriptreact', 'json', 'jsonc', 'typescript', 'typescriptreact' },
    root_markers = { 'biome.json', 'biome.jsonc', '.git' },
  })

  -- ESLint Language Server
  vim.lsp.config('eslint', {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    root_markers = { '.eslintrc', '.eslintrc.js', '.eslintrc.cjs', '.eslintrc.yaml', '.eslintrc.yml', '.eslintrc.json', 'eslint.config.js', 'package.json', '.git' },
    settings = {
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = "separateLine"
        },
        showDocumentation = {
          enable = true
        }
      },
      codeActionOnSave = {
        enable = false,
        mode = "all"
      },
      experimental = {
        useFlatConfig = false
      },
      format = true,
      nodePath = "",
      onIgnoredFiles = "off",
      packageManager = "npm",
      problems = {
        shortenToSingleLine = false
      },
      quiet = false,
      rulesCustomizations = {},
      run = "onType",
      useESLintClass = false,
      validate = "on",
      workingDirectory = {
        mode = "location"
      }
    }
  })

  -- Enable the servers
  vim.lsp.enable('ts_ls')
  vim.lsp.enable('biome')
  vim.lsp.enable('eslint')
end

return M
