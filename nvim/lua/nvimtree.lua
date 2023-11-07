-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

--:NvimTreeToggle Open or close the tree. Takes an optional path argument.
--:NvimTreeFocus Open the tree if it is closed, and then focus on the tree.
--:NvimTreeFindFile Move the cursor in the tree for the current buffer, opening folders if needed.
--:NvimTreeCollapse Collapses the nvim-tree recursively.
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeFindFile<CR>', { noremap = true })
