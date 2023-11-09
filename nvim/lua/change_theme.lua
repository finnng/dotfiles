function _G.open_theme_selector()

	-- Get the list of themes dynamically
	local themes = vim.fn.getcompletion("", "color")

	-- Buffer and window variables
	local buf, win

	-- Create a buffer for the theme selector
	buf = vim.api.nvim_create_buf(false, true)

	-- Make the buffer read-only
	vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

	-- Add the themes to the buffer
	vim.api.nvim_buf_set_option(buf, "modifiable", true) -- Temporarily allow modifications to set the lines
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, themes)
	vim.api.nvim_buf_set_option(buf, "modifiable", false) -- Revert to non-modifiable

	-- Calculate the width and height of the window
	local width = 80
	local height = math.min(#themes, 20) -- Limit height to 20 or the number of themes
	local row = math.ceil((vim.o.lines - height) / 2) - 1
	local col = math.ceil((vim.o.columns - width) / 2) - 1

	-- Create a floating window for the theme selector
	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		anchor = "NW",
		style = "minimal",
		border = "rounded",
		noautocmd = true,
	}
	win = vim.api.nvim_open_win(buf, true, opts)

	-- Function to change the selection only
	_G.ChangeSelection = function(direction)
		local current_line = vim.api.nvim_win_get_cursor(win)[1] + direction
		if current_line < 1 then
			current_line = #themes
		elseif current_line > #themes then
			current_line = 1
		end
		vim.api.nvim_win_set_cursor(win, { current_line, 0 })
	end

	_G.ApplyTheme = function()
		local current_line = vim.api.nvim_win_get_cursor(win)[1]
		local theme = themes[current_line]
		vim.cmd("colorscheme " .. theme)
	end

	-- Function to close the window
	_G.CloseWindow = function()
		vim.api.nvim_win_close(win, true)
	end

	-- Set up key mappings for the buffer
	local mappings = {
		["j"] = "ChangeSelection(1)",
		["k"] = "ChangeSelection(-1)",
		["<CR>"] = "ApplyTheme()", -- Enter key to set the theme and close the popup
		["<Esc>"] = "CloseWindow()", -- Escape key to close the popup
	}

	for k, v in pairs(mappings) do
		vim.api.nvim_buf_set_keymap(buf, "n", k, "<cmd>lua _G." .. v .. "<CR>", { noremap = true, silent = true })
	end
end

-- Map the open_theme_selector function to <leader>t
vim.api.nvim_set_keymap("n", "<leader>t", ":lua _G.open_theme_selector()<CR>", { noremap = true, silent = true })
