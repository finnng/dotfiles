vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":Neotree reveal<CR>", { noremap = true, silent = true })
--vim.cmd([[autocmd VimEnter * ++nested Neotree filesystem position=left]])

require("neo-tree").setup({
	source_selector = {
		winbar = true,
		statusline = true,
	},
})
