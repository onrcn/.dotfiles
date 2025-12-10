return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup({
      delay = 1000,
    })
  end,
}
