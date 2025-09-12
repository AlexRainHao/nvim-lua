vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.exrc = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.indentexpr = ''
vim.o.list = true
vim.o.listchars = 'tab:|\\ ,trail:▫,precedes:«,extends:»'
vim.o.scrolloff = 4
vim.o.timeoutlen = 0
vim.o.timeout = false
vim.o.wrap = true
vim.o.textwidth = 0
vim.o.foldenable = true
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shortmess = vim.o.shortmess .. 'ca'
vim.o.inccommand = 'split'
vim.o.completeopt = 'menuone,noinsert,noselect,preview'
if vim.fn.has('nvim-0.11') == 1 then
  vim.opt.completeopt:append('fuzzy')
end
vim.o.colorcolumn = '120'
vim.o.virtualedit = 'block'
vim.o.mouse = 'a'
vim.o.updatetime = 1000

local os_name = vim.loop.os_uname().sysname
if os_name == 'Darwin' or os_name == 'Linux' then
  vim.opt.clipboard:append('unnamedplus')
end
