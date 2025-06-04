return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            mode = "tabs",
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = "icon",
            },
            show_buffer_close_icons = false,
            show_close_icon = false,
            enforce_regular_tabs = true,
            show_duplicate_prefix = false,
            tab_size = 16,
            padding = 0,
            separator_style = "thick",
            modified_icon = '● ',
        }
    }
}
