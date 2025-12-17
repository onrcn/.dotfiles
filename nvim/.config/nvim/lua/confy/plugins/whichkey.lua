return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup({
      delay = 1000,
    })
    vim.keymap.set('n', '<leader>?', '<cmd>WhichKey<CR>', { desc = 'WhichKey: Open WhichKey Menu' })

    local wk = require('which-key')
    wk.register({
      [']'] = {
        name = "Treesitter next",
        m = "Next function start",
        [']'] = "Next class start",
      },
      ['['] = {
        name = "Treesitter previous",
        m = "Previous function start",
        ['['] = "Previous class start",
      },
      g = {
        name = "Treesitter",
        s = "Swap next parameter",
        S = "Swap previous parameter",
      },
    })
  end,
}
