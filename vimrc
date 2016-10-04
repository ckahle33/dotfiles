syntax on
set nocp
set mouse=a
set splitright
set number
set rtp+=/usr/local/opt/fzf
set tabstop=2
set autoindent noexpandtab tabstop=2 shiftwidth=2
set smartindent
set backspace=indent,eol,start
set expandtab
set cursorline
set hlsearch
set incsearch
set ignorecase
set smartcase
set cindent

hi Search guibg=LightBlue
filetype plugin indent on
filetype plugin on
autocmd BufWritePre * :%s/\s\+$//e

let mapleader = " "

nnoremap <leader>f :Ag<Enter>
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <silent> <M-h> <C-w>h
nnoremap <leader>v :vsp<Enter>
nnoremap <leader>h :sp<Enter>
nnoremap <leader>q :q<Enter>
nnoremap <leader>s :w<Enter>
nnoremap <leader>, <C-^>

nnoremap <leader>c "*
nnoremap <leader><Right> <c-w>l
nnoremap <leader><Left> <c-w>h
nnoremap <leader><Up> <c-w>k
nnoremap <leader><Down> <c-w>j
nnoremap <leader>[ <c-T>
nnoremap <leader>] <c-]>
nnoremap <leader>o <c-o>
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>
snoremap<c-w><Right> <c-w>l
nnoremap<c-w><Left> <c-w>h
nnoremap<c-w><Up> <c-w>k
nnoremap<c-w><Down> <c-w>j
" Magic sauce that makes nerdtree perform like a typical explorer
" Open files as normal in NerdTree with 'o' or Enter and a persistent
" NerdTree instance remains, press <leader>d to re-open
let NERDTreeQuitOnOpen = 0
nnoremap <Leader>d :let NERDTreeQuitOnOpen = 1<bar>:NERDTreeToggle<CR>
nnoremap <Leader>D :let NERDTreeQuitOnOpen = 0<bar>:NERDTreeToggle<CR>

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
Plug 'isruslan/vim-es6'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'slim-template/vim-slim.git'
Plug 'kchmck/vim-coffee-script'
Plug 'flazz/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'             " File finder
Plug 'Konfekt/FastFold'               " Update folds on save
Plug 'junegunn/fzf.vim'
Plug 'othree/html5.vim'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'itchyny/lightline.vim'          " Status bar
Plug 'simnalamburt/vim-mundo'         " Undo browser (replaces gundo)
Plug 'danro/rename.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'tomtom/tlib_vim'
Plug 'cespare/vim-toml'
Plug 'scrooloose/nerdTree'
Plug 'sickill/vim-monokai'
Plug 'ludovicchabant/vim-gutentags'
Plug 'nono/vim-handlebars',          { 'for': 'handlebars.html' }
Plug 'Shougo/vimproc',               { 'do': 'make' }
Plug 'dbakker/vim-projectroot'
Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'

Plug 'benekastah/neomake'
Plug 'janko-m/vim-test'

" Elixir
Plug 'elixir-lang/vim-elixir'

" Elm
Plug 'ElmCast/elm-vim'

" Crystal
Plug 'rhysd/vim-crystal'

" Go
Plug 'fatih/vim-go',                 { 'for': 'go' }
Plug 'rhysd/vim-go-impl',            { 'for': 'go' }

" Haskell
Plug 'neovimhaskell/haskell-vim',     {'for': 'haskell'}
Plug 'bitc/vim-hdevtools',            {'for': 'haskell'}
" Plug 'enomsg/vim-haskellConcealPlus', {'for': 'haskell'}
Plug 'eagletmt/ghcmod-vim',           {'for': 'haskell'}
Plug 'eagletmt/neco-ghc'
Plug 'Twinside/vim-hoogle',           {'for': 'haskell'}


  " Javascript
Plug 'kchmck/vim-coffee-script',     { 'for': 'coffee' }
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-jdaddy'

" Ruby
Plug 'Keithbsmiley/rspec.vim'
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'
Plug 'vim-ruby/vim-ruby'
" Plug 'skwp/vim-ruby-conque'
Plug 'sunaku/vim-ruby-minitest'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'slim-template/vim-slim'

" Rust
Plug 'rust-lang/rust.vim'

call plug#end()

colorscheme jellybeans
