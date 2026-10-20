vim.pack.add({'https://github.com/lewis6991/gitsigns.nvim'})
require('gitsigns').setup({
  -- disable sign column, color numbers instead
  signcolumn = false,
  numhl = true,
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end, { desc = 'Next [c]hange' })
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end, { desc = 'Previous [c]hange' })

    -- todo: map stage_hunk, reset_hunk, preview_hunk, blame_line, setloclist
  end
})
