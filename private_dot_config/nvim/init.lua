vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.mouse = 'a'
vim.o.termguicolors = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Options
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = 'yes'
vim.o.scrolloff = 8

vim.o.swapfile = false
vim.o.undofile = true

vim.o.breakindent = true
vim.o.wrap = false
vim.o.showmatch = true

vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keybinds
-- Reload config
vim.keymap.set('n', '<leader>R', function()
  -- Clear cached Lua modules so they get re-read
  for name, _ in pairs(package.loaded) do
    if name:match('^core%.') or name:match('^plugins%.') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify('Config reloaded')
end, { desc = '[R]eload config' })

-- Autocmds
-- Remove trailing whitespace on write
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*"},
  command = [[%s/\s\+$//e]],
})

-- Colors
vim.pack.add({'https://github.com/catppuccin/nvim'})
require("catppuccin").setup({
  background = { -- :h background
    light = "latte",
    dark = "frappe",
  }
})
vim.cmd.colorscheme 'catppuccin-nvim'

-- see :help modeline
-- vim: ts=2 sts=2 sw=2 et
