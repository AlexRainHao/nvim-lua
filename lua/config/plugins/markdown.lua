return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    'instant-markdown/vim-instant-markdown',
    lazy = true,
    event = 'VeryLazy',
    keys = {
      {
        '<NOP>',
        mode = 'n',
        ':InstantMarkdownPreview<CR>',
        desc = 'Instant Markdown Preview',
      },
    },
    ft = { 'markdown' },
    config = function()
      vim.g.instant_markdown_autostart = 0
      vim.g.instant_markdown_open_to_the_world = 1
      vim.g.instant_markdown_mermaid = 1
      vim.g.instant_markdown_autoscroll = 1
      vim.g.instant_markdown_theme = 'dark'
      vim.g.instant_markdown_logfile = '/tmp/instant_markdown.log'
    end,
  },
}
