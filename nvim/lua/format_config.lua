local util = require("formatter.util")

local biome = function()
	return {
		exe = "biome",
		args = {
			"check",
			"--fix",
			"--stdin-file-path",
			util.escape_path(util.get_current_buffer_file_path()),
		},
		stdin = true,
	}
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },

		-- typescript = { require("formatter.filetypes.typescript").prettierd },
		-- typescriptreact = { require("formatter.filetypes.typescript").prettierd },
		-- javascript = { require("formatter.filetypes.typescript").prettierd },
		-- javascriptreact = { require("formatter.filetypes.typescript").prettierd },
		-- html = { require("formatter.filetypes.html").prettierd },
		-- css = { require("formatter.filetypes.css").prettierd },
		-- scss = { require("formatter.filetypes.css").prettierd },
		-- json = { require("formatter.filetypes.json").prettierd },
		-- yaml = { require("formatter.filetypes.yaml").prettierd },
		typescript = { biome },
		typescriptreact = { biome },
		javascript = { biome },
		javascriptreact = { biome },
		html = { biome },
		css = { biome },
		scss = { biome },
		json = { biome },
		yaml = { biome },

		python = { require("formatter.filetypes.python").black },
		go = { require("formatter.filetypes.go").goimports },

		svg = {
			function()
				return {
					exe = "prettierd",
					args = { util.escape_path(util.get_current_buffer_file_path()) },
					stdin = true,
				}
			end,
		},

		templ = {
			function()
				return {
					exe = "templ",
					args = { "fmt" },
					stdin = true,
				}
			end,
		},

		-- json = {
		-- 	function()
		-- 		return {
		-- 			exe = "prettier",
		-- 			args = { util.escape_path(util.get_current_buffer_file_path()) },
		-- 			stdin = true,
		-- 		}
		-- 	end,
		-- },
		--
		sh = { require("formatter.filetypes.sh").shfmt },

		sql = {
			function()
				return {
					exe = "sql-formatter",
					stdin = true,
				}
			end,
		},
		cs = {
			function()
				return {
					exe = "dotnet-csharpier",
					stdin = true,
				}
			end,
		},

		swift = {
			function()
				return {
					exe = "swift-format",
					stdin = true,
				}
			end,
		},

		rust = {
			function()
				return {
					exe = "rustfmt",
					args = { "--emit=stdout" },
					stdin = true,
				}
			end,
		},

		-- any filetype
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.api.nvim_set_keymap("n", "<leader>f", ":FormatWrite<CR>", { silent = true })

-- Automatically run :FormatWrite when a file is saved
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	command = "FormatWrite",
})
