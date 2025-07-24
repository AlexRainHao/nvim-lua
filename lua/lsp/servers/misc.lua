local M = {}

function M.setup()
  -- JSON Language Server
  vim.lsp.config("jsonls", {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    root_markers = { "package.json", ".git" },
    init_options = {
      provideFormatter = true,
    },
    settings = {
      json = {
        schemas = (function()
          local ok, schemastore = pcall(require, "schemastore")
          if ok then
            return schemastore.json.schemas()
          else
            return {}
          end
        end)(),
        validate = { enable = true },
      },
    },
  })

  -- YAML Language Server with CloudFormation support
  vim.lsp.config("yamlls", {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml", "yml", "yaml.docker-compose" },
    root_markers = { ".git" },
    settings = {
      redhat = {
        telemetry = {
          enabled = false,
        },
      },
      yaml = {
        schemaStore = {
          enable = true,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
        validate = true,
        customTags = {
          "!fn",
          "!And",
          "!If",
          "!Not",
          "!Equals",
          "!Or",
          "!FindInMap sequence",
          "!Base64",
          "!Cidr",
          "!Ref",
          "!Sub",
          "!GetAtt",
          "!GetAZs",
          "!ImportValue",
          "!Select",
          "!Split",
          "!Join sequence",
        },
      },
    },
  })

  -- TOML Language Server
  vim.lsp.config("taplo", {
    cmd = { "taplo", "lsp", "stdio" },
    filetypes = { "toml" },
    root_markers = { "Cargo.toml", "pyproject.toml", ".git" },
  })

  -- Enable the servers
  vim.lsp.enable("jsonls")
  vim.lsp.enable("yamlls")
  vim.lsp.enable("taplo")
end

return M
