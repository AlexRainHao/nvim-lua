local M = {}

function M.setup()
  -- Rust Language Server
  vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markeres = { 'Cargo.toml', '.git' },
    single_file_support = true,
    on_attach = function(_, bufnr)
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
      ['rust-analyzer'] = {
        imports = {
          granularity = {
            group = 'module',
          },
          prefix = 'self',
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
          autoreload = true,
        },
        procMacro = {
          enable = true,
        },
        diagnostics = {
          enable = true,
        },
      },
    },
  })

  -- Enable the servers
  vim.lsp.enable('rust_analyzer')
end

return M
