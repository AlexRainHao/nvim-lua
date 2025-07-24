local M = {}

function M.setup()
  vim.lsp.config("vue", {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = {
      "package.json",
      "vue.config.js",
      "vite.config.js",
      "nuxt.config.js",
      ".git",
      "tsconfig.json",
      "jsconfig.json",
    },
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  })

  vim.lsp.enable("vue")
end

return M
