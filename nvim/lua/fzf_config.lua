-- FZF and airline configurations
vim.g.fzf_history_dir = vim.fn.expand("~/.vim/fzf_history")

vim.cmd([[ let g:fzf_preview_window = 'up:70%' ]])
vim.cmd([[ let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } } ]])
vim.cmd([[
let $FZF_DEFAULT_OPTS="-m --height 80% --layout=reverse --border
\ --bind ctrl-y:preview-up,ctrl-e:preview-down,
\ctrl-b:preview-page-up,ctrl-f:preview-page-down,
\ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
]])

--\shift-up:preview-top,shift-down:preview-bottom,
--\alt-up:half-page-up,alt-down:half-page-down"
