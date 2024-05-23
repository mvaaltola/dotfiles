--[[
Explore or search through `:help lua-guide`
https://learnxinyminutes.com/docs/lua/
https://neovim.io/doc/user/lua-guide.html
--]]

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install lazy.nvim, see `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  {
    'folke/tokyonight.nvim',
    lazy=false, -- Force load on startup
    priority=1000, -- Load colorscheme before all other plugins
    config = function ()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'neovim/nvim-lspconfig', -- LSP Configuration & Plugins
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      'folke/neodev.nvim', -- Additional lua configuration
    },
  },

  {
    'hrsh7th/nvim-cmp', -- Autocompletion & snippets
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp', -- Adds LSP completion capabilities
      'rafamadriz/friendly-snippets', -- Adds a number of user-friendly snippets
    },
  },

  { 'folke/which-key.nvim', opts = {} }, -- Useful plugin to show you pending keybinds.

  {
    'nvim-lualine/lualine.nvim', -- Set lualine as statusline, see :help lualine.txt
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines, see `:help indent_blankline.txt`
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opts = {},
  },

  { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'plugins' },
}, {})

require('core.opts')
require('core.keys')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- TODO: Jump to last known position in buffer

-- require('core.kitty') -- Set kitty padding
require('plugins.config.lsp') -- Configure lsp
require('plugins.config.cmp') -- Configure cmp
require('plugins.config.telescope') -- Configure telescope
require('plugins.config.treesitter') -- Configure treesitter

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
