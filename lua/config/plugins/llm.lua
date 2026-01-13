local prefer_llm = require('specific').prefer_llm
return {
  {
    'yetone/avante.nvim',
    enabled = false,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- ⚠️ must add this setting! ! !
    build = vim.fn.has('win32') ~= 0
        and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
        or 'make',
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      -- add any opts here
      -- this file can contain specific instructions for your project
      instructions_file = 'avante.md',
      provider = prefer_llm.adapter,
      providers = {
        deepseek = {
          __inherited_from = 'openai',
          api_key_name = 'DEEPSEEK_API_KEY',
          endpoint = os.getenv('DEEPSEEK_API_ENDPOINT'),
          model = os.getenv('DEEPSEEK_API_V3_MODEL'),
          extra_request_body = {
            temperature = 0,
            max_tokens = 8192,
          },
        },
      },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
      'hrsh7th/nvim-cmp',              -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua',              -- for file_selector provider fzf
      'stevearc/dressing.nvim',        -- for input provider dressing
      'nvim-tree/nvim-web-devicons',   -- or echasnovski/mini.icons
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
      'nvim-treesitter/nvim-treesitter',
      'ravitemer/mcphub.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
      'HakonHarnes/img-clip.nvim'
    },
    config = function()
      require('codecompanion').setup({
        interactions = {
          chat = prefer_llm,
          inline = prefer_llm,
          cmd = prefer_llm,
          background = prefer_llm,
        },
        adapters = {
          http = {
            deepseek = function()
              return require('codecompanion.adapters').extend('deepseek', {
                url = vim.env.DEEPSEEK_API_ENDPOINT,
                env = {
                  api_key = 'DEEPSEEK_API_KEY'
                },
                schema = {
                  model = {
                    default = vim.env.DEEPSEEK_API_V3_MODEL,
                    choices = {
                      [vim.env.DEEPSEEK_API_V3_MODEL] = { formatted_name = 'DeepSeek V3', opts = { can_use_tools = true } },
                    },
                  }
                }
              })
            end
          }
        }
      })
    end
  },
}
