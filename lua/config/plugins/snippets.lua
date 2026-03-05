return {
  {
    'SirVer/ultisnips',
    event = { 'InsertEnter' },
    dependencies = {
      'honza/vim-snippets',
    },
    config = function()
      vim.g.UltiSnipsSnippetDirectories = {
        'UltiSnips',
        'vim-snippets',
        '~/.config/nvim/Ultisnips',
      }
    end,
  },
  {
    'kkoomen/vim-doge',
    build = ':call doge#install()',
    config = function()
      vim.g.doge_mapping = '<Leader>d'
      vim.g.doge_doc_standard_python = 'google'
    end,
  },
}
