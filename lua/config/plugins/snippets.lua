return {
  "SirVer/ultisnips",
  event = { 'InsertEnter' },
  dependencies = {
    "honza/vim-snippets",
  },
  config = function()
    vim.g.UltiSnipsSnippetDirectories = { "UltiSnips", "vim-snippets", "~/.config/nvim/Ultisnips" }
  end
}
