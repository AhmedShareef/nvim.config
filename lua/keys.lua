-- [[ keys.lua ]]

local map = vim.api.nvim_set_keymap

-- Open Tree
map('n', '<C-e>', [[:NvimTreeOpen<CR>]], {})

-- Toggle IndentLine
map('n', '<Leader>L', [[:IndentLinesToggle<CR>]], {})

-- Toggle Tagbar
map('n', '<Leader>t', [[:TagbarToggle<CR>]], {})

-- Show Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<Leader>fg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {})
vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<Leader>l', require('lsp_lines').toggle, { desc = "Toggle LSP Lines" })

-- harpoon
vim.keymap.set('n', '<Leader>h', require('harpoon.mark').add_file, { desc = "Harpoon this file."})
vim.keymap.set('n', '<Leader>H', require('harpoon.ui').toggle_quick_menu, { desc = "Toggle Harpoon menu." })
vim.keymap.set('n', '<a-h>', require('harpoon.ui').nav_next, { desc = "Navigate to next Harpoon mark." })

-- disable the arrow keys to disable the touchpad
vim.keymap.set("", "<up>", "<nop>", { noremap = true })
vim.keymap.set("", "<down>", "<nop>", { noremap = true })
vim.keymap.set("i", "<up>", "<nop>", { noremap = true })
vim.keymap.set("i", "<down>", "<nop>", { noremap = true })
