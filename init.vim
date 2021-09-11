let $FZF_DEFAULT_COMMAND="ag -Q --nogroup --nocolor --column --hidden -l"
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all,ctrl-d:deselect-all --color=bg:#3d3d3c --inline-info'

let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1

set incsearch
set cursorline
set smartcase
set background=dark

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Ag with preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%', '?'),
  \                 <bang>0)

" " Rag search within specific directory
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

let mapleader = "\<space>"
nmap <esc> :noh<cr>
tnoremap <esc> <C-\><C-n>:q<cr>
map <leader>w :w<cr>
map <leader><enter> :Files<cr>
map <leader>[ yiw:Rag<space><C-R><C-+><space><C-R><S-%>
map <leader>{ :Rag <C-R><C-%>
map <leader>\ :History<cr>
map <leader>] :Ag<cr>
nmap <leader>} yiw:Ag<space><C-R><S-+><cr>
vmap <leader>} y:Ag<space><C-R><S-+><cr>
map <leader>b :Buffers<cr>
map <leader>a <Plug>(coc-codeaction)
map <leader>f :Prettier<cr>
map <leader>t :tabnew<cr>
map <leader>q :q<cr>
map <leader>e :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>\|zz
map <leader>n :set nohlsearch<cr>
map <leader>N :set hlsearch<cr>
map <leader>gb :GitBlame<cr>
nmap <leader>R <Plug>(coc-rename)
nmap <silent><leader>i <Plug>(coc-diagnostic-prev)
nmap <silent><leader>o <Plug>(coc-diagnostic-next)
nnoremap <silent><leader>E :redir @+<cr>:1message<cr>:redir END<cr>

" Search and highlight but do not jump
nnoremap * *``
nnoremap * :keepjumps normal! mi*`i<CR>

" Apply AutoFix to problem on the current line.
nmap <leader>F  <Plug>(coc-fix-current)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" coc-snippets tab to trigger complete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <C-g> for trigger snippet expand.
imap <C-g> <Plug>(coc-snippets-expand)
let g:coc_snippet_next = '<Down>'
let g:coc_snippet_prev = '<Up>'

" Copy file path to the clipboard
map <leader>P :let @+ = expand("%")<cr>

" Copy full file path to the clipboard
" map <leader>P :let @+ = join([expand('%'),  line(".")], ':')<cr>

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

" Move line up and down in normal mode and visual mode
noremap ∆ <Esc>:m .+1<CR>
noremap ˚ <Esc>:m .-2<CR>
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Split panel switching
noremap ¬ <C-w>l
noremap ˙ <C-w>h
" noremap ˚ <C-w>k
" noremap ∆ <C-w>j

" Jump between quick fix list
noremap ≥ :cn<CR>
noremap ≤ :cp<CR>

" Commands
:command Json :set filetype=json
:command Js   :set filetype=javascript

" Always split new windows right
set splitright

" Set theme, font and color scheme
set t_Co=256
set termguicolors

" Hide mode in the bottom e.g., -- INSERT --
set noshowmode

" Folding setting
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=20

" Ignore case sensitive when search
set ignorecase

" Enable clipboard to copy from system
set clipboard=unnamedplus

" Hightlight all the search matches
set hlsearch

set encoding=utf8

" Flag to support indent
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2

" Using mouse
set mouse=a

" Show line number
set nu rnu

" Use vimrc
set nocompatible

" Show code syntax
syntax enable

" Set persisten undo
set undofile
set undodir=~/.config/nvim/undodir-0.5.0
set undolevels=1000
set undoreload=10000

" Set no backup
set nobackup
set nowritebackup
set nowb
set noswapfile

" Auto reload file changes: check one time after 4s of inactivity in normal mode
set autoread
au CursorHold * checktime

" Set update time for git-gutter and coc
set updatetime=200

" hidden closed buffer
set hidden

" Need to enable plugin to work correctly
filetype plugin on

call plug#begin('~/.config/nvim/plugged')

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" let g:airline_powerline_fonts = 1
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" Remove the file type part
let g:airline_section_y = ''
let g:airline_skip_empty_sections = 1

" Airline theme
" let g:airline_theme = 'spaceduck'

" " Hide the git hunk
" let g:airline_section_b = '%{airline#util#wrap(strpart(airline#extensions#branch#get_head(),0,11),0)}'
let g:airline_section_b = ''

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
let g:NERDTreeWinSize=50
let g:NERDTreeStatusline="%{substitute(getcwd(), '^.*/', '', '')}"

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
let g:coc_node_path = '/Users/finn/.nvm/versions/node/v14.17.6/bin/node'
let g:coc_global_extensions=['coc-tsserver', 'coc-flow', 'coc-eslint', 'coc-json', 'coc-prettier', 'coc-snippets']

Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
let g:prettier#exec_cmd_path = $HOME."/.nvm/versions/node/v10.15.1/bin/prettier"
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0
let g:prettier#config#parser = 'babylon'

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 }}
let g:fzf_layout = { 'down': '~60%' }
" let g:fzf_preview_window = []
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []

" Git plugin for gdiff command
Plug 'tpope/vim-fugitive'

" Git blame status
Plug 'zivyangll/git-blame.vim'

" Snipet
Plug 'honza/vim-snippets'

Plug 'tpope/vim-surround'

" Typescript
Plug 'leafgarland/typescript-vim'

" Rust
" Plug 'rust-lang/rust.vim'

Plug 'lambdalisue/suda.vim'

" An always-on highlight for a unique character in every word on a line to help you use f, F and family.
Plug 'unblevable/quick-scope'

" Plug 'dart-lang/dart-vim-plugin'

" Plug 'aserebryakov/vim-todo-lists'
" let g:VimTodoListsMoveItems = 0
" let g:VimTodoListsDatesEnabled = 1

Plug 'AndrewRadev/tagalong.vim'

Plug 'psliwka/vim-smoothie'

" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'arcticicestudio/nord-vim'

Plug 'sindrets/diffview.nvim'

Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

colorscheme nord
