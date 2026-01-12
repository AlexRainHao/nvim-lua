local M = {}

function M.setup_global() end

local function select_formatter(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local formatters = {}

  for _, c in pairs(clients) do
    if c.server_capabilities.documentFormattingProvider then
      table.insert(formatters, c.name)
    end
  end

  if #formatters > 1 then
    vim.ui.select(formatters, { prompt = 'Select a formatter' }, function(_, choice)
      if not choice then
        print('No formatter selected')
        return
      end

      local formatter = formatters[choice]
      vim.lsp.buf.format({ async = true, name = formatter })
    end)
  else
    vim.lsp.buf.format({ async = true, name = formatters[1] })
  end
end


local commander = require('commander')

commander.add({
  {
    desc = 'Select Formatter',
    cmd = function()
      select_formatter(vim.api.nvim_get_current_buf())
    end
  },
})

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
  vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
  -- vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, opts)

  vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<c-,>', vim.lsp.buf.code_action, opts)

  -- formatting
  vim.keymap.set('n', '<leader>ff', function()
    vim.lsp.buf.format({ async = true })
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
