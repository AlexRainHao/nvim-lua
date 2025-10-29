local mode_m = { noremap = true }

return {
  'ibhagwan/fzf-lua',
  lazy = true,
  keys = { '<c-f>' },
  config = function()
    local fzf = require('fzf-lua')

    vim.keymap.set('n', '<c-f>', function()
      fzf.grep({ search = '', fzf_opts = { ['--layout'] = 'default' } })
    end, mode_m)

    vim.keymap.set('x', '<c-f>', function()
      fzf.grep_visual({ fzf_opts = { ['--layout'] = 'default' } })
    end, mode_m)

    vim.keymap.set('n', '<c-s-k>', function()
      fzf.builtin()
    end, mode_m)

    fzf.setup({
      global_resume = true,
      global_resume_query = true,

      winopts = {
        height = 0.8,
        width = 0.8,
        vertical = 'down:45%',
        horizontal = 'right:60%',
        preview = {
          wrap = true,
        },
        hidden = 'nohidden',
      },

      keymap = {
        builtin = {
          ['<c-f>'] = 'toggle-fullscreen',
          ['<c-p>'] = 'toggle-preview',
          ['<c-d>'] = 'preview-page-down',
          ['<c-u>'] = 'preview-page-up',
        },
        fzf = {
          ['esc'] = 'abort',
          ['ctrl-r'] = 'unix-line-discard',
          ['ctrl-n'] = 'half-page-down',
          ['ctrl-i'] = 'half-page-up',
          ['ctrl-a'] = 'beginning-of-line',
          ['ctrl-e'] = 'end-of-line',
          ['ctrl-y'] = 'toggle-all',
        },
      },

      actions = {
        files = {
          ['ctrl-q'] = fzf.actions.file_sel_to_qf,
        },
      },

      previewers = {
        head = {
          cmd = 'head',
          args = nil,
        },
        git_diff = {
          cmd_deleted = 'git diff --color HEAD --',
          cmd_modified = 'git diff --color HEAD',
          cmd_untracked = 'git diff --color --no-index /dev/null',
          -- pager        = "delta",      -- if you have `delta` installed
        },
        man = {
          cmd = 'man -c %s | col -bx',
        },
        builtin = {
          syntax = true, -- preview syntax highlight?
          syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
          syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
          jump_to_line = true,
          title = false,
        },
      },

      files = {
        previewer = 'bat',
        prompt = 'Files❯ ',
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = '--color=never --type f --hidden --follow --exclude .git',
      },

      buffers = {
        prompt = 'Buffers❯ ',
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
      },

      grep = {
        rg_opts = '--color=always --line-number --column --smart-case --ignore-file=.fzfignore',
        previewer = 'builtin',
        jump_to_line = true,
      },
    })
  end,
}
