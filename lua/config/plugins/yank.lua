return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        { "kkharji/sqlite.lua", module = "sqlite" },
    },
    config = function()
        vim.keymap.set("n", "<c-y>", ":Telescope neoclip<CR>", { noremap = true })

        require("neoclip").setup({
            history = 1000,
            enable_persistent_history = true,
            keys = {
                telescope = {
                    i = {
                        select = "<cr>",
                        paste = "<cr>",
                        paste_behind = "<c-p>",
                        delete = "<c-d>",
                        edit = "<c-e>",
                        custom = {}
                    }
                }
            }
        })

        require("telescope").load_extension("neoclip")
    end
}
