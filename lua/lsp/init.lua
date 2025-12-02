local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('*', {
  capabilities = capabilities,
})

-- Configure diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'none', -- Changed from "rounded" to "none"
    source = 'if_many',
    header = '',
    prefix = '',
  },
})

-- Set up CursorHold autocommand to show diagnostics on hover
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float({
      focusable = false,
      close_events = {
        'BufLeave',
        'CursorMoved',
        'InsertEnter',
        'FocusLost',
      },
      border = 'rounded', -- Changed from "rounded" to "none"
      source = 'if_many',
      prefix = '',
    })
  end,
})

-- Set up LspAttach autocmd for per-buffer configuration
local autocomplete_configured = false
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Configure autocomplete once (not per buffer)
    if not autocomplete_configured then
      local ok, err = pcall(require('config.plugins.lsp').configfunc)
      if ok then
        autocomplete_configured = true
      else
        vim.notify(
          'Failed to configure autocomplete: ' .. tostring(err),
          vim.log.levels.ERROR
        )
      end
    end

    local ok, err = pcall(require('lsp.keymaps').setup, event.buf)
    if not ok then
      vim.notify(
        'Failed to setup LSP keymaps: ' .. tostring(err),
        vim.log.levels.ERROR
      )
    end
  end,
})

require('lsp.servers.misc').setup()
require('lsp.servers.lua').setup()
require('lsp.servers.python').setup()
require('lsp.servers.markdown').setup()
require('lsp.servers.typescript').setup()
require('lsp.servers.web').setup()
require('lsp.servers.vue').setup()
require('lsp.servers.go').setup()
require('lsp.servers.rust').setup()
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls',
    'pyright',
    'ruff',
    'marksman',
    'biome',
    'ts_ls',
    'eslint',
    'jsonls',
    'yamlls',
    'taplo',
    'html',
    'emmet_language_server',
    'cssls',
    'tailwindcss',
    'vue_ls',
    'gopls',
    'rust_analyzer',
  },
  automatic_enable = true,
})

require('mason-null-ls').setup({
  ensure_installed = {
    'prettierd',
    'markdownlint',
    'golines',
  },
  automatic_installation = true,
})

local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    -- Prettier formatter
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
        'css',
        'scss',
        'less',
        'html',
        'json',
        'jsonc',
        'yaml',
        'markdown',
        'graphql',
      },
      condition = function(utils)
        return utils.root_has_file({
          '.prettierrc',
          '.prettierrc.json',
          '.prettierrc.js',
          '.prettierrc.cjs',
          '.prettierrc.mjs',
          '.prettierrc.yml',
          '.prettierrc.yaml',
          '.prettierrc.toml',
          'prettier.config.js',
          'prettier.config.cjs',
          'prettier.config.mjs',
          -- 'package.json', -- Also check package.json for prettier config
        }) and utils.has_package_json_key('prettier')
      end,
    }),
    null_ls.builtins.formatting.markdownlint,
  },
})

-- format on save
local formatter_filetypes = {
  json = true,
  jsonc = true,
  yaml = true,
  toml = true,
  markdown = true,
  python = true,
  go = true,
  lua = true,
  html = true,
  css = true,
  javascript = true,
  typescript = true,
  typescriptreact = true,
  vue = true,
  rust = true,
}

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    if formatter_filetypes[vim.bo.filetype] then
      local lineno = vim.api.nvim_win_get_cursor(0)
      vim.lsp.buf.format({ async = false })
      pcall(vim.api.nvim_win_set_cursor, 0, lineno)
    end
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { 'source.organizeImports' } },
      apply = true,
    })
  end,
})
