vim.cmd([[
    silent !mkdir -p $HOME/.config/nvim/tmp/backup
    silent !mkdir -p $HOME/.config/nvim/tmp/undo

    set backupdir=$HOME/.config/nvim/tmp/backup
    set directory=$HOME/.config/nvim/tmp/backup

    if has('persistent_undo')
        set undofile
        set undodir=$HOME/.config/nvim/tmp/undo,.
    endif
]])

-- auto-reloading configuration without existing
vim.cmd([[
augroup NVIMRC
    autocmd!
    autocmd BufWritePost init.lua lua dofile(vim.fn.stdpath("config") .. "/init.lua")
augroup END
]])
