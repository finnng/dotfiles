-- VSCode-Neovim specific configuration
-- This file is only loaded when running Neovim inside VS Code

if not vim.g.vscode then
  return
end

local vscode = require('vscode')

-- Leader key
vim.g.mapleader = ' '

-- System clipboard
vim.opt.clipboard = 'unnamedplus'

-- ============================================================================
-- Useful vim options (lightweight, work well in VS Code)
-- ============================================================================

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ============================================================================
-- Load essential plugins for VS Code
-- ============================================================================

-- Bootstrap lazy.nvim for VS Code (minimal)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.loop.fs_stat(lazypath) then
  vim.opt.rtp:prepend(lazypath)
  
  -- Load only essential plugins for VS Code
  require("lazy").setup({
    -- Surround plugin (cs, ds, ys commands)
    "tpope/vim-surround",
    -- Comment plugin (gcc, gc commands)
    {
      "numToStr/Comment.nvim",
      opts = {},
      lazy = false,
    },
  }, {
    -- Minimal lazy config for VS Code
    performance = {
      rtp = {
        disabled_plugins = {
          "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin",
          "tohtml", "tutor", "zipPlugin",
        },
      },
    },
  })
end

-- ============================================================================
-- Normal mode mappings
-- ============================================================================

-- File/Search operations
vim.keymap.set('n', '<leader>]', function() vscode.action('workbench.action.findInFiles') end, { desc = 'Find in files' })
vim.keymap.set('n', '<leader>}', function() vscode.action('search.action.openEditor') end, { desc = 'Open search editor' })
vim.keymap.set('n', '<leader>P', function() vscode.action('workbench.action.files.copyPathOfActiveFile') end, { desc = 'Copy file path' })
vim.keymap.set('n', '<leader><CR>', function() vscode.action('workbench.action.quickOpen') end, { desc = 'Quick open' })

-- Explorer/Navigation
vim.keymap.set('n', '<leader>r', function() vscode.action('workbench.files.action.showActiveFileInExplorer') end, { desc = 'Reveal in explorer' })
vim.keymap.set('n', '<leader>e', function() vscode.action('workbench.view.explorer') end, { desc = 'Focus explorer' })

-- Diagnostics/Errors
vim.keymap.set('n', '<leader>i', function() vscode.action('editor.action.marker.prevInFiles') end, { desc = 'Previous error' })
vim.keymap.set('n', '<leader>o', function() vscode.action('editor.action.marker.nextInFiles') end, { desc = 'Next error' })

-- Code actions
vim.keymap.set('n', '<leader>R', function() vscode.action('editor.action.rename') end, { desc = 'Rename symbol' })
vim.keymap.set('n', '<leader>f', function() vscode.action('editor.action.formatDocument') end, { desc = 'Format document' })
vim.keymap.set('n', '<leader>a', function() vscode.action('editor.action.quickFix') end, { desc = 'Quick fix' })

-- Window/Buffer management
vim.keymap.set('n', '<leader>W', function() vscode.action('workbench.action.closeOtherEditors') end, { desc = 'Close other editors' })
vim.keymap.set('n', '<leader>q', function() vscode.action('workbench.action.closeActiveEditor') end, { desc = 'Close editor' })
vim.keymap.set('n', '<leader>w', function() vscode.action('workbench.action.files.save') end, { desc = 'Save file' })

-- Buffer navigation
vim.keymap.set('n', '<M-n>', function() vscode.action('workbench.action.nextEditor') end, { desc = 'Next editor' })
vim.keymap.set('n', '<M-p>', function() vscode.action('workbench.action.previousEditor') end, { desc = 'Previous editor' })

-- Clear search highlight
vim.keymap.set('n', '<Esc>', function() vscode.action('cancelSelection') end, { desc = 'Clear selection/highlight' })

-- ============================================================================
-- Visual mode mappings
-- ============================================================================

vim.keymap.set('v', '<leader>]', function() vscode.action('workbench.action.findInFiles') end, { desc = 'Find in files' })

-- Paste without yanking in visual mode
vim.keymap.set('v', 'p', '"_dP', { desc = 'Paste without yanking' })

-- ============================================================================
-- LSP-like keybindings (using VS Code's built-in features)
-- ============================================================================

vim.keymap.set('n', 'gd', function() vscode.action('editor.action.revealDefinition') end, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', function() vscode.action('editor.action.revealDeclaration') end, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gi', function() vscode.action('editor.action.goToImplementation') end, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gR', function() vscode.action('editor.action.goToReferences') end, { desc = 'Go to references' })
vim.keymap.set('n', 'K', function() vscode.action('editor.action.showHover') end, { desc = 'Show hover' })
vim.keymap.set('n', '<leader>D', function() vscode.action('editor.action.goToTypeDefinition') end, { desc = 'Go to type definition' })
vim.keymap.set('n', '<leader>K', function() vscode.action('editor.action.triggerParameterHints') end, { desc = 'Signature help' })

-- ============================================================================
-- vim-surround & Comment.nvim are now loaded via lazy.nvim above
-- ============================================================================
--
-- SURROUND (vim-surround):
--   ys{motion}{char}  - add surround (e.g., ysiw" adds quotes around word)
--   ds{char}          - delete surround (e.g., ds" removes surrounding quotes)
--   cs{old}{new}      - change surround (e.g., cs"' changes " to ')
--   S{char}           - in visual mode, surround selection
--
-- COMMENTARY (Comment.nvim):
--   gcc               - toggle comment on line
--   gc{motion}        - toggle comment on motion (e.g., gcap for paragraph)
--   gc                - in visual mode, toggle comment on selection
