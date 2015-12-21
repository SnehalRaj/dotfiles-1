set nocompatible                                       " be iMproved, required
filetype off                                           " required
set rtp+=~/.vim/bundle/Vundle.vim                      " set the runtime path to include Vundle and initialize
call vundle#begin()

                                                       " Alternatively, pass a path where Vundle should install plugins
                                                       " Call vundle#begin('~/some/path/here')
                                                       " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'                             " Add all the plugins here
Plugin 'scrooloose/nerdcommenter'                      " Good Commenting
Plugin 'ervandew/supertab'                             " Autocomplete on Tab
Plugin 'Lokaltog/vim-easymotion'                       " Easy Motion search
Plugin 'Yggdroot/indentLine'                           " Show indents
Plugin 'funorpain/vim-cpplint'                         " Cpplint checker
Plugin 'flazz/vim-colorschemes'                        " Vim Colorschemes
Plugin 'godlygeek/tabular'                             " Table Settings
Plugin 'scrooloose/syntastic'                          " Syntax Checker
Plugin 'Chiel92/vim-autoformat'                        " AutoFormat
Plugin 'bronson/vim-trailing-whitespace'               " Show Trailing Spaces

call vundle#end()                                      " required
filetype plugin indent on                              " required

nmap ; :
nmap // <leader>ci
vmap ; :

                                                       " Commands to properly indent the code
nmap ../ mzgg=G`z
imap ../ <esc>mzgg=G`za
                                                       " Syntax and Coloring

" UI Config
set t_Co=256                                           " Enable 256-color mode
set background=dark                                    " I usually work with a dark background
syntax enable                                          " enable syntax processing
colorscheme harlequin                                  " Colorscheme Harlequin is good
set number                                             " show line number
set laststatus=2                                       " Last window always has a statusline
set rnu                                                " relative line numbers
set showcmd                                            " show command in bottom bar
filetype indent on                                     " load filetype specific indent files
set wildmenu                                           " visual autocomplete for command menu
set wildmode=longest:list,full
set lazyredraw                                         " redraw only when we need to
set showmatch                                          " showmatch highlight matching parenthesis
set equalprg=/usr/bin/astyle\ --style=google           " Format code as per google guidelines
set scrolloff=5                                        " Minimum of two lines below and above cursor
set ruler                                              " Always show info along bottom
set incsearch                                          " incremental searching
set ignorecase                                         " case insensitive matching
set smartcase                                          " smart case matching
inoremap ,. <esc>
                                                       " ,. is escape
set expandtab
set smarttab
set autoindent
set shiftwidth=2
set softtabstop=0
set tabstop=2
set nowrap

                                                       " easy motion shortcut
nmap ,, <leader><leader>s
inoremap ,, <esc><leader><leader>s
