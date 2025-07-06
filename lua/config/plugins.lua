local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("config.plugins.everforest"),
  require("config.plugins.telescope").config,
  require("config.plugins.fzf"),
  require("config.plugins.bufferline"),
  require("config.plugins.comment"),
  require("config.plugins.dropbar"),
  require("config.plugins.wilder"),
  require("config.plugins.yank"),
  require("config.plugins.gitsign"),
  require("config.plugins.highlight"),
  require("config.plugins.treesitter"),
  require("config.plugins.pair"),
  require("config.plugins.lualine"),
})
