local theme_config = {
  everforest = {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('everforest').load()
    end,
  },
  onedark = {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local onedark = require('onedark')

      onedark.setup({ style = 'warm' })
      -- Enable theme
      onedark.load()
    end,
  },
  vitesse = {
    '2nthony/vitesse.nvim',
    dependencies = {
      'tjdevries/colorbuddy.nvim',
    },
    config = function()
      require('vitesse').load()
    end,
  },
  gruvbox = {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').load()
    end,
  },
  kanagawa = {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').load('wave')
    end,
  },
  gruvbox_material = {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_background = 'soft'
      vim.g.gruvbox_material_enable_italic = true
      vim.cmd.colorscheme('gruvbox-material')
    end
  }
}

local function determine_teme()
  local _prefer_theme = require('specific').prefer_theme

  if not theme_config[_prefer_theme] then
    error('theme ' .. _prefer_theme .. 'not supported')
  end

  vim.o.background = 'dark'

  return theme_config[_prefer_theme]
end

local M = {}

M.config = {
  { 'nvim-tree/nvim-web-devicons',  opts = {} },
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
      -- }
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
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      vim.notify = notify

      notify.setup({
        render = 'compact',
        stages = 'fade',
        timeout = 3000,
        top_down = true,
      })

      require('commander').add({
        {
          desc = 'Open Notifications',
          cmd = function()
            require('telescope').extensions.notify.notify({
              layout_strategy = 'vertical',
              wrap_results = true,
              previewer = false,
            })
          end,
        },
        {
          desc = 'Clear Notifications',
          cmd = notify.clear_history,
        },
      })

      vim.keymap.set(
        'n',
        '<leader>n;',
        notify.dismiss,
        { noremap = true, silent = true }
      )
    end,
  },
}

return M
