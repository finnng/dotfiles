require("codecompanion").setup({
	strategies = {
		chat = {
			adapter = "openai",
		},
		inline = {
			adapter = "openai",
		},
		agent = {
			adapter = "openai",
		},
	},
	adapters = {
		openai = function()
			return require("codecompanion.adapters").extend("openai", {
				env = {
					api_key = os.getenv("OPENAI_API_KEY"),
				},
        schema = {
          model = {
            default = "gpt-4o-mini",
          },
        },
			})
		end,
	},
})
vim.api.nvim_set_keymap("n", "<leader>h", ":CodeCompanionChat<cr>", { noremap = true })
