return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme everforest]])
    end,
  },
  { "nvim-tree/nvim-web-devicons", opts = {} },
}
