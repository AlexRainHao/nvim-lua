return {
  'ray-x/go.nvim',
  dependencies = {
    'ray-x/guihua.lua',
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
    'FeiyouG/commander.nvim',
  },
  config = function()
    require('go').setup({
      gofmt = 'golines',
      max_line_len = 80,
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      callback = function()
        require('go.format').goimport()
      end,
      group = vim.api.nvim_create_augroup('GoImport', {}),
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*.go',
      callback = function()
        require('go.format').gofmt()
      end,
      group = vim.api.nvim_create_augroup('GoFormat', {}),
    })

    local commander = require('commander')

    commander.add({
      {
        desc = 'Go Add json Tag',
        cmd = '<CMD>GoAddTag json<CR>',
      },
      {
        desc = 'Go Remove json Tag',
        cmd = '<CMD>GoRmTag json',
      },
      {
        desc = 'Go Add yaml Tag',
        cmd = '<CMD>GoAddTag yaml<CR>',
      },
      {
        desc = 'Go Remove yaml Tag',
        cmd = '<CMD>GoRmTag yaml',
      },
      {
        desc = 'Go Fill Struct',
        cmd = '<CMD>GoFillStruct<CR>',
      },
    })
  end,
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
