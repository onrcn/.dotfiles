return {
  {
    'mbbill/undotree',
    lazy = false,
    config = function()
      vim.keymap.set('n', "<leader>u", vim.cmd.UndotreeToggle, { desc = 'Undotree: Toggle' })
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
  {
    'danilamihailov/beacon.nvim'
  }, -- lazy calls setup() by itself
  {
    "m00qek/baleia.nvim",
    version = "*",
    config = function()
      vim.g.baleia = require("baleia").setup({})

      -- Command to colorize the current buffer
      vim.api.nvim_create_user_command("BaleiaColorize", function()
        vim.g.baleia.once(vim.api.nvim_get_current_buf())
      end, { bang = true })

      -- Command to show logs
      vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
    end,
  },
}
