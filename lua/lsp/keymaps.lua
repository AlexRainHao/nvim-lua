local M = {}

function M.setup_global()
end

function M.setup(bufnr)
    bufnr = bufnr or 0 -- Default to current buffer if not provided
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- formatting
    vim.keymap.set('n', '<leader>ff', function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

return M
