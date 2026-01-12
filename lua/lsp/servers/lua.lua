local M = {}

function M.setup()
  -- Define configuration for lua-language-server
  vim.lsp.config('luals', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {
            'vim',
            'require',
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
        completion = {
          callSnippet = 'Replace',
        },
        format = {
          enable = true,
          defaultConfig = {
            indent_style = 'space',
            indent_size = '2',
            quote_style = 'single',
            call_arg_parentheses = 'keep',
            detect_end_of_line = 'true',
            max_line_width = '80',
            end_of_line = 'lf'
          },
        },
      },
    },
  })
end

return M
