local function augroup(name)
   return vim.api.nvim_create_augroup("confy_" .. name, {clear = true})
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Auto-close for source code files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("autoclose"),
  pattern = {
    "lua", "python", "javascript", "typescript", "json", "yaml", "go", "rust", "c", "cpp", "java", "html", "css", "scss", "less", "php", "ruby", "markdown", "vue", "svelte", "xml", "sh", "bash", "zsh", "fish",
  },
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    vim.keymap.set("i", "(", "()<left>", opts)
    vim.keymap.set("i", "{", "{}<left>", opts)
    vim.keymap.set("i", "[", "[]<left>", opts)
    vim.keymap.set("i", "\"", "\"\"<left>", opts)
    vim.keymap.set("i", "'", "''<left>", opts)
    vim.keymap.set("i", "`", "``<left>", opts)
  end,
})

