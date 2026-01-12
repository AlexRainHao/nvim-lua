local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
      and vim.api
      .nvim_buf_get_lines(0, line - 1, line, true)[1]
      :sub(col, col)
      :match('%s')
      == nil
end

local function is_in_start_tag()
  -- It's okay to keep the default setting, `ignore_injections` to `true`
  -- It will just make everything inside script tag or style tag as `raw_text`
  local node = vim.treesitter.get_node()
  if not node then
    return false
  end
  local node_to_check = { 'start_tag', 'self_closing_tag', 'directive_attribute' }
  return vim.tbl_contains(node_to_check, node:type())
end

local M = {}


M.config = {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    after = 'SirVer/ultisnips',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, { name = 'lazydev', group_index = 0 })
    end,
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-calc',
      {
        'onsails/lspkind.nvim',
        lazy = false,
        config = function()
          require('lspkind').init()
        end,
      },
      {
        'quangnguyen30192/cmp-nvim-ultisnips',
        config = function()
          -- optional call to setup (see customization section)
          require('cmp_nvim_ultisnips').setup({})
        end,
      },
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      {
        'xzbdmw/colorful-menu.nvim',
        opts = {
          ls = {
            fallback = false,
            vtsls = {
              extra_info_hl = false,
            },
            ts_ls = {
              extra_info_hl = false,
            },
          },
        },
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }
  },
  {
    'mason-org/mason-lspconfig.nvim',
    lazy = false,
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig'
    },
    opts = {
      ensure_installed = {
        'lua_ls',
        'pyright',
        'ruff',
        'marksman',
        'biome',
        'vtsls',
        'eslint',
        'jsonls',
        'yamlls',
        'taplo',
        'html',
        'emmet_language_server',
        'cssls',
        'tailwindcss',
        'vue_ls',
        'gopls',
        'rust_analyzer',
      },
      automatic_enable = true,
    },
  },
  {
    'b0o/schemastore.nvim',
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    config = function()
      require('lsp_signature').setup({
        bind = true,
        handler_opts = {
          border = 'rounded',
        },
      })
      vim.keymap.set({ 'n', 'i' }, '<c-k>', function()
        require('lsp_signature').toggle_float_win()
      end, { silent = true, noremap = true, desc = 'toggle signature' })
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    dependencies = { 'mason.nvim', 'nvimtools/none-ls.nvim' },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = {
          'prettierd',
          'markdownlint',
          'golines',
        },
        automatic_installation = true
      })
    end
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require('null-ls')
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.golines,
          null_ls.builtins.formatting.prettierd.with({
            condition = function(utils)
              return utils.root_has_file({
                '.prettierrc',
                '.prettierrc.json',
                '.prettierrc.js',
                '.prettierrc.cjs',
                '.prettierrc.mjs',
                '.prettierrc.yml',
                '.prettierrc.yaml',
                '.prettierrc.toml',
                'prettier.config.js',
                'prettier.config.cjs',
                'prettier.config.mjs',
              }) and utils.has_package_json_key('prettier')
            end,
          }),
          null_ls.builtins.formatting.markdownlint,
        },
      })
    end
  },
  {
    'folke/trouble.nvim',
    keys = {
      {
        '<NOP>',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Toggle trouble',
      },
      {
        '<NOP>',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Toggle buffer trouble',
      },
    },
    cmd = 'Trouble',
    opts = {
      use_diagnostic_signs = true,
      win = { position = 'right', size = 0.3 },
      focus = true,
      pinned = true,
      keys = {
        ['<esc>'] = 'close',
        k = 'prev',
        j = 'next',
        o = 'jump',
      },
    },
  },
  {
    'simrat39/symbols-outline.nvim',
    keys = {
      {
        '<c-s>',
        function()
          require('symbols-outline').toggle_outline()
        end,
        '<cmd>SymbolsOutline<cr>',
        mode = 'n',
        desc = 'Toggle symbols',
      },
    },
    config = function()
      require('symbols-outline').setup()
    end,
  },
  {
    'danymat/neogen',
    keys = {
      {
        -- '<leader>nf',
        '<leader>//',
        function()
          require('neogen').generate()
        end,
        mode = 'n',
        silent = true,
      },
    },
    config = true,
  },
}

M.configfunc = function()
  local lspkind = require('lspkind')
  local cmp = require('cmp')
  local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')
  local types = require('cmp.types')

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        -- luasnip.lsp_expand(args.body)
        vim.fn['UltiSnips#Anon'](args.body)
      end,
    },
    window = {
      completion = {
        col_offset = -3,
        side_padding = 0,
      },
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      maxwidth = 60,
      maxheight = 10,
      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({
          mode = 'symbol_text',
          symbol_map = {
            Codeium = '',
            TypeParameter = '',
          },
        })(entry, vim_item)

        local strings = vim.split(kind.kind, '%s', { trimempty = true })
        kind.kind = ' ' .. (strings[1] or '') .. ' '
        kind.menu = '    (' .. (strings[2] or '') .. ')'

        return kind
      end,
    },
    sources = cmp.config.sources({
        {
          name = 'nvim_lsp',
          entry_filter = function(entry, ctx)
            if ctx.filetype ~= 'vue' then
              return true
            end

            local bufnr = ctx.bufnr
            local cached_is_in_start_tag = vim.b[bufnr]._vue_ts_cached_is_in_start_tag
            if cached_is_in_start_tag == nil then
              vim.b[bufnr]._vue_ts_cached_is_in_start_tag = is_in_start_tag()
            end
            -- If not in start tag, return true
            if vim.b[bufnr]._vue_ts_cached_is_in_start_tag == false then
              return true
            end

            local cursor_before_line = ctx.cursor_before_line
            if cursor_before_line:sub(-1) == '@' then
              return entry.completion_item.label:match('^@')
            elseif cursor_before_line:sub(-1) == ':' then
              return entry.completion_item.label:match('^:') and not entry.completion_item.label:match('^:on%-')
              -- For slot
            elseif cursor_before_line:sub(-1) == '#' then
              return entry.completion_item.kind == types.lsp.CompletionItemKind.Method
            else
              return true
            end
          end
        },
        { name = 'buffer' },
        { name = 'ultisnips' },
      },
      {
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'calc' },
      }),
    mapping = cmp.mapping.preset.insert({
      ['<c-n>'] = cmp.config.disable,
      ['<c-p>'] = cmp.config.disable,
      ['<c-e>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.close()
        else
          cmp.complete()
        end
      end, { 'i' }),
      ['<c-j>'] = cmp.mapping.select_next_item(
        { behavior = cmp.SelectBehavior.Select },
        { 'i' }
      ),
      ['<c-k>'] = cmp.mapping.select_prev_item(
        { behavior = cmp.SelectBehavior.Select },
        { 'i' }
      ),
      ['<c-[>'] = cmp.mapping({
        i = function(fallback)
          cmp.close()
          fallback()
        end,
      }),
      ['<c-y>'] = cmp.mapping({
        i = function(fallback)
          fallback()
        end,
      }),
      ['<c-u>'] = cmp.mapping({
        i = function(fallback)
          fallback()
        end,
      }),
      ['<CR>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          else
            fallback()
          end
        end,
      }),
      ['<Tab>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.select_next_item({
              behavior = cmp.SelectBehavior.Insert,
            })
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end,
      }),
      ['<S-Tab>'] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({
              behavior = cmp.SelectBehavior.Insert,
            })
          else
            fallback()
          end
        end,
      }),
    }),
  })
end

return M
