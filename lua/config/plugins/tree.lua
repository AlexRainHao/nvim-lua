return {
  'nvim-tree/nvim-tree.lua',
  event = 'VeryLazy',
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<c-q>',
      '<cmd>NvimTreeToggle<cr>',
      desc = 'Toggle nvim tree',
    },
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require('nvim-tree').setup()
  end,
}
