vim.ui.select = require("popui.ui-overrider")
vim.ui.input = require("popui.input-overrider")
vim.api.nvim_set_keymap(
	"n",
	"<space>d",
	':lua require"popui.diagnostics-navigator"()<CR>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<space>m", ':lua require"popui.marks-manager"()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	"gr",
	':lua require"popui.references-navigator"()<CR>',
	{ noremap = true, silent = true }
)
