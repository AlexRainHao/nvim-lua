return {
  {
    'gcmt/wildfire.vim',
    lazy = false,
    keys = {
      {
        '<leader>s',
        '<Plug>(wildfire-quick-select)',
        desc = 'Wildfire quick select',
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      local npairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')

      npairs.setup()

      npairs.add_rule(Rule('<', '>', {}))
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
