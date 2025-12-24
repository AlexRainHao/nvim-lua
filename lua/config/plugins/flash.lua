return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      labels = 'asdfghjklqwertyuiopzxcvbnm',
      search = {
        -- search/jump in all windows
        multi_window = true,
        -- search direction
        forward = true,
        -- when `false`, find only matches in the given direction
        wrap = true,
        -- Each mode will take ignorecase and smartcase into account.
        -- * exact: exact match
        -- * search: regular search
        -- * fuzzy: fuzzy search
        mode = 'fuzzy',
      },
      jump = {
        jumplist = true,
        pos = 'start', ---@type "start" | "end" | "range"
        history = false,
        register = false,
        nohlsearch = false,
        autojump = false,
        inclusive = nil, ---@type boolean?
      },
      label = {
        uppercase = false,
        exclude = '',
        current = false,
        -- show the label after the match
        after = true, ---@type boolean|number[]
        -- show the label before the match
        before = false, ---@type boolean|number[]
        -- position of the label extmark
        style = 'inline', ---@type "eol" | "overlay" | "right_align" | "inline"
        -- flash tries to re-use labels that were already assigned to a position,
        -- when typing more characters. By default only lower-case labels are re-used.
        reuse = 'all', ---@type "lowercase" | "all"
        -- for the current window, label targets closer to the cursor first
        distance = true,
        -- minimum pattern length to show labels
        -- Ignored for custom labelers.
        min_pattern_length = 0,
        -- Enable this to use rainbow colors to highlight labels
        -- Can be useful for visualizing Treesitter ranges.
        rainbow = {
          enabled = true,
          -- number between 1 and 9
          shade = 8,
        },
      },
      -- highlight = {
      --     -- show a backdrop with hl FlashBackdrop
      --     backdrop = true,
      --     -- Highlight the search matches
      --     matches = true,
      --     -- extmark priority
      --     priority = 5000,
      --     groups = {
      --         match = "FlashMatch",
      --         current = "FlashCurrent",
      --         backdrop = "FlashBackdrop",
      --         label = "FlashLabel",
      --     },
      -- },
      modes = {
        search = {
          enabled = false,
        },
        char = {
          enabled = false,
        },
        treesitter = {
          labels = 'asdfghjklqwertyuiopzxcvbnm',
          jump = { pos = 'range' },
          search = { incremental = false },
          label = { before = true, after = true, style = 'inline' },
          highlight = {
            backdrop = false,
            matches = false,
          },
        },
        treesitter_search = {
          jump = { pos = 'range' },
          search = {
            multi_window = true,
            wrap = true,
            incremental = false,
          },
          remote_op = { restore = true },
          label = { before = true, after = true, style = 'inline' },
        },
        -- options used for remote flash
        remote = {
          remote_op = { restore = true, motion = true },
        },
      },
      prompt = {
        enabled = true,
        prefix = { { '⚡', 'FlashPromptIcon' } },
        win_config = {
          relative = 'editor',
          width = 1, -- when <=1 it's a percentage of the editor width
          height = 1,
          row = -1,  -- when negative it's an offset from the bottom
          col = 0,   -- when negative it's an offset from the right
          zindex = 1000,
        },
      },
    },
    keys = {
      {
        't',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'e',
        mode = { 'n', 'o' },
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'T',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'E',
        mode = { 'o', 'x', 'n' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
    },
  },
}
