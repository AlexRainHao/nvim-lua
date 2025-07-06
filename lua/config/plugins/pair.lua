return {
    {
        "gcmt/wildfire.vim",
        lazy = false,
        keys = {
            { "<leader>s", "<Plug>(wildfire-quick-select)", desc = "Wildfire quick select" }
        },
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    }
}
