require("lualine").setup()

-- Custom branch component with truncation
local function truncated_branch()
	local git_dir_path = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
	if git_dir_path == "" then
		return "" -- Not a Git repository
	end

	local head_file = git_dir_path .. "/HEAD"
	local head_contents = vim.fn.readfile(head_file)
	if #head_contents == 0 then
		return "" -- HEAD file is empty or does not exist
	end

	local branch_name = head_contents[1]:match("ref: refs/heads/(.+)") or "HEAD detached"
	local max_length = 20
	if #branch_name > max_length then
		return branch_name:sub(1, max_length) .. "..."
	else
		return branch_name
	end
end

-- Lualine setup
require("lualine").setup({
	sections = {
		lualine_b = {
			{ truncated_branch, icon = "" }, -- Adjust the icon as needed
		},
	},
	tabline = {
		-- Define what's shown in the tabline
		lualine_a = { "buffers" }, -- Shows buffer list in tabline
		lualine_b = {}, -- Can customize with other components
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" }, -- Shows tabs in tabline
	},
})
