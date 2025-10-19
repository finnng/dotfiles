require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "copilot",
		},
		inline = {
			adapter = "copilot",
		},
		agent = {
			adapter = "copilot",
		},
	},
})

-- Keybindings for CodeCompanion
vim.api.nvim_set_keymap("n", "<leader>h", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>h", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>cc", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>cc", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
