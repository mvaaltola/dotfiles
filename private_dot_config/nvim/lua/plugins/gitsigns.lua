return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = 'Preview [G]it [H]unk' })
        vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line,
          { desc = "Show [G]it [B]lame" })
        vim.keymap.set('n', '<leader>gB', require('gitsigns').toggle_current_line_blame,
          { desc = "Toggle inline [G]it [B]lame" })
        vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk,
          { desc = "[G]it [S]tage hunk" })
        vim.keymap.set('n', '<leader>gS', require('gitsigns').undo_stage_hunk,
          { desc = "[G]it Un[S]tage hunk" })
        vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk,
          { desc = "[G]it [R]eset hunk" })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({'n', 'v'}, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
        vim.keymap.set({'n', 'v'}, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
      end,
    },
  }
