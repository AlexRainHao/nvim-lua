return {
  {
    'benomahony/uv.nvim',
    opts = {
      picker_integration = true,
      keymaps = {
        prefix = '<leader>u', -- Main prefix for uv commands
        commands = ';', -- Show uv commands menu (<leader>x)
        run_file = false, -- Run current file (<leader>xr)
        run_selection = false, -- Run selected code (<leader>xs)
        run_function = false, -- Run function (<leader>xf)
        venv = 'e', -- Environment management (<leader>xe)
        init = false, -- Initialize uv project (<leader>xi)
        add = false, -- Add a package (<leader>xa)
        remove = false, -- Remove a package (<leader>xd)
        sync = false, -- Sync packages (<leader>xc)
        sync_all = false, -- Sync all packages, extras and groups (<leader>xC)
      },
    },
  },
  {
    'alexpasmantier/pymple.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- optional (nicer ui)
      'stevearc/dressing.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    build = ':PympleBuild',
    config = function()
      require('pymple').setup({
        keymaps = {
          -- Resolves import for symbol under cursor.
          -- This will automatically find and add the corresponding import to
          -- the top of the file (below any existing doctsring)
          resolve_import_under_cursor = {
            desc = 'Resolve import under cursor',
            keys = '<M-CR>', -- feel free to change this to whatever you like
          },
        },
      })
    end,
  },
}
