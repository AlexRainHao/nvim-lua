return {
  "SirVer/ultisnips",
  dependencies = {
    "honza/vim-snippets",
  },
  config = function()
    vim.g.UltiSnipsSnippetDirectories = { "Ultisnips", "~/.config/nvim/Ultisnips" }
  end
}
