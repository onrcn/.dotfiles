vim.g.mapleader = ' '

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without losing yanked text' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })

for i = 1, 9 do
  vim.keymap.set('n', string.format('<A-%d>', i), string.format('%dgt', i), { desc = string.format('Go to tab %d', i) })
end

vim.keymap.set('n', '<Esc>[F', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
