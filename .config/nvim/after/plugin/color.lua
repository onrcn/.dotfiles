vim.g.onurcan_colorscheme = "rose-pine"

require('tokyonight').setup({
    style = "night",
    transparent = true,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},

        sidebars = "transparent",
        floats = "transparent",
    }

})

function Colour()
    vim.opt.background = 'dark'
    vim.cmd("colorscheme " .. vim.g.onurcan_colorscheme)

    local hl = function(things, opts)
        vim.api.nvim_set_hl(0, things, opts)
    end

    hl("SignColoumn", {
        bg = "none",
    })

    hl("Normal", {
        bg = "none"
    })

    hl("LineNr", {
        fg = "#5eacd3"
    })

    hl("netrwDir", {
        fg = "#5eacd3"
    })
end

Colour()
