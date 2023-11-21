local lspconfig = require("lspconfig")

local configs = require("lspconfig/configs")

if not lspconfig.htmx then
	configs.htmx = {
		default_config = {
			cmd = { "htmx-lsp" },
			filetypes = { "html", "htm" },
			root_dir = lspconfig.util.root_pattern(".git/", ".hg/"),
		},
	}
end

lspconfig.htmx.setup({})
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({
			on_attach = function(client, bufnr)
				client.server_capabilities.semanticTokensProvider = nil
				-- Add any additional on_attach configuration here
			end,
		})
	end,
	-- Not support yet
	--htmx = {
	--cmd = { "htmx-lsp" },
	--filetypes = { "html", "htm" },
	--root_dir = require("lspconfig/util").root_pattern(".git/", ".hg/"),
	--},
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>i", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>o", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>L", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		--vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, opts)
		--vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		--vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		--vim.keymap.set('n', '<space>wl', function()
		--print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		--end, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gR', vim.lsp.buf.references, opts)
		--vim.keymap.set('n', '<leader>f', function()
		--vim.lsp.buf.format { async = true }
		--end, opts)
	end,
})

-- Disable virtual text for 
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  --if client.name == "tsserver" then
    -- Disable virtual text for tsserver
    local opts = vim.tbl_deep_extend("force", {
      virtual_text = false
    }, config or {})

    -- Call the default handler with modified options
    vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, opts)
  --else
    ---- Call the default handler for other language servers
    --vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
  --end
end
