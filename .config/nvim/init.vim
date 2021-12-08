" nvim config

" options
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops
set expandtab               
set shiftwidth=2
set autoindent                      " indent a new line
set number                          " add line numbers
set relativenumber
set wildmode=longest,list           " get bash-like ta completions
set cc=80                           " set an 80 column
syntax on                           " syntax highlighting
set mouse=a                          " enable mouse click
set clipboard=unnamedplus           " using system clipboard
set backupdir=~./config/cache/nvim   " Directory to store backup files.



" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif


" plugins
call plug#begin('~/.config/nvim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/syntastic'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'chrisbra/csv.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'rafaqz/citation.vim'
  Plug 'dylanaraps/wal.vim'
call plug#end()
 
colorscheme wal

