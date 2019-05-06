" jellybeans
syntax enable
colorscheme jellybeans

set nocp
set mouse=a
set splitright
set number
set rtp+=/usr/local/opt/fzf
set backspace=indent,eol,start
set expandtab
set cursorline
set incsearch
set ignorecase
set smartcase
set cindent
set clipboard=unnamed
set statusline+=%F
set re=1

set noswapfile

set shiftwidth=2
set tabstop=2

cnoremap %% <C-R>=expand('%:h').'/'<cr>

hi Search guibg=LightBlue
filetype plugin on
syntax on
autocmd BufWritePre * :%s/\s\+$//e

let mapleader = " "

" indenting
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent  (local to buffer)
set pastetoggle=<f3>

nmap U <c-r>
nmap Y y$

" treat wraps as lines
nmap k gk
nmap j gj

" tabs
noremap <S-l> gt
noremap <S-h> gT
noremap <S-t> :tabnew<cr>
noremap <S-q> :tabc<cr>

" search
nnoremap <leader>f :Ag<cr>
nnoremap <leader>p :Files<cr>
nnoremap <leader>t :Tags<cr>

" splits
nnoremap <leader>v :vsp<cr>
nnoremap <leader>s :sp<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>, <C-^>
nnoremap <leader>ra :%s/

nnoremap - <c-w>20<
nnoremap = <c-w>20>

nnoremap <leader>[ <c-T>
nnoremap <leader>] <c-]>
nnoremap <leader>o <c-o>
nnoremap <CR> o<Esc>

" Turn off gitgutter key mappings
let g:git8gutter_map_keys = 0

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" Magic sauce that makes nerdtree perform like a typical explorer
" Open fil[Ma9es as normal in NerdTree with 'o' or Enter and a persistent
" NerdTree instance remains, press <leader>d to re-open
let NERDTreeQuitOnOpen = 0
nnoremap <Lead[Ma9es9er>d :let NERDTreeQuitOnOpen = 1<bar>:NERDTreeToggle<CR>
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 0<bar>:NERDTreeToggle<CR>

let g:ctrlp_show_hidden = 1
let NERDTreeShowHidden=1
let g:ag_working_path_mode="r"

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Stuff required by rubyblock
runtime macros/matchit.vim

"Plugins
call plug#begin('~/.vim/plugged')

" Colors
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'

" -- Git -
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'

" Util
Plug 'junegunn/vim-easy-align'
Plug 'Konfekt/FastFold'               " Update folds on save
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'          " Status bar
Plug 'sjl/gundo.vim'
Plug 'danro/rename.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdTree'
Plug 'sickill/vim-monokai'
Plug 'nono/vim-handlebars',          { 'for': 'handlebars.html' }
Plug 'Shougo/vimproc',               { 'do': 'make' }
Plug 'tpope/vim-haml'
Plug 'posva/vim-vue'
Plug 'dbakker/vim-projectroot'
Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'benekastah/neomake'
Plug 'janko-m/vim-test'
Plug 'valloric/youcompleteme'
Plug 'tpope/vim-repeat'

" Elixir
Plug 'elixir-lang/vim-elixir'

" Go
Plug 'fatih/vim-go',                 { 'for': 'go' }
Plug 'rhysd/vim-go-impl',            { 'for': 'go' }

" Javascript
Plug 'kchmck/vim-coffee-script',     { 'for': 'coffee' }
Plug 'isruslan/vim-es6'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-jdaddy'

" Ruby
Plug 'Keithbsmiley/rspec.vim'
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'vim-ruby/vim-ruby'
Plug 'sunaku/vim-ruby-minitest'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'slim-template/vim-slim'

" Misc
Plug 'kana/vim-textobj-user'
Plug 'tpope/vim-commentary'
Plug 'nelstrom/vim-textobj-rubyblock'


call plug#end()
