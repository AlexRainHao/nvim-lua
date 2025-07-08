local mode_m = { noremap = true, nowait = true }
local M = {}

M.config = {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- icon
			"nvim-tree/nvim-web-devicons",
			-- jump between tabs
			{
				"LukasPietzschmann/telescope-tabs",
				config = function()
					local tabs = require("telescope-tabs")
					tabs.setup({})
					vim.keymap.set("n", "<c-t>", tabs.list_tabs, {})
				end
			},
			-- telescope fzf sort score plugin
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
			-- prettier UI
			'stevearc/dressing.nvim',
		},
		config = function()
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<c-p>", builtin.find_files, mode_m)
			vim.keymap.set("n", "<leader>rs", builtin.resume, mode_m)
			vim.keymap.set("n", "<c-b>", builtin.buffers, mode_m)
			vim.keymap.set("n", "<leader><c-p>", builtin.oldfiles, mode_m)
			vim.keymap.set("n", "z=", builtin.spell_suggest, mode_m)

			vim.keymap.set('n', '<leader>D', function()
				builtin.diagnostics({
					sort_by = "severity"
				})
			end, m)

			vim.lsp.protocol.DiagnosticSeverity = {
				"Error",
				"Warning",
				"Information",
				"Hint",
				Error = 1,
				Hint = 4,
				Information = 3,
				Warning = 2
			}

			vim.diagnostic.severity = {
				"ERROR",
				"WARN",
				"INFO",
				"HINT",
				E = 1,
				ERROR = 1,
				HINT = 4,
				I = 3,
				INFO = 3,
				N = 4,
				W = 2,
				WARN = 2
			}

			local ts = require("telescope")
			local actions = require("telescope.actions")

			M.ts = ts

			ts.setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						"build",
						"dist",
						".git"
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--fixed-strings",
						"--smart-case",
						"--trim",
					},
					layout_config = {
						width = 0.9,
						height = 0.9,
					},
					mappings = {
						i = {
							["<C-w>"] = actions.which_key,
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<esc>"] = actions.close,
							["<C-;>"] = actions.select_horizontal,
							["<C-\\>"] = actions.select_vertical,
							["<C-x>"] = actions.cycle_history_next,
							["<C-z>"] = actions.cycle_history_prev,
						}
					},
					color_devicons = true,
					prompt_prefix = "🔍 ",
					selection_caret = " ",
					path_display = { "truncate" },
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				},
				pickers = {
					buffers = {
						show_all_buffers = true,
						sort_lastused = true,
						mappings = {
							i = {
								["<c-d>"] = actions.delete_buffer,
							}
						}
					}
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				}
			})

			ts.load_extension('neoclip')
			ts.load_extension('telescope-tabs')
			ts.load_extension('fzf')

			require('dressing').setup({})
		end
	},
	{
		"FeiyouG/commander.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>:", "<CMD>Telescope commander<CR>", mode = "n" },
		},
		config = function()
			local commander = require("commander")

			commander.setup({
				integration = {
					telescope = {
						enable = true,
					},
					lazy = {
						enable = true,
					}
				}
			})

			commander.add({
				{
					desc = "Git Status",
					cmd = "<CMD>Telescope git_status<CR>",
				},
				{
					desc = "Telescope builtin commands",
					cmd = "<CMD>Telescope commands<CR>"
				},
				{
					desc = "Telescope keymaps",
					cmd = "<CMD>Telescope keymaps<CR>"
				},
				{
					desc = "Telescope current buffer fuzz find",
					cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>"
				}
			})
		end
	}
}


return M
