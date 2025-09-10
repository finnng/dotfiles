-- disable netrw for tree plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

local plugins = {
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"lambdalisue/suda.vim", -- sudo plugin to edit file as root
	"morhetz/gruvbox",
	"nvim-treesitter/nvim-treesitter",
	"ryanoasis/vim-devicons",
	"nvim-tree/nvim-web-devicons",
	{ "echasnovski/mini.nvim", version = false },
	{
		"numToStr/Comment.nvim", -- comment plugin
		opts = {},
		lazy = false,
	},
	"tpope/vim-fugitive", -- git plugin, e.g. :Gstatus, :Gblame
	"tpope/vim-surround", -- surround plugin, e.g. cs"' will change the surrounding ' to "
	"junegunn/gv.vim", -- git commit browser
	"nvim-lualine/lualine.nvim", -- statusline
	"tveskag/nvim-blame-line", -- git blame, display the inline blame
	"github/copilot.vim", -- github copilot
	"mhartington/formatter.nvim", -- code formatter
	"mhinz/vim-signify", -- git diff
	"hrsh7th/cmp-nvim-lsp", -- completion plugin
	"hrsh7th/cmp-buffer", -- completion plugin
	"hrsh7th/cmp-path", -- completion plugin
	"hrsh7th/cmp-cmdline", -- completion plugin
	"hrsh7th/nvim-cmp", -- completion plugin
	"RRethy/nvim-base16", -- base16 themes
	"RRethy/vim-illuminate", -- highlight the word under the cursor
	"shaunsingh/nord.nvim",
	"hood/popui.nvim", -- popup ui, this will affect all the nvim popup
	"dcampos/nvim-snippy",
	"dcampos/cmp-snippy",
	-- "honza/vim-snippets",
	"wakatime/vim-wakatime",
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
	{
		"tomasky/bookmarks.nvim", -- bookmarks plugin
		event = "VimEnter",
		config = function()
			require("bookmarks").setup()
		end,
	},
	"kevinhwang91/promise-async", -- folding plugin
	{ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }, -- folding plugin
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"echasnovski/mini.pick", -- optional
		},
		config = true,
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
			{
				"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
				opts = {},
			},
			"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
		},
		config = true,
	},
	"diepm/vim-rest-console",
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

-- Mason setup with proper configuration
require("mason").setup()
require("mason-lspconfig").setup({
	-- List of servers to automatically install and configure
	ensure_installed = { "ts_ls", "gopls", "tailwindcss" },
	-- Automatically install servers when they are configured
	automatic_installation = true,
	-- Setup handlers for automatic configuration
	handlers = {
		-- Default handler for all servers
		function(server_name)
			require("lspconfig")[server_name].setup({
				on_attach = function(client, bufnr)
					-- it breaks the syntax highlight if we don't disable it
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end,
		-- Custom handlers for specific servers
		["ts_ls"] = function()
			require("lspconfig").ts_ls.setup({
				on_attach = function(client, bufnr)
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end,
		["tailwindcss"] = function()
			require("lspconfig").tailwindcss.setup({
				cmd = { "tailwindcss-language-server", "--stdio" },
				filetypes = {
					"templ",
					-- html
					"ejs",
					"gohtml",
					"gohtmltmpl",
					"haml",
					"handlebars",
					"hbs",
					"html",
					"html-eex",
					"liquid",
					"markdown",
					"mdx",
					"mustache",
					"njk",
					"nunjucks",
					-- css
					"css",
					"less",
					"postcss",
					"sass",
					"scss",
					"stylus",
					"sugarss",
					-- js
					"javascript",
					"javascriptreact",
					"reason",
					"rescript",
					"typescript",
					"typescriptreact",
					-- mixed
					"vue",
					"svelte",
				},
				init_options = {
					userLanguages = {
						templ = "html",
					},
				},
			})
		end,
		["gopls"] = function()
			require("lspconfig").gopls.setup({
				settings = {
					gopls = {
						analyses = {
							shadow = true,
							unusedvariable = true,
							useany = true,
						},
						staticcheck = true,
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
					},
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_buf_set_option(bufnr, "expandtab", false)
					vim.api.nvim_buf_set_option(bufnr, "tabstop", 4)
					vim.api.nvim_buf_set_option(bufnr, "shiftwidth", 4)

					-- Enable autoformatting on save
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("GoFormat", {}),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,

	},
})

-- Configure SourceKit-LSP directly (not managed by Mason since it comes with Xcode)
require("lspconfig").sourcekit.setup({
	cmd = { "sourcekit-lsp" },
	filetypes = { "swift", "objective-c", "objective-cpp" },
	on_attach = function(client, bufnr)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

-- custom lua files, the order is important completion_config should be loaded before lsp
require("completion_config")
require("tree_config")
require("aichat_config")
require("format_config")
-- require("linting_config")
require("popui_config")
require("fzf_config")
require("scratch_config")
require("lualine_config")
require("bookmarks_config")

vim.cmd("colorscheme nord")

-- additional filetypes
vim.filetype.add({
	extension = {
		templ = "templ",
		swift = "swift",
	},
})
vim.o.signcolumn = "auto:1" -- keep the sign column fixed size
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.hidden = true

vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.inccommand = "split"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.title = true
vim.opt.wildmenu = true
vim.opt.ttyfast = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.background = "dark"

vim.opt.updatetime = 100
vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- Fix the problematic fillchars setting
vim.o.fillchars = "eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸"

vim.api.nvim_set_keymap("n", "<M-n>", ":bnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-p>", ":bprev<CR>", { noremap = true })
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
vim.api.nvim_set_keymap("n", "<leader>`", ":ToggleBlameLine<CR>", { noremap = true, silent = true })

_G.toggle_quickfix = function()
	local qf_open = false
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			qf_open = true
			break
		end
	end
	if qf_open then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

-- quickfix window key mapping
vim.api.nvim_set_keymap("n", "<C-\\>", ":lua _G.toggle_quickfix()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", ":cnext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-p>", ":cprevious<CR>", { noremap = true })

require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		disable = { "go" },
	},
	incremental_selection = {
		enable = true,
	},
})

-- Folding plugin setup
require("ufo").setup({
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
})

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

-- Comment plugin setup
require("Comment").setup()
local ft = require("Comment.ft")
ft.set("templ", "//%s", "/*%s*/")
ft.set("swift", "//%s", "/*%s*/")

vim.api.nvim_create_augroup("PythonSpaces", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "PythonSpaces",
	pattern = "python",
	callback = function()
		vim.opt_local.list = true
		-- vim.opt_local.listchars = 'space:·'
		vim.opt_local.listchars = "space:˙"
	end,
})

-- for vim-rest-console, I can't user c-j
vim.keymap.set("v", "<M-i>", ":call VrcQuery()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<M-i>", ":call VrcQuery()<CR>", { noremap = true, silent = true })
vim.keymap.set("i", "<M-i>", "<Esc>:call VrcQuery()<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "p", '"_dP', { desc = "Paste in visual mode without yanking" })

-- LSP keymaps (since we're not loading my_lsp_config.lua anymore)
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>i", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>o", vim.diagnostic.goto_next)
vim.keymap.set("n", "<m-e>", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)
	end,
})
