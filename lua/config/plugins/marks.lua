return {
  {
    enabled = false,
    'EvWilson/spelunk.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      'nvim-treesitter/nvim-treesitter',
      'nvim-lualine/lualine.nvim',
    },
    config = function()
      require('spelunk').setup({
        enable_persist = true
      })
    end
  },
  {
    'LintaoAmons/bookmarks.nvim',
    dependencies = {
      { 'kkharji/sqlite.lua',           module = 'sqlite' },
      { 'nvim-telescope/telescope.nvim' },
      { 'stevearc/dressing.nvim' },
    },
    keys = {
      {
        'mm',
        '<cmd>BookmarksMark<cr>',
        desc = 'Mark current line',
        mode = 'n'
      },
      {
        'mt',
        '<cmd>BookmarksTree<cr>',
        desc = 'Toggle bookmarks tree',
        mode = 'n'
      }
    },
    config = function()
      local opts = {
        treeview = {
          active_list_icon = '👉 ',
        },
      }
      require('bookmarks').setup(opts)
    end,
  }
}
