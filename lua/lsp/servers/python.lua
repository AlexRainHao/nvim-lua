local M = {}

function M.setup()
  vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
      '.git',
    },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
          reportMissingImports = true,
        },
      },
    },
  })

  vim.lsp.config('ruff', {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'ruff.toml',
      '.ruff.toml',
      '.git',
    },
    settings = {
      organizeImports = true,
      fixAll = true,
      lint = {
        enable = true,
      },
    },
    -- disable hover to avoid conflicts with pyright
    capabilities = {
      hoverProvider = false,
    },
  })

  vim.lsp.enable('pyright')
  vim.lsp.enable('ruff')
end

return M
