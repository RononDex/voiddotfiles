local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }


-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Moving between panels
keymap("n", "sh", "<C-w>h", default_opts)
keymap("n", "sk", "<C-w>k", default_opts)
keymap("n", "sj", "<C-w>j", default_opts)
keymap("n", "sl", "<C-w>l", default_opts)

-- Resize Panels
keymap("n", "si", "3<C-w>+", default_opts)
keymap("n", "su", "3<C-w>-", default_opts)
keymap("n", "so", "3<C-w><", default_opts)
keymap("n", "sp", "3<C-w>>", default_opts)

-- Go to tab by number
keymap("n", "<leader>1", "1gt", default_opts)
keymap("n", "<leader>2", "2gt", default_opts)
keymap("n", "<leader>3", "3gt", default_opts)
keymap("n", "<leader>4", "5gt", default_opts)
keymap("n", "<leader>5", "5gt", default_opts)
keymap("n", "<leader>6", "6gt", default_opts)
keymap("n", "<leader>7", "7gt", default_opts)
keymap("n", "<leader>8", "8gt", default_opts)
keymap("n", "<leader>9", "9gt", default_opts)
keymap("n", "<leader>tn", "<cmd>tabnew<cr>", default_opts)
keymap("n", "<leader>tc", "<cmd>tabclose<cr>", default_opts)
keymap("n", "<leader>tt", "<cmd>tabnew<cr><cmd>terminal<cr>", default_opts)
keymap("n", "<leader>0", "<cmd>tablast<cr>", default_opts)

-- Misc Keybindings
keymap("n", "t", "o<Esc>", default_opts)
keymap("n", "T", "O<Esc>", default_opts)

-- Terminal Mode
keymap("t", "<Esc>", "<C-\\><C-n>", default_opts)
keymap("n", "<leader>nt", "ss<cmd>terminal<cr>20su", default_opts)

-- Splitting of windows
keymap("n", "ss", "<cmd>split<cr><C-w>w", default_opts)
keymap("n", "sv", "<cmd>vsplit<cr><C-w>w", default_opts)

-- List available commands
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-F1>', builtin.commands, {})
vim.keymap.set('n', '<C-c>', builtin.commands, {})
