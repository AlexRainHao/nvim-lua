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

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server',
  languages = { 'vue' },
  configNamespace = 'typescript',
  enableForWorkspaceTypeScriptVersions = true,
}

local ts_on_attach = function(client)
  local existing_capabilities = client.server_capabilities

  existing_capabilities.documentFormattingProvider = nil

  if existing_capabilities == nil then
    return
  end

  if client.name == 'vtsls' then
    local existing_filters = existing_capabilities.workspace.fileOperations.didRename.filters or {}
    local new_glob = '**/*.{ts,cts,mts,tsx,js,cjs,mjs,jsx,vue}'

    for _, filter in ipairs(existing_filters) do
      if filter.pattern and filter.pattern.matches == 'file' then
        filter.pattern.glob = new_glob
        break
      end
    end

    existing_capabilities.workspace.fileOperations.didRename.filters = existing_filters
  end

  -- vue 3.0.3
  if vim.bo.filetype == 'vue' then
    existing_capabilities.semanticTokensProvider.full = false
  else
    existing_capabilities.semanticTokensProvider.full = true
  end
  return existing_capabilities
end

local ts_servers = {
  server_to_use = 'vtsls',

  ts_ls = {
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
    on_attach = ts_on_attach,
  },

  vtsls = {
    cmd = { 'vtsls', '--stdio' },
    filetypes = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
      javascript = { inlayHints = M.inlay_hints },
      typescript = { inlayHints = M.inlay_hints },
    },
    on_attach = ts_on_attach,
  }
}


function M.setup()
  -- TypeScript Language Server
  if ts_servers.server_to_use == 'ts_ls' then
    vim.lsp.config('ts_ls', ts_servers.ts_ls)
  else
    vim.lsp.config('vtsls', ts_servers.vtsls)
  end

  -- Biome Language Server
  vim.lsp.config('biome', {
    cmd = { 'biome', 'lsp-proxy' },
    filetypes = {
      'json',
      'jsonc',
      'biome.json',
      'biome.jsonc'
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

  vim.lsp.config('vue_ls', {
    cmd = { 'vue-language-server', '--stdio' },
    filetypes = { 'vue' },
    root_markers = { 'package.json' },
    on_init = function(client)
      local retries = 0

      ---@param _ lsp.ResponseError
      ---@param result any
      ---@param context lsp.HandlerContext
      local function typescriptHandler(_, result, context)
        local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })[1]
            or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })[1]
            or vim.lsp.get_clients({ bufnr = context.bufnr, name = 'typescript-tools' })[1]

        if not ts_client then
          -- there can sometimes be a short delay until `ts_ls`/`vtsls` are attached so we retry for a few times until it is ready
          if retries <= 10 then
            retries = retries + 1
            vim.defer_fn(function()
              typescriptHandler(_, result, context)
            end, 100)
          else
            vim.notify(
              'Could not find `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`.',
              vim.log.levels.ERROR
            )
          end
          return
        end

        local param = unpack(result)
        local id, command, payload = unpack(param)
        ts_client:exec_cmd({
          title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
          command = 'typescript.tsserverRequest',
          arguments = {
            command,
            payload,
          },
        }, { bufnr = context.bufnr }, function(_, r)
          local response_data = { { id, r and r.body } }
          ---@diagnostic disable-next-line: param-type-mismatch
          client:notify('tsserver/response', response_data)
        end)
      end

      client.handlers['tsserver/request'] = typescriptHandler
    end,
  })

  vim.lsp.enable(ts_servers.server_to_use)
  vim.lsp.enable({ 'vue_ls', 'biome', 'eslint' })
end

return M
