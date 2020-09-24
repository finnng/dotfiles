set cursorline
let $darkcolor='quantum'
let $whitecolor='PaperColor'

set background=dark
colorscheme $darkcolor

" set listchars=space:.,tab:>-
" set list

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')
  let height = float2nr(20)
  let width = float2nr(180)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 0 " float2nr((&lines - height))

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

let mapleader = "\<space>"
map <esc> :w\|:noh<cr>
map <leader><enter> :Files<cr>
map <leader>[ :GitFiles <cr>
map <leader>\ :History<cr>
map <leader>] :Ag<space>
map <leader>} yiw:Ag<space><C-R><S-+><cr>
map <leader>b :Buffers <cr>
map <leader>f :ALEFix<cr>
map <leader>n :tabnew<cr>
map <leader>q :q<cr>
map <leader>e :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>\|zz
" map <silent> <leader>t :tabnew<bar>terminal<cr>i
map <silent><leader>t :split<bar>wincmd j<bar>resize 10<bar>terminal<cr>i
map gb :GitBlame<cr>
nmap <leader>R <Plug>(coc-rename)
map <leader>i :ALEPrevious<cr>
map <leader>o :ALENext<cr>
map <leader>T :ALEGoToDefinition<cr>
map <leader>Y :ALEFindReferences<cr>
" tnoremap <silent><C-[> <C-\><C-n>
" Copy the last message to clipboard
nnoremap <silent><leader>E :redir @+<cr>:message<cr>:redir END<cr>

nmap <silent> gd <Plug>(coc-definition)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Change theme
map <leader><Up> :colorscheme $darkcolor \| set background=dark<cr>
map <leader><Down> :colorscheme $whitecolor \| set background=light<cr>

" Copy file path to the clipboard
map <leader>p :let @+ = expand("%")<cr>
" Copy full file path to the clipboard
map <leader>P :let @+ = join([expand('%'),  line(".")], ':')<cr>

" ESC in terminal mode
tnoremap <F2> <C-\><C-n>

" Delete current buffer, includes terminal buffer
map <F3> :bd!<cr>

" Close all buffer then open the last one
map <F4> :%bd!\|e#<cr>

" Close all buffers and quit Vim
map <F12> :qa!<cr>

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

" Need to zshell because I'm using it, make sure nothing broken
set shell=/bin/zsh

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
set undodir=~/.vim/undodir
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

call plug#begin('~/.vim/plugged')

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" let g:airline_powerline_fonts = 1
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" Remove the file type part
let g:airline_section_y = ''
let g:airline_skip_empty_sections = 1

" Airline theme
" let g:airline_theme='nord'

" " Hide the git hunk
" let g:airline_section_b = '%{airline#util#wrap(strpart(airline#extensions#branch#get_head(),0,11),0)}'

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
let g:NERDTreeWinSize=45
let g:NERDTreeStatusline="%{substitute(getcwd(), '^.*/', '', '')}"
" Hide the NERDTree CWD, https://github.com/scrooloose/nerdtree/issues/806
" augroup nerdtreehidecwd
"     autocmd!
"     autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeHideCWD #^[</].*$# conceal
" augroup end

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
let g:coc_node_path = $NODE_EXE
let g:coc_global_extensions=[ 'coc-omnisharp', 'coc-python', 'coc-tsserver', 'coc-rls', 'coc-flow']

Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
let g:prettier#exec_cmd_path = $HOME."/.nvm/versions/node/v10.15.1/bin/prettier"
let g:prettier#exec_cmd_async = 1
let g:prettier#quickfix_enabled = 0
let g:prettier#config#parser = 'babylon'

Plug 'dense-analysis/ale'
let g:ale_completion_enabled = 0
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fixers = {
  \ 'css': ['prettier'],
  \ 'typescript': ['prettier', 'eslint'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'html': ['prettier'],
  \ 'json': ['prettier'],
  \ 'liquid': ['prettier'],
  \ 'rust': ['rustfmt'],
  \ }
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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Git plugin for gdiff command
Plug 'tpope/vim-fugitive'

" Git blame status
Plug 'zivyangll/git-blame.vim'

" Snipet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

Plug 'tpope/vim-surround'

" Typescript
Plug 'leafgarland/typescript-vim'

" gdscript
" Plug 'clktmr/vim-gdscript3'

" Rust
" Plug 'rust-lang/rust.vim'

call plug#end()
