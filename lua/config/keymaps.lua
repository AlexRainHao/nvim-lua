vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

local mode_nv = { 'n', 'v' }
local mode_v = { 'v' }
local mode_i = { 'i' }

local mappings = {
  -- Actions
  { from = 'jk', to = '<ESC>', mode = mode_i },
  { from = 'Q', to = ':q<CR>' },
  { from = '<Leader>Q', to = ':q!<CR>' },
  { from = 'W', to = ':wa<CR>' },
  { from = 'v,', to = 'v$' },

  -- Movements
  { from = ',.', to = '$', mode = mode_nv },

  -- Windows
  { from = '<up>', to = '<C-w>k' },
  { from = '<down>', to = '<C-w>j' },
  { from = '<left>', to = '<C-w>h' },
  { from = '<right>', to = '<C-w>l' },

  { from = '<M-k>', to = ':res -5<CR>' },
  { from = '<M-j>', to = ':res +5<CR>' },
  { from = '<M-h>', to = ':vertical resize -5<CR>' },
  { from = '<M-l>', to = ':vertical resize +5<CR>' },
  {
    from = '<leader>\\',
    to = ':set nosplitright<CR>:vsplit<CR>:set splitright<CR>',
  },
  {
    from = '<leader>;',
    to = ':set nosplitbelow<CR>:split<CR>:set splitbelow<CR>',
  },
  { from = '<leader>v', to = '<C-w>b<C-w>K' },
  { from = '<leader>h', to = '<C-w>b<C-w>H' },

  { from = '<leader>q', to = '<C-w>j:q<CR>' },

  -- Tabs
  { from = 'tu', to = ':tabe<CR>' },
  { from = '<M-[>', to = ':tabp<CR>' },
  { from = '<M-]>', to = ':tabn<CR>' },
}

for _, mapping in ipairs(mappings) do
  vim.keymap.set(
    mapping.mode or 'n',
    mapping.from,
    mapping.to,
    { noremap = true }
  )
end

-- terminal
-- enter `insert` mode when open terminal
-- vim.cmd([[autocmd TermOpen term://* startinsert]])
vim.cmd([[
    tnoremap <ESC> <C-\><C-N>
]])
-- tnoremap <C-D> <C-\><C-N><C-O>
