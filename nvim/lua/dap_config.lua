local dap, dapui = require("dap"), require("dapui")

require("dapui").setup({
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},
	element_mappings = {},
	expand_lines = true,
	floating = {
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	force_buffers = true,
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},
	layouts = {
		{
			elements = {
				--{
				--id = "scopes",
				--size = 0.25,
				--},
				{
					id = "breakpoints",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25,
				},
				--{
				--id = "watches",
				--size = 0.25,
				--},
				{
					id = "repl",
					size = 0.5,
				},
			},
			position = "left",
			size = 50,
		},
		{
			elements = {
				{
					id = "scopes",
					size = 1,
				},
				--{
				--id = "breakpoints",
				--size = 0.25,
				--},
				--{
				--id = "stacks",
				--size = 0.25,
				--},
				--{
				--id = "watches",
				--size = 0.25,
				--},
			},
			position = "right",
			size = 60,
		},
		{
			elements = {
				{
					id = "console",
					size = 1,
				},
			},
			position = "bottom",
			size = 10,
		},
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
	render = {
		indent = 1,
		max_value_lines = 100,
	},
})
-- dir    /Users/finn/.local/share/nvim/lazy/nvim-dap-vscode-js

vim.api.nvim_set_keymap("n", "<M-b>", ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<M-v>", ':lua require"dap".continue()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<M-n>", ':lua require"dap".step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<M-.>", ':lua require"dap".step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<M-,>", ':lua require"dap".step_out()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<M-m>", ':lua require"dapui".toggle()<CR>', { noremap = true })
vim.api.nvim_set_keymap("v", "<M-h>", ':lua require"dapui".eval()<CR>', { noremap = true })

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

-- DAP-VSCODE-JS
require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	node_path = "node",
	debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
	--debugger_path = "/Users/finn/.local/share/nvim/lazy/nvim-dap-vscode-js",

	-- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = {
		"chrome",
		"pwa-node",
		"pwa-chrome",
		"pwa-msedge",
		"node-terminal",
		"pwa-extensionHost",
		"node",
		"chrome",
	}, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

require("nvim-dap-virtual-text").setup()

local js_based_languages = { "typescript", "javascript", "typescriptreact" }

for _, language in ipairs(js_based_languages) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-chrome",
			request = "launch",
			name = 'Start Chrome with "localhost"',
			url = "http://localhost:3000",
			webRoot = "${workspaceFolder}",
			userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
		},
	}
end

require("dap-go").setup({
	-- Additional dap configurations can be added.
	-- dap_configurations accepts a list of tables where each entry
	-- represents a dap configuration. For more details do:
	-- :help dap-configuration
	dap_configurations = {
		{
			-- Must be "go" or it will be ignored by the plugin
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
	},
	-- delve configurations
	delve = {
		-- the path to the executable dlv which will be used for debugging.
		-- by default, this is the "dlv" executable on your PATH.
		path = "dlv",
		-- time to wait for delve to initialize the debug session.
		-- default to 20 seconds
		initialize_timeout_sec = 20,
		-- a string that defines the port to start delve debugger.
		-- default to string "${port}" which instructs nvim-dap
		-- to start the process in a random available port
    port = "${port}",
    --port = 1304,
		-- additional args to pass to dlv
		args = {},
		-- the build flags that are passed to delve.
		-- defaults to empty string, but can be used to provide flags
		-- such as "-tags=unit" to make sure the test suite is
		-- compiled during debugging, for example.
		-- passing build flags using args is ineffective, as those are
		-- ignored by delve in dap mode.
		build_flags = "",
	},
})
--dap.adapters.go = function(callback, config)
	---- Wait for delve to start
	--vim.defer_fn(function()
		--callback({ type = "server", host = "127.0.0.1", port = "port" })
	--end, 100)
--end
-- DAP UI

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end
