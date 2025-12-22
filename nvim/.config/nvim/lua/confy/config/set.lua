vim.opt.nu = true
vim.opt.rnu = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false


vim.opt.undodir = os.getenv("HOME") .. "/.vim/undotree"
-- vim.opt.undodir = "C:/Users/erene/Personal/vim/undotree"
vim.opt.undofile = true


vim.opt.hlsearch = false

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.opt.cursorline = true

vim.g.mapleader = " "
