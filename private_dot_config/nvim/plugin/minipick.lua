vim.pack.add({'https://github.com/nvim-mini/mini.pick'})
require('mini.pick').setup()

local function map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

map('n', '<leader>ff', function()
  MiniPick.start( { source= { items=vim.fn.readdir('.') } })
end, { desc = '[f]ind [f]iles' })

map('n', '<leader>fg', function()
  MiniPick.builtin.files({ tool = 'git' })
end, { desc = '[f]ind [g]it' })

map('n', '<leader>fr', function()
  MiniPick.builtin.grep_live({ tool = 'rg' })
end, { desc = '[f]ind g[r]ep' })
