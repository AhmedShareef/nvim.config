-- [[ vars.lua ]]

local g = vim.g

g.mapleader = ","

g.t_co = 256
g.background = "dark"

-- Update the packpath
local packer_path = vim.fn.stdpath('config') .. '/site'
vim.o.packpath = vim.o.packpath .. ',' .. packer_path

-- nvim-tree disable default keybindings
-- g.nvim_tree_disable_default_keybindings = 1
