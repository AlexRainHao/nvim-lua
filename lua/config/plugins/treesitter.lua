return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    priority = 1000,
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')
      local indent_disabled = {
        yaml = true,
        dart = true,
      }

      vim.opt.smartindent = false

      ts.setup()
      ts.install({
        'html',
        'css',
        'javascript',
        'typescript',
        'python',
        'c',
        'cpp',
        'bash',
        'go',
        'lua',
        'vim',
        'dockerfile',
        'json',
        'jsonc',
        'yaml',
        'toml',
        'markdown',
        'markdown_inline',
        'rust',
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('nvim-treesitter-setup', { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local filetype = vim.bo[bufnr].filetype

          pcall(vim.treesitter.start, bufnr)

          if not indent_disabled[filetype] then
            vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      local tscontext = require('treesitter-context')
      tscontext.setup({
        enable = true,
        max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit
        min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
        trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20,     -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
      vim.keymap.set('n', '[c', function()
        tscontext.go_to_context()
      end, { silent = true })
    end,
  },
  -- {
  --   'RRethy/nvim-treesitter-textsubjects',
  --   config = function()
  --     require('nvim-treesitter-textsubjects').configure({
  --       prev_selection = ',',
  --       keymaps = {
  --         ['.'] = 'textsubjects-smart',
  --         [';'] = 'textsubjects-container-outer',
  --         ['i;'] = 'textsubjects-container-inner',
  --       },
  --     })
  --   end,
  -- },
}
