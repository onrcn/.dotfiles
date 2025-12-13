return {
  { -- This plugin
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    -- MOVE KEYMAPS HERE ("keys" tells lazy to create these binds immediately)
    keys = {
      { "<S-F6>", "<cmd>CompilerOpen<cr>",                      desc = "Compiler Open" },
      { "<F6>",   "<cmd>CompilerStop<cr><cmd>CompilerRedo<cr>", desc = "Compiler Redo" },
      { "<S-F7>", "<cmd>CompilerToggleResults<cr>",             desc = "Compiler Toggle Results" },
    },
  },
  { -- The task runner we use
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    -- It will load when compiler.nvim loads because it is a dependency,
    -- or when these commands are run.
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
  },
}
