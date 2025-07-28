local theme_config = {
  everforest = {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme everforest]])
    end,
  },
  onedark = {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup({
        style = 'warm',
      })
      -- Enable theme
      require('onedark').load()
    end,
  },
}

function determine_teme()
  local _prefer_theme = require('specific').prefer_theme

  if not theme_config[_prefer_theme] then
    error('theme ' .. _prefer_theme .. 'not supported')
  end

  return theme_config[_prefer_theme]
end

local M = {}

M.config = {
  { 'nvim-tree/nvim-web-devicons', opts = {} },
  { 'nvim-zh/colorful-winsep.nvim', config = true, event = { 'WinNew' } },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'rubiin/fortune.nvim',
      'AlexRainHao/cowsay-fortune.nvim',
    },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      -- dashboard.section.header.val = {
      --   '                                                     ',
      --   '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      --   '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      --   '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      --   '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      --   '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      --   '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      --   '                                                     ',
      dashboard.section.header.val = {
        '       ▄▀▀▀▀▀▀▀▀▀▀▄▄          ',
        '     ▄▀▀░░░░░░░░░░░░░▀▄        ',
        '   ▄▀░░░░░░░░░░░░░░░░░░▀▄      ',
        '   █░░░░░░░░░░░░░░░░░░░░░▀▄    ',
        '  ▐▌░░░░░░░░▄▄▄▄▄▄▄░░░░░░░▐▌   ',
        '  █░░░░░░░░░░░▄▄▄▄░░▀▀▀▀▀░░█   ',
        ' ▐▌░░░░░░░▀▀▀▀░░░░░▀▀▀▀▀░░░▐▌  ',
        ' █░░░░░░░░░▄▄▀▀▀▀▀░░░░▀▀▀▀▄░█  ',
        ' █░░░░░░░░░░░░░░░░▀░░░▐░░░░░▐▌ ',
        ' ▐▌░░░░░░░░░▐▀▀██▄░░░░░░▄▄▄░▐▌ ',
        '  █░░░░░░░░░░░▀▀▀░░░░░░▀▀██░░█ ',
        '  ▐▌░░░░▄░░░░░░░░░░░░░▌░░░░░░█ ',
        '   ▐▌░░▐░░░░░░░░░░░░░░▀▄░░░░░█ ',
        '    █░░░▌░░░░░░░░▐▀░░░░▄▀░░░▐▌ ',
        '    ▐▌░░▀▄░░░░░░░░▀░▀░▀▀░░░▄▀  ',
        '    ▐▌░░▐▀▄░░░░░░░░░░░░░░░░█   ',
        '    ▐▌░░░▌░▀▄░░░░▀▀▀▀▀▀░░░█    ',
        '    █░░░▀░░░░▀▄░░░░░░░░░░▄▀    ',
        '   ▐▌░░░░░░░░░░▀▄░░░░░░▄▀      ',
        '  ▄▀░░░▄▀░░░░░░░░▀▀▀▀█▀        ',
        ' ▀░░░▄▀░░░░░░░░░░▀░░░▀▀▀▀▄▄▄▄▄ ',
      }

      dashboard.section.buttons.val = {
        dashboard.button('e', '  New File    ', ':enew<CR>'),
        dashboard.button('r', '  Recent      ', ':Telescope oldfiles<CR>'),
        dashboard.button('c', '  NVIM Config ', ':e $MYVIMRC<CR>'),
        dashboard.button('q', '󰩈  Quit        ', ':qa<CR>'),
      }

      dashboard.section.footer.val = require('cowsay-fortune').cowsays()

      alpha.setup(dashboard.opts)
    end,
  },
  determine_teme(),
}

return M
