" Keys mapping
let mapleader = "\<space>"
tnoremap <F2> <C-\><C-n>
map <esc> :w\|:noh<cr>
map <leader><enter> :
map <leader>[ :Files <cr>
map <leader>] :Ag<space>
map <leader>\ :History<cr>
map <leader>f :PrettierAsync<cr>
map <leader>b :Buffers <cr>
map <leader>e :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>
map <leader>p :let @+ = expand("%")<cr>
map <leader>P :let @+ = join([expand('%'),  line(".")], ':')
map <leader>w <C-w>w
map <leader>v <C-w>v
map <leader>c :bd!<cr>
map <leader>q :q<cr>
map <leader>h <C-w>h 
map <leader>l <C-w>l
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>n :tabnew<cr>
map <leader>o :%bd\|e#<cr>
map <leader>O :%bd\|:q<cr>
map <leader>t :tabnew<bar>terminal<cr>i 

" x won't replace copied value
nnoremap x "_x
nnoremap <leader>d "_d
nnoremap <leader>D "_D
vnoremap <leader>d "_d

set t_Co=256
set termguicolors
set guifont=Meslo\ LG\ S\ DZ\ Regular\ Nerd\ Font\ Complete\ Mono:h15
colorscheme cobalt2 

" Macro
let @a="viwdi'\<esc>pa'\<esc>"
let @c="iconsole.log('-----', )\<esc>F,a\<space>"
let @j="viws/*<esc>pa */<esc>"

" Folding setting
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=20

" Disable MacVim scroll bar left and right
set guioptions=

" Ignore case sensitive when search
set ignorecase

" Enable clipboard to copy from system
set clipboard=unnamedplus

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

" Set persisten undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

" Set no backup
set nobackup
set nowb
set noswapfile

" Always show the nerdtree
" autocmd vimenter * NERDTree

" Tags
set tags=tags;/

" Auto reload file changes: check one time after 4s of inactivity in normal mode
set autoread                                                                                                                                                                                    
au CursorHold * checktime  

call plug#begin('~/.vim/plugged')

" Prettier
Plug 'prettier/vim-prettier', {'do': 'npm install' }
" Config for auto format
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1

" Color Schemes
Plug 'flazz/vim-colorschemes'

" NERD Commenter
Plug 'scrooloose/nerdcommenter'
" Need to enable plugin to work correctly
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'both'

" NERDtree
Plug 'scrooloose/nerdtree'
" show hidden file
let NERDTreeShowHidden=1

" Nerdtree git plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" Highlight the search result 
Plug 'jremmen/vim-ripgrep'
" true if you want matches highlighted
let g:rg_highlight = 1
" list of files/dir found in project root
let g:rg_root_types = ['.git', 'node_modules', 'coverage', 'logs']

" Ale
Plug 'w0rp/ale'
let g:ale_linters = { 'javascript': ['eslint'] }
" ﰲ     
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_column_always = 1
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
hi ALEErrorSign guifg=#FF0000
hi ALEWarningSign guifg=#FFD700

" Vim file type icons
Plug 'ryanoasis/vim-devicons'

" Show git diff
Plug 'airblade/vim-gitgutter'
set updatetime=100

" code complete
Plug 'valloric/youcompleteme'
" make YMC compatible with UltiSnips
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" Override YMC's signs
let g:ycm_error_symbol = ''
let g:ycm_warning_symbol = ''
hi YcmErrorSign guifg=#FF0000
hi YcmWarningSign guifg=#FFD700

" Waka time
Plug 'wakatime/vim-wakatime'

" Auto pairs the bracket [ { (...
Plug 'jiangmiao/auto-pairs'

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

" Snipet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Graphql for vim
Plug 'jparise/vim-graphql'

call plug#end()
