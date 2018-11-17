" Keys mapping
map ;; :
map <esc> :w\|:noh<cr>
map <C-p> :Files <cr>
map <leader><bs> :Files <cr>
map <leader><enter> :Ag<space>
map <leader>a :GitBlame<cr>
map <leader>s :PrettierAsync<cr>
map <leader>b :Buffers <cr>
map <leader>e :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>
map <leader>p :let @+ = expand("%")<cr>
map <leader>w <C-w>w
map <leader>v <C-w>v
map <leader>q <C-w>c
map <leader>h <C-w>h 
map <leader>l <C-w>l
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>t :tabnew<cr>
map <leader>o :%bd\|e#<cr>

nnoremap x "_x
nnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>d "_d

set t_Co=256
set termguicolors
set guifont=Meslo\ LG\ S\ DZ\ Regular\ Nerd\ Font\ Complete\ Mono:h13
colorscheme cobalt2 

" Disable MacVim scroll bar left and right
set guioptions=

" Ignore case sensitive when search
set ignorecase

" Enable clipboard to copy from system
set clipboard+=unnamed

" Hightlight all the search matches
set hlsearch

set encoding=utf8

" Flag to support indent
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

" Need to zshell because I'm using it, make sure nothing broken
set shell=/bin/zsh

" Using mouse
set mouse=a

" Show line number
set nu

" Use vimrc 
set nocompatible

" Show code syntax
syntax enable

" Always split new windows right
set splitright

" Always show the nerdtree
" autocmd vimenter * NERDTree

call plug#begin('~/.vim/plugged')

" Prettier
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }
" Config for auto format
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1

" CtrlP
" Plug 'ctrlpvim/ctrlp.vim'
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Color Schemes
Plug 'flazz/vim-colorschemes'

" NERD Commenter
Plug 'scrooloose/nerdcommenter'
" Need to enable plugin to work correctly
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" For jsx
let g:NERDCustomDelimiters = { 'javascript.jsx': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/'  }  }


" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'both'

" NERDtree
Plug 'scrooloose/nerdtree'

" Highlight the search result 
Plug 'jremmen/vim-ripgrep'
" true if you want matches highlighted
let g:rg_highlight = 1
" list of files/dir found in project root
let g:rg_root_types = ['.git', 'node_modules', 'coverage', 'logs']

" Ale
Plug 'w0rp/ale'
let g:ale_linters = { 'javascript': ['eslint'] }

" Vim file type icons
Plug 'ryanoasis/vim-devicons'

" Show git diff
Plug 'airblade/vim-gitgutter'
set updatetime=1000

" code complete
Plug 'valloric/youcompleteme'

" Waka time
Plug 'wakatime/vim-wakatime'

" Auto pairs the bracket [ { (...
Plug 'jiangmiao/auto-pairs'

" Multiple cursor
" Plug 'terryma/vim-multiple-cursors'

" Javascript syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Enable syntax for jsdocs
let g:javascript_plugin_jsdoc = 1

" FZF plugin
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Git plugin
Plug 'tpope/vim-fugitive'

" Git blame status
Plug 'zivyangll/git-blame.vim'

call plug#end()
