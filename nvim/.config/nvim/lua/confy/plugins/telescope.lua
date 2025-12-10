return {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope: Find files' })
        vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Telescope: Live Grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope: Buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope: Help Tags' })
        vim.keymap.set('n', '<leader>cs', builtin.colorscheme, { desc = 'Telescope: Colorscheme' })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope: Git Files' })    end
}
