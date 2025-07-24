return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '▎' },
        change = { text = '░' },
        delete = { text = '_' },
        topdelete = { text = '▔' },
        changedelete = { text = '▒' },
        untracked = { text = '┆' },
      },
    })

    vim.keymap.set(
      'n',
      '<Leader>g<',
      ':Gitsigns prev_hunk<CR>',
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      'n',
      '<Leader>g>',
      ':Gitsigns next_hunk<CR>',
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      'n',
      '<Leader>gc',
      ':Gitsigns blame_line<CR>',
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      'n',
      '<Leader>gr',
      ':Gitsigns reset_hunk<CR>',
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      'n',
      '<Leader>gh',
      ':Gitsigns preview_hunk<CR>',
      { noremap = true, silent = true }
    )
  end,
}
