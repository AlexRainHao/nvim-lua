return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    {
      '<NOP>',
      '<CMD>SessionSearch<CR>',
      mode = 'n',
      desc = 'Toggle Session Search',
    },
  },
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
  },
}
