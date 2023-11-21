--vim.g.fzf_history_dir = vim.fn.expand("~/.vim/fzf_history")

--vim.cmd([[ let g:fzf_preview_window = 'up:70%' ]])
--vim.cmd([[ let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } } ]])
--vim.cmd([[
--let $FZF_DEFAULT_OPTS="-m --height 80% --border
--\ --bind ctrl-y:preview-up,ctrl-e:preview-down,
--\ctrl-b:preview-page-up,ctrl-f:preview-page-down,
--\ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
--]])

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
vim.api.nvim_set_keymap("n", "<leader>]", ":FzfLua live_grep_resume<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>b", ":FzfLua buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>\\", ":FzfLua oldfiles<CR>", { noremap = true })

-- This is for fzf.lua, it reflects the same settings as above
local M = {}
M.configureFzfLua = function()
	require("fzf-lua").setup({
		winopts = {
			height = 0.90,
			width = 0.90,
			preview = {
				layout = "vertical",
				vertical = "up:70%", -- Preview at the top, taking up 70% of the screen
				flip_columns = 120, -- Flip to horizontal if the window is narrower than 120 columns
			},
		},
		--keymap = {
		--},
		fzf_opts = {
			["--layout"] = "default",
		},
	})
end

return M
