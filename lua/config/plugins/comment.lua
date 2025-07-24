return {
  'tomtom/tcomment_vim',
  event = 'BufRead',
  config = function()
    vim.g.tcomment_maps = true
    vim.g.tcomment_textobject_inlinecomment = ''

    vim.cmd([[
      nmap <Leader>/<Leader> gcc
      vmap <Leader>/ gc
    ]])
  end,
}
