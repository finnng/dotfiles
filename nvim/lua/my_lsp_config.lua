local lspconfig = require("lspconfig")

local configs = require("lspconfig/configs")

require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			on_attach = function(client, bufnr)
				-- it breaks the syntax highlight if we don't disable it
				client.server_capabilities.semanticTokensProvider = nil
			end,
		})
	end,

	["ts_ls"] = function()
		lspconfig.ts_ls.setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.semanticTokensProvider = nil
			end,
		})
	end,

	["tailwindcss"] = function()
		lspconfig.tailwindcss.setup({
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
		lspconfig.gopls.setup({
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
})
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--vim.keymap.set("n", "<m-e>", vim.diagnostic.open_float)
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
local function toggle_location_list()
	-- Get the current window number
	local current_win = vim.api.nvim_get_current_win()

	-- Get the location list for the current window
	local loc_list = vim.fn.getloclist(0, { winid = 0 })

	-- If the location list window is open, close it
	if loc_list.winid ~= 0 and vim.api.nvim_win_is_valid(loc_list.winid) then
		vim.api.nvim_win_close(loc_list.winid, true)
	else
		-- If the location list window is not open, set it using the LSP diagnostic
		vim.diagnostic.setloclist()
	end

	-- Return focus to the original window
	vim.api.nvim_set_current_win(current_win)
end

-- Map the toggle function to <m-l>
vim.keymap.set("n", "<m-l>", toggle_location_list)

-- Disable virtual text for
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
	local client = vim.lsp.get_client_by_id(ctx.client_id)

	if client.name == "tsserver" then
		-- Disable virtual text for tsserver
		local opts = vim.tbl_deep_extend("force", {
			virtual_text = false,
		}, config or {})
	end

	-- Call the default handler with modified options
	vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, opts)
end
