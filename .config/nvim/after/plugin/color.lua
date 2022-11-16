-- Default options:
require('kanagawa').setup({
    undercurl = true,           -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true},
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = false,       -- adjust window separators highlight for laststatus=3
    terminalColors = true,      -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
    theme = "default"           -- Load "default" theme or the experimental "light" theme
})

require('tokyonight').setup({
    style = "night",
    transparent = false,
    terminal_colors = false,
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},

        --sidebars = "transparent",
        --floats = "transparent",
    }

})

vim.g.onurcan_colorscheme = "kanagawa"

function Colour()
    vim.opt.background = 'dark'
    vim.cmd("colorscheme " .. vim.g.onurcan_colorscheme)

    local hl = function(things, opts)
        vim.api.nvim_set_hl(0, things, opts)
    end

    hl("SignColoumn", {
        bg = "none",
    })

--  hl("Normal", {
--      bg = "none"
--  })

    hl("LineNr", {
        fg = "#5eacd3"
    })

    hl("netrwDir", {
        fg = "#5eacd3"
    })
end

Colour()
