return {
  {
    'SUSTech-data/wildfire.nvim',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('wildfire').setup({
        keymaps = {
          init_selection = '<c-n>',
          node_incremental = '<c-n>',
          ndoe_decremental = '<c-l>',
        },
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      local npairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')

      npairs.setup()

      npairs.add_rule(
        Rule('<', '>', { 'html', 'vue', 'cpp', 'typescript', 'javascript' })
      )
    end,
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({})
    end,
  },
}
