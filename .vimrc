" Keys mapping
let mapleader = "\<space>"
map <esc> :w\|:noh<cr>
map <leader><enter> :Files<cr>
map <leader>[ :GitFiles <cr>
map <leader>\ :History<cr>
map <leader>] :Ag<space>
map <leader>b :Buffers <cr>
map <leader>f :PrettierAsync<cr>
map <leader>n :tabnew<cr>
map <leader>q :q<cr>
map <leader>e :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>
map <silent> <leader>t :tabnew<bar>terminal<cr>i
map gb :GitBlame<cr>
nmap <leader>rn <Plug>(coc-rename)

map <leader>i :ALEPrevious<cr>
map <leader>o :ALENext<cr>	

" Copy file path to the clipboard
map <leader>p :let @+ = expand("%")<cr>
" Copy full file path to the clipboard
map <leader>P :let @+ = join([expand('%'),  line(".")], ':')<cr>

" ESC in terminal mode
tnoremap <F2> <C-\><C-n>

" Delete current buffer, includes terminal buffer
map <F3> :bd!<cr>

map <F4> :%bd!\|e#<cr>

" Close all buffers and quit Vim
map <F12> :%bd\|:q<cr>

" Delete without yanking to clipboard "
vnoremap <leader>d "_d
vnoremap <leader>D "_D
vnoremap <leader>s "_s
vnoremap <leader>S "_S

nnoremap <leader>d "_d
nnoremap <leader>D "_D
nnoremap <leader>s "_s
nnoremap <leader>S "_S

nnoremap x "_x

" Paste without copy the selected text to clipboard
xnoremap p "_dP

" Always split new windows right
set splitright

" Set theme, font and color scheme
set t_Co=256
set termguicolors
set guifont=Meslo\ LG\ S\ DZ\ Regular\ Nerd\ Font\ Complete\ Mono:h15
set background=dark
colorscheme papercolor

" Hide mode in the bottom e.g., -- INSERT --
set noshowmode

" Folding setting
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=20

" Disable MacVim scroll bar left and right
" set guioptions=

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
set relativenumber

" Use vimrc
set nocompatible

" Show code syntax
syntax enable

" Set persisten undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

" Set no backup
set nobackup
set nowritebackup
set nowb
set noswapfile

" Tags
set tags=tags;

" Auto reload file changes: check one time after 4s of inactivity in normal mode
set autoread
au CursorHold * checktime

" Set update time for git-gutter and coc
set updatetime=100

" hidden closed buffer
set hidden

" Need to enable plugin to work correctly
filetype plugin on

call plug#begin('~/.vim/plugged')

" Prettier
Plug 'prettier/vim-prettier', {'do': 'npm install' }
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
let g:prettier#config#parser = 'babylon'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
" Hide the git hunk
let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'

" Remove the file type part
let g:airline_section_y = ''
let g:airline_skip_empty_sections = 1
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" Airline theme
let g:airline_theme = 'papercolor'

" Color Schemes
Plug 'flazz/vim-colorschemes'

" NERD Commenter
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'both'

" NERDtree
Plug 'scrooloose/nerdtree'
" show hidden file
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1

" Completion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} let g:deoplete#enable_at_startup = 1

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

" Ale ﰲ     
Plug 'w0rp/ale'
let g:ale_completion_enabled = 0
let g:ale_linters_explicit = 1	
let g:ale_linters = { 'javascript': ['eslint'] }	
let g:ale_sign_error = ''	
let g:ale_sign_warning = ''	
let g:ale_sign_column_always = 1	
hi ALEErrorSign guifg=#FF0000	
hi ALEWarningSign guifg=#FFD700

" Vim file type icons
Plug 'ryanoasis/vim-devicons'

" Show git diff
Plug 'airblade/vim-gitgutter'

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

" Git plugin for gdiff command
Plug 'tpope/vim-fugitive'

" Git blame status
Plug 'zivyangll/git-blame.vim'

" Graphql for vim
Plug 'jparise/vim-graphql'

" Manage the tags
Plug 'ludovicchabant/vim-gutentags'

" Snipet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'tpope/vim-surround'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()
