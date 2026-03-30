return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    'numToStr/Comment.nvim',
    opts = {},
    -- event = 'BufRead',
    config = function()
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })

      vim.cmd([[
      nmap <Leader>/<Leader> gcc
      vmap <Leader>/ gc
    ]])
    end
  },
}
