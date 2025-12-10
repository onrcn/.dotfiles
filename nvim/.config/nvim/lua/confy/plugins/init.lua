return {
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
    'HiPhish/rainbow-delimiters.nvim',
    lazy = false,
  },
  {
    'numToStr/Comment.nvim',
    opts = {}, -- optional, loads defaults
    lazy = false,
  },
}
