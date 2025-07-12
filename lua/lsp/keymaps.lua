local M = {}

function M.setup_global()
end

function M.setup(bufnr)
    bufnr = bufnr or 0 -- Default to current buffer if not provided
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Definitions, references, etc.
    vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', ':tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, opts)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set('n', '<leader>aw', vim.lsp.buf.code_action, opts)

    -- formatting
    vim.keymap.set('n', '<leader>ff', function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

return M
