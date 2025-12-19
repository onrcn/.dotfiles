return {
  'nvim-treesitter/nvim-treesitter-context',
  lazy = false,
  config = function()
    require('treesitter-context').setup {
      enable = true,    -- Enable treesitter-context
      throttle = true,  -- Update only when cursor stops moving
      max_lines = 0,    -- How many lines the window should be that it shows the context
      patterns = {
        -- Pattern for lua to show functions. You can add more patterns for other languages.
        -- For example: `class_definition`, `function_definition` for python, etc.
        default = {
          'function',
          'method',
          'for',
          'while',
          'if',
          'table',
          'if_statement',
          'while_statement',
          'for_statement',
        },
      },
      exact_patterns = {}, -- Patterns that must be matched exactly
      mode = 'top',     -- Show context at the top of the window
      zindex = 20,      -- Z-index of the context window
      on_attach = nil,  -- Callback function when the context window is attached
    }
  end
}
