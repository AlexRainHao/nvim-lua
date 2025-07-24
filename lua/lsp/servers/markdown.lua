local M = {}

function M.setup()
  vim.lsp.config("marksman", {
    cmd = { "marksman", "server" },
    root_dir = vim.fs.dirname(
      vim.fs.find({ ".git", ".marksman.toml" }, { upward = true })[1]
    ),
    single_file_support = true,
  })

  vim.lsp.enable("marksman")
end

return M
