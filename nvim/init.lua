-- Leader key configuration
vim.g.mapleader = " "

-- Plugin configuration
local plugins = {
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "madox2/vim-ai",
    "airblade/vim-gitgutter",
    "jesseleite/vim-agriculture",
    "jiangmiao/auto-pairs",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "lambdalisue/suda.vim",
    "morhetz/gruvbox",
    "nvim-treesitter/nvim-treesitter",
    "preservim/nerdtree",
    "ryanoasis/vim-devicons",
    "scrooloose/nerdcommenter",
    "shaunsingh/nord.nvim",
    "tpope/vim-fugitive",
    "tpope/vim-surround",
    "tpope/vim-vinegar",
    "vim-airline/vim-airline",
    "vim-airline/vim-airline-themes",
    "tveskag/nvim-blame-line",
}

-- Lazy loading configuration
local lazy_config = {
    enable = true,
    disable_commands = true
}

-- Lazy loading path setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--depth=1",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, lazy_config)
require("mason").setup()

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}

-- Token counting function definition
function CountTokens()
    local output = vim.fn.system('python3 ~/scripts/count_token_vim.py', table.concat(vim.fn.getline(1, '$'), "\n"))
    print(output)
end
vim.cmd("command! TokenCount lua CountTokens()")

-- AI configurations and global settings
vim.g.copilot_node_command = "~/.nvm/versions/node/v18.18.2/bin/node"
vim.g.vim_ai_chat = {
    options = {
        model = "gpt-4-0613",
        temperature = 0.5,
        max_tokens = 2048,
    },
}

-- NERDTree settings
vim.g.NERDTreeWinSize = 40

-- FZF and airline configurations
vim.g.fzf_history_dir = '~/.vim/fzf_history'
vim.g.airline_extensions_tabline_enabled = 1
vim.g.airline_extensions_tabline_formatter = 'unique_tail'
vim.g.airline_extensions_branch_displayed_head_limit = 20
vim.g.airline_solorized_bg = 'dark'
vim.g.airline_theme = 'minimalist'
vim.g.airline_powerline_fonts = 1
vim.g.bargreybars_auto = 0

-- Editor options
vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = 'noinsert,menuone,noselect'
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.autoindent = true
vim.opt.inccommand = 'split'
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.wildmenu = true
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')
vim.opt.ttyfast = true
vim.opt.undofile = true
vim.opt.undodir = '~/.vim/undodir'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.background = 'dark'
vim.cmd('colorscheme nord')


-- Key mappings
vim.api.nvim_set_keymap('n', '<C-N>', ':bnext<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-P>', ':bprev<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader><enter>', ':Files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>]', ':Ag<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>]', '"uy:AgRaw -Q \'<c-r>u\'<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>b', ':Buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>\\', ':History<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>P', ':let @+ = expand(\'%:~:.\') . \':\' . line(\'.\')<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>W', ':%bd<Bar>e#<Bar>bd#<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>q', ':bd<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<silent> <Esc>', ':nohl<CR><Esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>r', ':NERDTreeFind<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>e', ':NERDTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>no', ':copen<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>nc', ':cclose<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>nn', ':cnext<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>np', ':cprev<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>h1', 'iAI, please condense the conversation up to this point into a single title and format it in snake_case.<esc>:AIC<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>h2', 'yi"O~/aichat/<C-r>+.aichat<esc>dd:w <C-r>+<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>h3', ':echo system(\'python3 ~/scripts/count_token_vim.py\', getline(1, \'$\'))<cr>', {noremap = true})
vim.api.nvim_set_keymap('i', '<c-enter>', '<esc>:AIC<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<silent> <leader>`', ':ToggleBlameLine<CR>', {noremap = true})

-- Treesitter configuration for better syntax highlighting
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
}
