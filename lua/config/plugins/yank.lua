return {
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      { 'kkharji/sqlite.lua', module = 'sqlite' },
    },
    config = function()
      vim.keymap.set('n', '<S-y>', ':Telescope neoclip<CR>', { noremap = true })

      require('neoclip').setup({
        history = 1000,
        enable_persistent_history = true,
        keys = {
          telescope = {
            i = {
              select = '<cr>',
              paste = '<cr>',
              paste_behind = '<c-p>',
              delete = '<c-d>',
              edit = '<c-e>',
              custom = {},
            },
          },
        },
      })

      require('telescope').load_extension('neoclip')
    end,
  },
  {
    'gbprod/substitute.nvim',
    config = function()
      local substitute = require('substitute')
      substitute.setup({
        -- on_substitute = require("yanky.integration").substitute(),
        highlight_substituted_text = {
          enabled = true,
          timer = 200,
        },
      })
      vim.keymap.set('n', 'gr', substitute.operator, { noremap = true })
      vim.keymap.set('n', 'griw', function()
        substitute.operator({ motion = 'iw' })
      end, { noremap = true })
      vim.keymap.set('n', 'grr', substitute.line, { noremap = true })
      vim.keymap.set('n', 'gr$', substitute.eol, { noremap = true })
      vim.keymap.set('x', 'gr', substitute.visual, { noremap = true })
    end,
  },
}
