vim.g.python3_host_prog = '/usr/bin/python3'

M = {}

-- `everforest` | `onedark` | 'vitesse' | 'gruvbox' | 'kanagawa' | 'gruvbox_material' | 'cyberdream'
M.prefer_theme = 'cyberdream'

-- `llm models`
M.prefer_llm = {
  adapter = 'deepseek',
  model = vim.env.DEEPSEEK_API_V3_MODEL,
}

M.use_notify = false

return M
