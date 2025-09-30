return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
      'fredrikaverpil/neotest-golang',
    },
    keys = {
      {
        '<NOP>',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Tests current file',
      },
      {
        '<NOP>',
        function()
          require('neotest').run.run(vim.fn.getcwd())
        end,
        desc = 'Tests project',
      },
      {
        '<NOP>',
        function()
          require('neotest').output.open({ enter = true })
        end,
        desc = 'Tests output',
      },
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-python')({
            dap = { justMyCode = false }, -- optional if using debugging
            runner = 'pytest',
            python = './.venv/bin/python',
            args = { '--color', 'yes', '-vv', '-s' },
          }),
        },
      })
      require('neotest').setup({
        adapters = {
          require('neotest-golang')({
            runner = 'go',
            go_test_args = {
              '-v',
              '-race',
              '-count=1',
            },
          }),
        },
      })
    end,
  },
}
