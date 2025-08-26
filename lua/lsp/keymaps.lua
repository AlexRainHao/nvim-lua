local M = {}

function M.setup_global() end

function M.setup(bufnr)
  bufnr = bufnr or 0 -- Default to current buffer if not provided
  local opts = { buffer = bufnr, noremap = true, silent = true }

  -- Definitions, references, etc.
  vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set(
    'n',
    'gD',
    ':tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>',
    opts
  )
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  -- vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, opts)

  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<c-,>', vim.lsp.buf.code_action, opts)

  -- formatting
  vim.keymap.set('n', '<leader>ff', function()
    vim.lsp.buf.format({ async = true })
    local gof = vim.api.nvim_buf_get_name(0)
    if string.match(gof, '(.go)$') then
      require('go.format').gofmt()
    end
  end, opts)

  ----------------------------------------
  --- uni-tset
  local neotest = require('neotest')
  vim.keymap.set('n', '<leader>tc', function()
    neotest.run.run()
  end, { desc = 'Run nearest test' })

  vim.keymap.set('n', '<leader>tf', function()
    neotest.run.run(vim.fn.expand('%'))
  end, { desc = 'Run file tests' })

  vim.keymap.set('n', '<leader>ta', function()
    neotest.run.run(vim.fn.getcwd())
  end, { desc = 'Run all tests' })

  vim.keymap.set('n', '<leader>to', function()
    neotest.output.open({ enter = true })
  end, { desc = 'Show test output' })
  ----------------------------------------
end

return M
