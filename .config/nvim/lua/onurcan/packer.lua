-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use ('wbthomason/packer.nvim')

    -- Magit
    use ('TimUntersberger/neogit')

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
    use ("neovim/nvim-lspconfig")
    use ("hrsh7th/cmp-nvim-lsp")
    use ("hrsh7th/cmp-buffer")
    use ("hrsh7th/nvim-cmp")
    use ("onsails/lspkind-nvim")
    use ("nvim-lua/lsp_extensions.nvim")
    use ("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Colorschemes
    use ('folke/tokyonight.nvim')
    use ('andreasvc/vim-256noir')
    use ({'rose-pine/neovim', as = 'rose-pine'})
    use ("rebelot/kanagawa.nvim")
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

    -- Colorizer
    use ('norcalli/nvim-colorizer.lua')

    -- Trim whitespace
    use ('cappyzawa/trim.nvim')

    -- Neorg
    use ({
        'nvim-neorg/neorg',
        ft = "norg",
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {}
                }
            }
        end,
        requires = "rose-pinenvim-lua/plenary.nvim"
    })

    use ({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use ({
    "folke/zen-mode.nvim",
    config = function()
        require("zen-mode").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    end
    })
end)
