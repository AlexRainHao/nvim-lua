vim.g.mapleader = " "
vim.g.maplocalleader = ";"

local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }

local mappings = {
	-- Actions
	{ from = "jk",              to = "<ESC>",                                               mode = mode_i },
	{ from = "Q",               to = ":q<CR>" },
	{ from = "<Leader>Q",       to = ":q!<CR>" },
	{ from = "W",               to = ":wa<CR>" },
	{ from = "v,",              to = "v$" },

	-- Movements
	{ from = ",.",              to = "%",                                                   mode = mode_nv },

	-- Windows
	{ from = "<up>",            to = "<C-w>k" },
	{ from = "<down>",          to = "<C-w>j" },
	{ from = "<left>",          to = "<C-w>h" },
	{ from = "<right>",         to = "<C-w>l" },

	{ from = "<Leader><up>",    to = ":res -5<CR>" },
	{ from = "<Leader><down>",  to = ":res +5<CR>" },
	{ from = "<Leader><left>",  to = ":vertical resize -5<CR>" },
	{ from = "<Leader><right>", to = ":vertical resize +5<CR>" },

	{ from = "<c-s>\\",         to = ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", },
	{ from = "<c-s>;",         to = ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", },
	{ from = "<c-s>v",          to = "<C-w>b<C-w>K", },
	{ from = "<c-s>h",          to = "<C-w>b<C-w>H", },

	{ from = "<leader>q",       to = "<C-w>j:q<CR>" },

	-- Tabs
	{ from = "tu",              to = ":tabe<CR>" },
	-- { from = "<C-[>",           to = ":tabp<CR>" },
	-- { from = "<C-]>",           to = ":tabn<CR>" },
}

for _, mapping in ipairs(mappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end
