return {
  {
    'akinsho/toggleterm.nvim',
    lazy = false,
    config = function()
      require('toggleterm').setup({
        size = function(term)
          if term.direction == 'horizontal' then
            return 15
          elseif term.direction == 'vertical' then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<c-`>]],
        start_in_insert = false,
      })
    end,
    keys = {
      {
        '<C-`>',
        mode = 'n',
        ':TermNew<CR>',
        desc = 'Toggle or first new terminal',
      },
      {
        '<leader>sn',
        mode = 'n',
        ':TermNew<CR>',
        desc = 'New terminal',
      },
      {
        '<NOP>',
        mode = 'n',
        ':ToggleTerm direction=horizontal<CR>',
        desc = 'Toggle terminal horizontal',
      },
      {
        '<NOP>',
        mode = 'n',
        ':ToggleTerm direction=vertical<CR>',
        desc = 'Toggle terminal vertical',
      },
      {
        '<NOP>',
        mode = 'n',
        ':TermNew direction=tab<CR>',
        desc = 'New terminal tab',
      },
      {
        '<leader>sf',
        mode = 'n',
        ':TermNew direction=float<CR>',
        desc = 'New terminal float',
      },
      {
        '<leader>ss',
        mode = 'n',
        ':TermSelect<CR>',
        desc = 'Select terminals',
      },
    },
  },
}
