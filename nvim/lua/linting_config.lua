local function setup_eslint_autocmd()
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.svelte", "*.html", "*.json", "*.css", "*.scss" },
		command = "EslintFixAll",
	})
end

setup_eslint_autocmd()
