local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'stevearc/conform.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
      'j-hui/fidget.nvim',
    },

    opts = {
      servers = {
        -- Ensure mesonlsp is set up
        mesonlsp = {},

      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('fidget').setup({})
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
        },
        handlers = {
          function(server_name) -- default handler (optional)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
              root_dir = require('lspconfig').util.root_pattern(unpack(root_files)),
            })
          end,

          ['clangd'] = function()
            local lspconfig = require('lspconfig')
            lspconfig.clangd.setup({
              capabilities = capabilities,
              root_dir = lspconfig.util.root_pattern(
                "compile_commands.json",
                "compile_flags.txt",
                ".git"
              ),
              cmd = {
                "clangd",
                "--background-index",      -- Index project in background
                "--clang-tidy",            -- Real-time linting
                "--header-insertion=iwyu", -- Auto-import headers
                "--completion-style=detailed",
                "--fallback-style=llvm",   -- Ensure consistent formatting
                "-config-file=_clangd",    -- Look for a .clangd config file
              },
              init_options = {
                usePlaceholders = true,
                completeUnimported = true,
                clangdFileStatus = true,
              },
            })
          end,

          ['lua_ls'] = function()
            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  format = {
                    enable = true,
                    -- Put format options here
                    -- NOTE: the value should be STRING!!
                    defaultConfig = {
                      indent_style = 'space',
                      indent_size = '2',
                    }
                  },
                }
              }
            }
          end,
        }
      })
      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = false,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'LSP: Format code' })
      vim.keymap.set({ 'n', 'i' }, '<F2>', vim.lsp.buf.rename, { desc = 'LSP: Rename' })
      vim.keymap.set({ 'n', 'v', 'i' }, '<C-.>', vim.lsp.buf.code_action,
        { silent = true, noremap = true, desc = 'LSP: Code action' })

      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Go to declaration' })
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP: Go to references' })
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP: Go to implementation' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Show signature' })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'LSP: Open diagnostic float' })
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'LSP: Set diagnostic loclist' })
    end
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        ['<C-f>'] = { 'snippet_forward' },
        ['<C-b>'] = { 'snippet_backward' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  },
  -- this is only for lualsp
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- 3. Debugging (nvim-dap)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Fancy UI for the debugger
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      -- Link Mason installed debuggers to nvim-dap
      "jay-babu/mason-nvim-dap.nvim",
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup UI
      dapui.setup()

      -- Open UI automatically when debugging starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Setup Mason-DAP (Connects codelldb to DAP)
      require("mason-nvim-dap").setup({
        -- Makes sure codelldb is installed
        ensure_installed = { "codelldb" },
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      })

      -- C++ Launch Configuration
      -- This tells DAP how to run your specific executable
      dap.configurations.cpp = {
        {
          name = "Launch File",
          type = "codelldb", -- Matches the adapter name
          request = "launch",
          program = function()
            -- Ask you to compile first, then pick the executable
            -- Note: We assume the build folder is 'build'
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/screen_share', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      -- Use the same config for C and Rust if needed
      dap.configurations.c = dap.configurations.cpp

      -- Debugging keymaps
      vim.keymap.set('n', '<F5>', function() require("dap").continue() end, { desc = "DAP: Start/Continue" })
      vim.keymap.set('n', '<F10>', function() require("dap").step_over() end, { desc = "DAP: Step Over" })
      vim.keymap.set('n', '<F11>', function() require("dap").step_into() end, { desc = "DAP: Step Into" })
      vim.keymap.set('n', '<F12>', function() require("dap").step_out() end, { desc = "DAP: Step Out" })
      vim.keymap.set('n', '<leader>b', function() require("dap").toggle_breakpoint() end,
        { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set('n', '<leader>B',
        function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        { desc = "DAP: Conditional Breakpoint" })
      vim.keymap.set('n', '<leader>du', function() require("dapui").toggle() end, { desc = "DAP: Toggle UI" })
    end,
  },
}
