local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Configure diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»"
    },
  },
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "none", -- Changed from "rounded" to "none"
    source = "if_many",
    header = "",
    prefix = "",
  },
})

-- Set up CursorHold autocommand to show diagnostics on hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float({
      focusable = false,
      close_events = {
        "BufLeave",
        "CursorMoved",
        "InsertEnter",
        "FocusLost"
      },
      border = "none", -- Changed from "rounded" to "none"
      source = "if_many",
      prefix = "",
    })
  end
})

-- Set up LspAttach autocmd for per-buffer configuration
local autocomplete_configured = false
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    -- Configure autocomplete once (not per buffer)
    if not autocomplete_configured then
      local ok, err = pcall(require("config.plugins.lsp").configfunc)
      if ok then
        autocomplete_configured = true
      else
        vim.notify("Failed to configure autocomplete: " .. tostring(err), vim.log.levels.ERROR)
      end
    end
  end
})

require("lsp.servers.python").setup()
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright"
  },
  automatic_enable = true,
})
