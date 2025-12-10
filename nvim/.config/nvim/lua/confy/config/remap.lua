vim.g.mapleader = ' '

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without losing yanked text' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Yank line to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = 'Delete without yanking' })

vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'Format code' })
vim.keymap.set({ 'n', 'i' }, '<F2>', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-/>', vim.lsp.buf.code_action, { silent = true, noremap = true, desc = 'Code action' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show signature' })


vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz', { desc = 'Next in quickfix list' })
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz', { desc = 'Previous in quickfix list' })
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = 'Next in location list' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = 'Previous in location list' })

vim.keymap.set('n', '<leader>pf', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

vim.keymap.set('n', '<leader><leader>', function()
  vim.cmd('so')
end, { desc = 'Source current file' })

vim.keymap.set('n', '<leader>?', '<cmd>WhichKey<CR>', { desc = 'Open WhichKey' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Open compiler
vim.api.nvim_set_keymap('n', '<S-F6>', '<cmd>CompilerOpen<cr>', { noremap = true, silent = true, desc = 'Open compiler' })

-- Redo last selected option
vim.api.nvim_set_keymap('n', '<F6>',
  '<cmd>CompilerStop<cr>' -- (Optional, to dispose all tasks before redo)
  .. '<cmd>CompilerRedo<cr>',
  { noremap = true, silent = true, desc = 'Redo last compiler option' })

-- Toggle compiler results
vim.api.nvim_set_keymap('n', '<S-F7>', '<cmd>CompilerToggleResults<cr>', { noremap = true, silent = true, desc = 'Toggle compiler results' })
