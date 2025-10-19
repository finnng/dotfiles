local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("snippy").expand_snippet(args.body)
		end,
	},
	window = {},
	mapping = cmp.mapping.preset.insert({
		["<C-e>"] = cmp.mapping.abort(),
		-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "snippy" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
	"bashls",
	"ts_ls",
	"pyright",
	"gopls",
	"yamlls",
	"html",
	"cssls",
	"csharp_ls",
	"templ",
	"tailwindcss",
	"htmx",
}

for _, lsp in ipairs(servers) do
	vim.lsp.config[lsp] = { capabilities = capabilities }
end

require("snippy").setup({
	mappings = {
		is = {
			["<c-9>"] = "expand_or_advance",
			["<c-0>"] = "previous",
		},
		nx = {
			["<leader>x"] = "cut_text",
		},
	},
})
