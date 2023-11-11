local fzf_lua = require("fzf-lua")

local function open_scratch_buffer(filetype)
	local date_time = os.date("%Y-%m-%d_%H-%M-%S")
	local scratch_dir = vim.fn.expand("~/.vim/scratches/")
	local filename = scratch_dir .. date_time .. "." .. filetype

	vim.fn.mkdir(scratch_dir, "p")
	vim.cmd("vnew " .. vim.fn.fnameescape(filename))
	vim.api.nvim_buf_set_option(0, "filetype", filetype)
	vim.api.nvim_command("write")
end

function _G.select_filetype_and_create_scratch()
	local syntax_dir = vim.fn.globpath(vim.fn.getenv("VIMRUNTIME"), "syntax/*.vim", false, true)
	local filetypes = {}

	for _, filepath in ipairs(syntax_dir) do
		local filetype = filepath:match("syntax[/\\](.+).vim$")
		if filetype then
			table.insert(filetypes, filetype)
		end
	end

	fzf_lua.fzf_exec(filetypes, {
		prompt = "Filetypes> ",
		actions = {
			["default"] = function(selected)
				open_scratch_buffer(selected[1])
			end,
		},
	})
end
vim.api.nvim_set_keymap("n", "<leader>t", ":lua _G.select_filetype_and_create_scratch()<CR>", { noremap = true })
