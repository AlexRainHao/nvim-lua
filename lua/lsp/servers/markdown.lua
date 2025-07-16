local M = {}

function M.setup()
  vim.lsp.config("marksman", {
    cmd = { "marksman", "server" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", ".marksman.toml" }, { upward = true })[1]),
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  })
end

return M
