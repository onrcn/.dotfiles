return {
    {
        -- Solarized for nvim
        'ishan9299/nvim-solarized-lua',
        lazy = false,
        priority=1000,
        config = function()
            vim.g.solarized_italic = 1
            vim.g.solarized_contrast = 'high'
            vim.g.solarized_visibility = 'high'
            vim.g.solarized_termcolors = 256
            vim.g.solarized_diffmode = 'high'
            vim.g.solarized_cursor_guifg = 1
            vim.g.solarized_cursor_bg = 0
            vim.g.solarized_termtrans = 1
            vim.g.solarized_statusline = 'normal'
            vim.g.solarized_italics = 1
            vim.g.solarized_bold = 1
            vim.g.solarized_underline = 1
            vim.g.solarized_undercurl = 1
            vim.g.solarized_termcolors = 256
            vim.g.solarized_visibility = 'high'
            vim.g.solarized_diffmode = 'high'
            vim.g.solarized_termtrans = 1
            vim.g.solarized_statusline = 'normal'
            vim.g.solarized_italics = 1
            vim.g.solarized_bold = 1
            vim.g.solarized_underline = 1
            vim.g.solarized_undercurl = 1
            --vim.cmd([[colorscheme solarized]])
        end,

    },
    {
        'sainnhe/sonokai',
        lazy = false,
        priority=1000,
        config = function()
          --vim.g.sonokai_style = 'andromeda'
          --vim.g.sonokai_enable_italic = 1
          --vim.g.sonokai_disable_italic_comment = 1
          --vim.cmd([[colorscheme sonokai]])
        end,
    },

    {
        'letorbi/vim-colors-modern-borland',
        lazy = false,
        priority=1000,
        config = function()
            -- vim.cmd([[colorscheme borland]])
        end,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        lazy = false,
        priority=1000,
        config = function()
            -- vim.cmd([[colorscheme rose-pine-dawn]])
        end,
    },
    {
        'Mofiqul/dracula.nvim',
        lazy = false,
        priority=1000,
        config = function()
            --vim.cmd([[colorscheme dracula]])
        end,
    },
    {
       'atelierbram/Base2Tone-nvim',
       lazy =false,
       priority=1000,
       config = function()
           --vim.cmd([[colorscheme base2tone_lavender_dark]])
       end,
    },
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        lazy = false,
        priority=1000,
        config = function()
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,

    },
}
