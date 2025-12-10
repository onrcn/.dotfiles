return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup({
      delay = 1000,
    })
    vim.keymap.set('n', '<leader>?', '<cmd>WhichKey<CR>', { desc = 'WhichKey: Open WhichKey Menu' })
  end,
}
