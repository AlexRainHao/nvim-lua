return {
  "SirVer/ultisnips",
  event = { 'InsertEnter' },
  dependencies = {
    "honza/vim-snippets",
  },
  config = function()
    vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "~/.config/nvim/Ultisnips" }
  end
}
