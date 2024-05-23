-- [[ Setting options ]]

-- Tabs and indents are automatically set by tpope/vim-sleuth
vim.o.hlsearch = false -- Set highlight on search

-- Make relative line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

vim.o.mouse = 'a' -- Enable mouse mode

vim.o.swapfile = false -- Disable swapfile

vim.o.showmatch = true -- Show matching parenthesis

vim.o.breakindent = true -- Keep indentation on wrapped lines

vim.o.undofile = true -- Save undo history

vim.o.wrap = false -- Disable text wrapping
vim.o.colorcolumn = '89,121' -- Show ruler on columns 89 and 121

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes' -- Keep signcolumn (gutter) on by default

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience

vim.o.termguicolors = true -- Better colors

vim.o.scrolloff = 8 -- Empty space at bottom of buffer

vim.g.netrw_keepj = "" -- Jump back to netrw instead of previous file
