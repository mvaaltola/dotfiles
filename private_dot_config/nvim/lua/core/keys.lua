-- [[ Basic Keymaps ]]

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- Ignore leader key

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set({ 'n', 'v' }, '0', '^')

-- Navigate splits with Alt-hjkl
vim.keymap.set({ 'n', 'v' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n', 'v' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n', 'v' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n', 'v' }, '<A-l>', '<C-w>l')
