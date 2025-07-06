return {
    {
        "pechorin/any-jump.vim",
        config = function()
            vim.keymap.set("n", "gd", ":AnyJump<CR>", { noremap = true })
            vim.keymap.set("x", "gd", ":AnyJumpVisual<CR>", { noremap = true })
            vim.keymap.set("n", "go", ":AnyJumpBack<CR>", { noremap = true })
            vim.g.any_jump_disable_default_keybindings = 1
            vim.g.any_jump_window_width_ratio = 0.9
            vim.g.any_jump_window_height_ratio = 0.9
        end
    },
    {
        "MagicDuck/grug-far.nvim",
        keys = {
            {
                "<leader>F",
                mode = "n",
                function()
                    vim.cmd(":GrugFar")
                end,
                desc = "Project find and replace"
            }
        },
        config = function()
            require('grug-far').setup({});
        end
    }
}
