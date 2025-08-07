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
}
