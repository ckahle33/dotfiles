syntax on
set t_Co=256
hi CursorLine ctermbg=8 ctermfg=15 "8 = dark gray, 15 = white
hi Cursor ctermbg=15 ctermfg=8

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
set incsearch
set ignorecase
set smartcase
set cindent
set clipboard=unnamed
set statusline+=%F

hi Search guibg=LightBlue
filetype plugin indent on
filetype plugin on
autocmd BufWritePre * :%s/\s\+$//e

let mapleader = " "

" hardmode engage
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nmap U <c-r>
nmap Y y$

" tabs
noremap <S-l> gt
noremap <S-h> gT
noremap <S-t> :tabnew<cr>
noremap <S-q> :tabc<cr>

nnoremap <leader>f :Ag<cr>
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <leader>v :vsp<cr>
nnoremap <leader>h :sp<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>, <C-^>

nnoremap <leader>[ <c-T>
nnoremap <leader>] <c-]>
nnoremap <leader>o <c-o>
nnoremap <CR> o<Esc>

" Turn off gitgutter key mappings
let g:gitgutter_map_keys = 0

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
Plug 'tpope/vim-commentary'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'slim-template/vim-slim.git'
Plug 'kchmck/vim-coffee-script'
Plug 'flazz/vim-colorschemes'

" -- Git -
Plug 'tpope/vim-fugitive'
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
Plug 'airblade/vim-gitgutter'

Plug 'benekastah/neomake'
Plug 'janko-m/vim-test'

" Elixir
Plug 'elixir-lang/vim-elixir'

" Go
Plug 'fatih/vim-go',                 { 'for': 'go' }
Plug 'rhysd/vim-go-impl',            { 'for': 'go' }

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
