return {
  {
    "pechorin/any-jump.vim",
    init = function()
      vim.g.any_jump_search_prefered_engine = "rg"
      vim.g.any_jump_disable_default_keybindings = 1
    end,
    keys = {
      { "<leader>j", mode = "n", ":AnyJump<CR>", desc = "Any jump" },
      {
        "<leader>j",
        mode = "x",
        ":AnyJumpVisual<CR>",
        desc = "Any jump visual",
      },
      { "go", mode = "n", ":AnyJumpBack<CR>", desc = "Any jump back" },
    },
    config = function()
      vim.g.any_jump_window_width_ratio = 0.8
      vim.g.any_jump_window_height_ratio = 0.8
    end,
  },
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>f",
        mode = "n",
        function()
          vim.cmd(":GrugFar")
        end,
        desc = "Project find and replace",
      },
      {
        "<leader>F",
        mode = "n",
        function()
          require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
        end,
        desc = "Project find and replace within current file",
      },
      {
        "<leader>vf",
        mode = { "n", "x" },
        function()
          require("grug-far").open({
            visualSelectionUsage = "operate-within-range",
          })
        end,
        desc = "Project find and replace within in visual block",
      },
    },
  },
}
