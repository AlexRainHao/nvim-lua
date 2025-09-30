return {
  {
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
  },
  {
    'wintermute-cell/gitignore.nvim',
    keys = {
      {
        '<NOP>',
        mode = 'n',
        function()
          require('gitignore').generate(vim.fn.expand('%:p:h'))
        end,
        desc = 'Add gitignore',
      },
    },
    config = function()
      vim.g.gitignore_nvim_overwrite = false
      require('gitignore')
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = { 'LazyGit' },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
    config = function()
      vim.api.nvim_create_autocmd('TermEnter', {
        pattern = '*',
        callback = function()
          local name = vim.api.nvim_buf_get_name(0)
          if string.find(name, 'lazygit') then
            vim.keymap.set('t', '<ESC>', function()
              -- Get the terminal job ID for the current buffer
              local bufnr = vim.api.nvim_get_current_buf()
              local chan = vim.b[bufnr].terminal_job_id
              if chan then
                -- Send the ESC key sequence to the terminal
                -- "\x1b" is the escape character
                vim.api.nvim_chan_send(chan, '\x1b')
              end
            end, { buffer = true })
            return
          end
        end,
      })
    end,
  },
}
