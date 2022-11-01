local Keymap = require('onurcan.keymap')
local nnoremap = Keymap.nnoremap
local vnoremap = Keymap.vnoremap
local xnoremap = Keymap.xnoremap
local nmap = Keymap.nmap

nnoremap("<C-x><C-f>", "<cmd>Ex<CR>")

-- greatest remap ever
xnoremap("<leader>p", "\"+_p")
vnoremap("<leader>p", "\"+_p")
nmap("<leader>p", "\"+p")

-- next greatest remap ever : asbjornHaland
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

-- UndoTree

-- Align
