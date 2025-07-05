return {
	{
		"petertriho/nvim-scrollbar",
		dependencies = {
			"kevinhwang91/nvim-hlslens",
		},
		config = function()
			require("scrollbar.handlers.search").setup({})
			require("scrollbar.handlers.gitsigns").setup({})
			require("scrollbar").setup({
				show = true,
				handle = {
					text = " ",
					color = "#928374",
					hide_if_all_visible = true,
				},
				marks = {
					Cursor = {
						text = "•",
						priority = 0,
						gui = nil,
						color = nil,
						cterm = nil,
						color_nr = nil, -- cterm
						highlight = "Normal",
					},
					Search = { color = nil, highlight = "Search" },
					Misc = { color = "purple" },
				},
				handlers = {
					cursor = true,
					diagnostic = true,
					gitsigns = true,
					handle = true,
					search = true,
				},
			})
		end
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"regex",
				}
			})
			vim.cmd("hi IlluminatedWordText guibg=#393e4d gui=underline cterm=underline")
		end
	},
}
