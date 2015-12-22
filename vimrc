"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: .vimrc                                                                                                  "
" Maintainer: Yash Srivastav <yash111998@gmail.com>                                                                   "
"        URL: http://github.com/yash111998/dotfiles                                                                   "
"                                                                                                                     "
"                                                                                                                     "
" Sections:                                                                                                           "
"   01. General ................ General Vim behaviour                                                                "
"   02. Vundle ................. Plugin Related Portion                                                               "
"   03. Events ................. Autocmd for specific filetypes                                                       "
"   04. Theme/Colors ........... Colors,fonts,etc.                                                                    "
"   05. Vim UI ................. User Interface Behaviour                                                             "
"   06. Text Formatting/Layout . Text, Tab, Indentation Related                                                       "
"   07. Custom Key Mappings .... Custom aliases                                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                                                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                                                " be iMproved, required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Vundle                                                                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                             " required
set rtp+=~/.vim/bundle/Vundle.vim        " set the runtime path to include Vundle and initialize
call vundle#begin()
" Alternatively, pass a path where Vundle should install plugins
" Call vundle#begin('~/some/path/here')
Plugin 'gmarik/Vundle.vim'               " Add all the plugins here
Plugin 'scrooloose/nerdcommenter'        " Good Commenting
Plugin 'ervandew/supertab'               " Autocomplete on Tab
Plugin 'Lokaltog/vim-easymotion'         " Easy Motion search
Plugin 'Yggdroot/indentLine'             " Show indents
Plugin 'funorpain/vim-cpplint'           " Cpplint checker
Plugin 'flazz/vim-colorschemes'          " Vim Colorschemes
Plugin 'godlygeek/tabular'               " Table Settings
Plugin 'scrooloose/syntastic'            " Syntax Checker
Plugin 'Chiel92/vim-autoformat'          " AutoFormat
Plugin 'bronson/vim-trailing-whitespace' " Show Trailing Spaces
call vundle#end()                        " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Events                                                                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on                                          " Filetype detection[on] plugin[on] indent[on]
autocmd FileType make setlocal noexpandtab                         " In Makefiles DO NOT use spaces instead of tabs
autocmd FileType c setlocal equalprg=/usr/bin/astyle\ -A14s2pPxd   " Format code as per google guidelines for c
autocmd FileType cpp setlocal equalprg=/usr/bin/astyle\ -A14s2pPxd " Format code as per google guidelines for cpp

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 04. Theme/Colors                                                                                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256          " Enable 256-color mode
set background=dark   " I usually work with a dark background
syntax enable         " Enable syntax processing
colorscheme harlequin " Colorscheme Harlequin is good

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 05. Vim UI                                                                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                     " Show line number
set laststatus=2               " Last window always has a statusline
set rnu                        " Relative line numbers
set cul                        " Highlight Current Line
set showcmd                    " Show command in bottom bar
filetype indent on             " Load filetype specific indent files
set wildmenu                   " Visual autocomplete for command menu
set wildmode=longest:list,full " Autocomplete on command line
set lazyredraw                 " Redraw only when we need to
set showmatch                  " Showmatch highlight matching parenthesis
set scrolloff=5                " Minimum of two lines below and above cursor
set ruler                      " Always show info along bottom
set incsearch                  " Incremental searching
set ignorecase                 " Case insensitive matching
set smartcase                  " Smart case matching

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 06. Text Formatting/Layout                                                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab     " Expand all tabs to spaces
set smarttab      " Insert tabs smartly
set autoindent    " Indent properly
set smartindent   " Automatically insert indents smartly
set shiftwidth=2  " Shift movements move by 2
set softtabstop=0 " No idea :P
set tabstop=2     " No idea :P
set nowrap        " Don't wrap text

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 07. Custom Key Mappings                                                                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy mistake ; instead of :
nmap ; :
vmap ; :
" Easily Comment out using NERDCommenter
nmap // <leader>ci
" Commands to properly indent the code
nmap ../ mzgg=G`z
imap ../ <esc>mzgg=G`za
" ,. is escape in insert mode.
inoremap ,. <esc>
" Easy motion plugin shortcut (find a particular letter)
nmap ,, <leader><leader>s
inoremap ,, <esc><leader><leader>s
