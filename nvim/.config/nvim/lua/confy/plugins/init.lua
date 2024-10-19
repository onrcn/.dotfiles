return {
    {
        'VonHeikemen/fine-cmdline.nvim',
        lazy = false,
        dependencies = {'MunifTanjim/nui.nvim'},
        config = function ()
            vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})
        end,
    },
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
        end
    },

    {
        'mbbill/undotree',
        lazy = false,
        config = function()
            vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle)
        end
    },
    {
        'fatih/vim-go',
        lazy = false,
    },
    {
        'github/copilot.vim',
        lazy = false,
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        lazy = false,
    },
}
