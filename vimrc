"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: .vimrc                                                                                                        "
" Maintainer: Yash Srivastav <yashsriv01@gmail.com>                                                                         "
"        URL: http://github.com/yashsriv/dotfiles                                                                         "
"                                                                                                                           "
"                                                                                                                           "
" Sections:                                                                                                                 "
"   01. General ................ General Vim behaviour                                                                      "
"   02. Vundle ................. Plugin Related Portion                                                                     "
"   03. Events ................. Autocmd for specific filetypes                                                             "
"   04. Theme/Colors ........... Colors,fonts,etc.                                                                          "
"   05. Vim UI ................. User Interface Behaviour                                                                   "
"   06. Text Formatting/Layout . Text, Tab, Indentation Related                                                             "
"   07. Custom Key Mappings .... Custom aliases                                                                             "
"   08. Statusline Moddings .... Custom Statusline                                                                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 01. General                                                                                                               "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible                " be iMproved, required
set backspace=indent,eol,start  " Backspace behaviour is normal
set history=1000                " Lots of history


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Vundle                                                                                                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off                             " required
set rtp+=~/.vim/bundle/Vundle.vim        " set the runtime path to include Vundle and initialize
call vundle#begin()
Plugin 'gmarik/Vundle.vim'               " Add all the plugins here
Plugin 'scrooloose/nerdcommenter'        " Good Commenting
" Plugin 'ervandew/supertab'             " Autocomplete on Tab
Plugin 'Lokaltog/vim-easymotion'         " Easy Motion search
Plugin 'Yggdroot/indentLine'             " Show indents
Plugin 'suan/vim-instant-markdown'       " Display Markdown
Plugin 'funorpain/vim-cpplint'           " Cpplint checker
Plugin 'flazz/vim-colorschemes'          " Vim Colorschemes
Plugin 'godlygeek/tabular'               " Table Settings
Plugin 'scrooloose/syntastic'            " Syntax Checker
Plugin 'Chiel92/vim-autoformat'          " AutoFormat
Plugin 'Valloric/YouCompleteMe'          " Autocomplete while typing
Plugin 'bronson/vim-trailing-whitespace' " Show Trailing Spaces
call vundle#end()                        " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 03. Events                                                                                                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on                                                 " Filetype detection[on] plugin[on] indent[on]

augroup filetype_specific
  autocmd!
  autocmd filetype svn,*commit* setlocal spell                            " Spell Check
  autocmd FileType make setlocal noexpandtab                              " In Makefiles DO NOT use spaces instead of tabs
  autocmd FileType c setlocal equalprg=/usr/bin/astyle\ -A14s2pHUxG       " Format code as per google guidelines for c
  autocmd FileType cpp setlocal equalprg=/usr/bin/astyle\ -A14s2pHUxG     " Format code as per google guidelines for cpp
  autocmd FileType arduino setlocal equalprg=/usr/bin/astyle\ -A14s2pHUxG " Format code as per google guidelines for arduino
  autocmd FileType java setlocal equalprg=/usr/bin/astyle\ -A14s2pHUxG    " Format code as per google guidelines for java
augroup END

augroup startup
  autocmd!
  autocmd BufRead,BufNewFile * echo "\n\tWhere there is a Vim , There is a way.\n\n\n\n\n\n\n\n\n\n\n"
  "jump to last cursor position when opening a file
  ""dont do it when writing a commit log entry
  autocmd BufReadPost * call SetCursorPosition()
augroup END

function! SetCursorPosition()
  if &filetype !~ 'svn\|commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  else
    call cursor(1,1)
  endif
endfunction

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
set rnu                        " Relative line numbers
set cul                        " Highlight Current Line
set showcmd                    " Show command in bottom bar
set showmode                   " Show current mode
filetype indent on             " Load filetype specific indent files
set wildmode=longest:list,full " Autocomplete on command line
set wildmenu                   " Enable ctrl-n and ctrl-p to scroll through matches
set wildignore=*.o,*.obj,*~    " Stuff to ignore
set lazyredraw                 " Redraw only when we need to
set showmatch                  " Showmatch highlight matching parenthesis
set scrolloff=5                " Minimum of two lines below and above cursor
set sidescrolloff=7            " Minimum of 7 characters right of cursor
set sidescroll=1
set ruler                      " Always show info along bottom
set incsearch                  " Incremental searching
set hlsearch                   " Highlight matches
set ignorecase                 " Case insensitive matching
set smartcase                  " Smart case matching
set list                       " Display all chars
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

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

" Folding
set foldmethod=indent  " Fold based on Indent
set foldnestmax=3      " Deepest fold is 3 levels
set nofoldenable       " Don't fold by default

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 07. Custom Key Mappings                                                                                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","
" Easy mistake ; instead of :
nnoremap ; :
vnoremap ; :
" Easily Comment out using NERDCommenter
nmap // <leader>ci
" Commands to properly indent the code
nnoremap ../ mzgg=G`z
inoremap ../ <esc>mzgg=G`za
" ,. is escape in insert mode.
inoremap <leader>. <esc>
" Move lines up(-) or down(_)
noremap - ddp
noremap _ ddkP
" Map space to insert spaces
nnoremap <space> li <esc>h
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" Edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Indent Lines
nnoremap <tab> i<tab><esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 08. Statusline Modding                                                                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Display Filename
set statusline=%<%#identifier#
set statusline+=[%f]
set statusline+=%*

" Display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

" Display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%y  " FileType
set statusline+=%h  " Help Tag

" Read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

" Modified flag
set statusline+=%#warningmsg#
set statusline+=%m
set statusline+=%*

" Syntastic Error messages
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=%=
set statusline+=%-14.(%c%V\ ,\ %l/%L%)\ %P

set laststatus=2               " Last window always has a statusline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
