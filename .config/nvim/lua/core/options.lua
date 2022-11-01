local g = vim.g  -- global variables
local opt = vim.opt  -- set options

-- general
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false

-- ui
opt.number = true
opt.relativenumber = true
opt.showmatch = true  -- show matching parenthesis
opt.colorcolumn = '88'
opt.lazyredraw = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- tabs and indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
