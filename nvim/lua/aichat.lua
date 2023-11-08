-- AI configurations and global settings
vim.g.copilot_node_command = vim.fn.expand('~/.nvm/versions/node/v18.18.2/bin/node')

-- vim-ai-chat
vim.g.vim_ai_chat = {
  options = {
    model = "gpt-4-0613",
    temperature = 0.5,
    max_tokens = -1,
  },
}
vim.api.nvim_set_keymap('n', '<leader>h1',
  'iAI, please condense the conversation up to this point into a single title and format it in snake_case.<esc>:AIC<cr>',
  { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h2', 'yi"O~/aichat/<C-r>+.aichat<esc>dd:w <C-r>+<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h3',
  ':echo system(\'python3 ~/scripts/count_token_vim.py\', getline(1, \'$\'))<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>h4', ':AIN right<cr>', { noremap = true })

vim.api.nvim_set_keymap('i', '<c-enter>', '<esc>:AIC<cr>', { noremap = true })

-- Token counting function definition
function CountTokens()
  local script_path = vim.fn.expand('~/scripts/count_token_vim.py')
  local output = vim.fn.system('python3 ' .. script_path, table.concat(vim.fn.getline(1, '$'), "\n"))
  print(output)
end

vim.cmd("command! TokenCount lua CountTokens()")
