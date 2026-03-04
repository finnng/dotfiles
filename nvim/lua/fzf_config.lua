_G.searchLiveGrepWithSelection = function()
	local original_pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd('normal! gv"xy')
	local search_text = vim.fn.getreg("x")
	vim.api.nvim_win_set_cursor(0, original_pos)
	require("fzf-lua").live_grep({ search = search_text })
end

_G.searchFilesWithSelection = function()
	local original_pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd('normal! gv"xy')
	local search_text = vim.fn.getreg("x")
	search_text = search_text:gsub("%W", "")
	vim.api.nvim_win_set_cursor(0, original_pos)
	require("fzf-lua").files({ fzf_opts = { ["--query"] = search_text } })
end

-- Key mappings
vim.api.nvim_set_keymap("n", "<leader><CR>", ":FzfLua files<CR>", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader><CR>", ":lua searchFilesWithSelection()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<leader>]", ":lua searchLiveGrepWithSelection()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>]", ":FzfLua live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":FzfLua buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>\\", ":FzfLua oldfiles<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>s", ":FzfLua lsp_document_symbols<CR>", { noremap = true })

-- fzf-lua configuration
local M = {}
M.configureFzfLua = function()
	require("fzf-lua").setup({
		winopts = {
			height = 0.90,
			width = 0.90,
			preview = {
				layout = "vertical",
				vertical = "up:70%",
				flip_columns = 120,
			},
		},
		fzf_opts = {
			["--layout"] = "default",
		},
		-- Enable search history with ctrl-n/ctrl-p navigation
		files = {
			fzf_opts = {
				["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-files-history",
			},
		},
		grep = {
			fzf_opts = {
				["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-grep-history",
			},
		},
	})
end

return M
