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
  {
    'andreasvc/vim-256noir',
    lazy=false,
    priority=1000,
    config=function()
      --vim.cmd([[colorscheme 256_noir]])
      --vim.cmd([[set cursorline]])
      --vim.cmd([[highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212]])
      --vim.cmd([[autocmd InsertEnter * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=234 guifg=NONE guibg=#1c1c1c]])
      --vim.cmd([[autocmd InsertLeave * highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=233 guifg=NONE guibg=#121212]])
    end,

  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'rebelot/kanagawa.nvim',
    lazy=false,
    priority=1000,
    config=function()
      -- Default options:
      require('kanagawa').setup({
        compile = false,             -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = false, bold = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,         -- do not set background color
        dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        colors = {                   -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "wave",              -- Load "wave" theme when 'background' option is not set
        background = {               -- map the value of 'background' option to a theme
          dark = "wave",           -- try "dragon" !
          light = "lotus"
        },
      })

      -- setup must be called before loading
      -- vim.cmd("colorscheme kanagawa")
    end,
  },
  { "EdenEast/nightfox.nvim" }, -- lazy

}
