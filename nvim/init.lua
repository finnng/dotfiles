-- disable netrw for tree plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

-- Plugin configuration
local plugins = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"madox2/vim-ai",
	--"junegunn/fzf",
	--"junegunn/fzf.vim",
	"lambdalisue/suda.vim",
	"morhetz/gruvbox",
	"nvim-treesitter/nvim-treesitter",
	"ryanoasis/vim-devicons",
	"scrooloose/nerdcommenter",
	"tpope/vim-fugitive",
	"tpope/vim-surround",
	"tpope/vim-vinegar",
	"nvim-lualine/lualine.nvim",
	"nvim-tree/nvim-web-devicons",
	"tveskag/nvim-blame-line",
	"github/copilot.vim",
	"mhartington/formatter.nvim",
	"mhinz/vim-signify",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"RRethy/nvim-base16",
	"RRethy/vim-illuminate",
	"shaunsingh/nord.nvim",
	"hood/popui.nvim",
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"leoluz/nvim-dap-go",
	{ "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
	"theHamsta/nvim-dap-virtual-text",
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("fzf_config").configureFzfLua()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
}

-- Lazy loading configuration
local lazy_config = {
	enable = true,
	disable_commands = true,
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
require("mason-lspconfig").setup()

-- custom lua files, the order is important completion_config should be loaded before lsp
require("completion_config")
require("my_lsp_config")
require("tree_config")
require("aichat_config")
require("format_config")
require("linting_config")
require("popui_config")
require("fzf_config")
require("scratch_config")
require("dap_config")
require("lualine_config")

vim.cmd("colorscheme nord")

-- Editor options
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "noinsert,menuone,noselect"
vim.opt.cursorline = true
vim.opt.hidden = true
vim.opt.autoindent = true
vim.opt.inccommand = "split"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.wildmenu = true
vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
vim.opt.ttyfast = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.background = "dark"
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.updatetime = 100

-- Key mappings
vim.api.nvim_set_keymap("n", "<C-N>", ":bnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-P>", ":bprev<CR>", { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<leader>P",
	":let @+ = expand('%:~:.') . ':' . line('.')<CR><bar>:echom @+<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>W", ":%bd<bar>e#<bar>bd#<cr>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":bd<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<esc>", ":nohl<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>no", ":copen<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>nc", ":cclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>nn", ":cnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>np", ":cprev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>`", ":ToggleBlameLine<CR>", { noremap = true, silent = true })

-- Treesitter configuration for better syntax highlighting
require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
	},
})
