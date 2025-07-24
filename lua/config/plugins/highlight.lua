return {
  {
    'kevinhwang91/nvim-hlslens',
    lazy = false,
    enabled = true,
    config = function()
      require('scrollbar.handlers.search').setup()

      require('hlslens').setup()

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        'n',
        'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        'n',
        'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        'n',
        '*',
        [[*<Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        'n',
        '#',
        [[#<Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        'n',
        'g*',
        [[g*<Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        'n',
        'g#',
        [[g#<Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )

      vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    dependencies = {
      'kevinhwang91/nvim-hlslens',
    },
    config = function()
      require('scrollbar.handlers.search').setup({})
      require('scrollbar.handlers.gitsigns').setup({})
      require('scrollbar').setup({
        show = true,
        handle = {
          text = ' ',
          color = '#928374',
          hide_if_all_visible = true,
        },
        marks = {
          Cursor = {
            text = '•',
            priority = 0,
            gui = nil,
            color = nil,
            cterm = nil,
            color_nr = nil, -- cterm
            highlight = 'Normal',
          },
          Search = { color = nil, highlight = 'Search' },
          Misc = { color = 'purple' },
        },
        handlers = {
          cursor = false,
          diagnostic = true,
          gitsigns = true,
          handle = true,
          search = true,
        },
      })
    end,
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        providers = {
          'regex',
        },
      })
      vim.cmd(
        'hi IlluminatedWordText guibg=#393e4d gui=underline cterm=underline'
      )
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('ibl').setup({})
    end,
  },
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      filetypes = { '*' },
      lazy_load = false,
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = true,
        AARRGGBB = false,
        css = false,
        css_fn = false,
        tailwind = true,
        mode = 'background',
        sass = { enable = false },
        virtualtext = '■',
      },
    },
  },
}
