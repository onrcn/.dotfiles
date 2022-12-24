-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer itself
    use ('wbthomason/packer.nvim')

    use ('nvim-lua/plenary.nvim')
    use ('nvim-lua/popup.nvim')
    use ('nvim-telescope/telescope.nvim')

    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })

    -- Tree sitter
    use ({
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate"
    })
    use ("nvim-treesitter/playground")
    use ("romgrk/nvim-treesitter-context")

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},

            -- Symbols Outline
            {'simrat39/symbols-outline.nvim'}
        }
    }

    -- Colorschemes
    use ('folke/tokyonight.nvim')
    use ('andreasvc/vim-256noir')
    use ({'rose-pine/neovim', as = 'rose-pine'})
    use ("rebelot/kanagawa.nvim")
    use ('deviantfero/wpgtk.vim')

    -- Surround!
    use ({
        'kylechui/nvim-surround',
        tag = '*',
    })

    -- Align
    use ('junegunn/vim-easy-align')

    -- Undotree
    use ( 'mbbill/undotree')

    -- Colorpicker
    use ('ziontee113/color-picker.nvim')

    -- Trim whitespace
    use ('cappyzawa/trim.nvim')

    use ({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end })

    use ({
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end })

    use ({'akinsho/bufferline.nvim', tag = "v3.*", requires =
    'nvim-tree/nvim-web-devicons'})

end)
