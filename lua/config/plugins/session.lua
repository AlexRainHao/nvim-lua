return {
  'rmagatti/auto-session',
  lazy = false,
  init = function()
    vim.opt.sessionoptions:remove('folds')
  end,
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
    restore_error_handler = function(error_msg)
      if error_msg and error_msg:find('Parser could not be created', 1, true) then
        return true
      end

      return require('auto-session').default_restore_error_handler(error_msg)
    end,
  },
}
