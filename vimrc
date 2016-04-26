"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Filename: .vimrc                                                                                                        "
" Maintainer: Yash Srivastav <yashsriv01@gmail.com>                                                                         "
"        URL: http://github.com/yashsriv/dotfiles                                                                           "
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

set backspace=indent,eol,start      " Backspace behaviour is normal
set history=10000                    " Lots of history
if has('nvim')
  let s:editor_root=expand("~/.nvim")
else
  set nocompatible                    " be iMproved, required
  let s:editor_root=expand("~/.vim")
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 02. Vundle                                                                                                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype off                             " required

" Setting up Vundle - the vim plugin bundler
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/Vundle.vim/README.md'
" If readme file is absent, install vundle
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent call mkdir(s:editor_root . '/bundle', "p")
  silent execute "!git clone https://github.com/VundleVim/Vundle.vim.git " .
  s:editor_root . "/bundle/Vundle.vim"
  let vundle_installed=0
endif
" add vundle to rtp
let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim/'

call vundle#begin(s:editor_root . '/bundle/')
Plugin 'VundleVim/Vundle.vim'            " Add all the plugins here
Plugin 'scrooloose/nerdcommenter'        " Good Commenting
Plugin 'scrooloose/nerdtree'             " File Browsing
Plugin 'yashsriv/vim-airline-harlequin'  " My own colorscheme
Plugin 'vim-airline/vim-airline'         " Powerful statusline
Plugin 'Lokaltog/vim-easymotion'         " Easy Motion search
Plugin 'majutsushi/tagbar'               " Tagbar ( Display info on structure of code)
Plugin 'Yggdroot/indentLine'             " Show indents
Plugin 'suan/vim-instant-markdown'       " Display Markdown
Plugin 'funorpain/vim-cpplint'           " Cpplint checker
Plugin 'flazz/vim-colorschemes'          " Vim Colorschemes
Plugin 'godlygeek/tabular'               " Table Settings
Plugin 'scrooloose/syntastic'            " Syntax Checker
Plugin 'Chiel92/vim-autoformat'          " AutoFormat
"Plugin 'ervandew/supertab'               " Autocomplete on Tab
Plugin 'Valloric/YouCompleteMe'          " Autocomplete while typing
Plugin 'bronson/vim-trailing-whitespace' " Show Trailing Spaces
Plugin 'Shougo/unite.vim'                " Somethong very powerful(trying to learn)
Plugin 'ap/vim-css-color'                " Colored css
"Plugin 'LaTeX-Box-Team/LaTeX-Box'       " LaTeX plugin
call vundle#end()                        " required

if vundle_installed == 0
  echo "Installing Bundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

" YCM settings for less irritating behaviour
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_add_preview_to_completeopt = 1

" Airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts  = 1
let g:airline_theme="harlequin"
let g:ycm_semantic_triggers={'html': ['<', '</'], 'css': [ 're!^\s{4}', 're!:\s+' ]}

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
  autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4
  autocmd FileType tex nnoremap <CR> :w \| let x=system('pdflatex ' . expand('%:r') . '.tex ; evince ' . expand('%:r') . '.pdf &')<CR><CR>
  autocmd FileType html nnoremap <CR> :w \| let x=system('midori ' . expand('%:r') . '.html &')<CR><CR>
  autocmd FileType html setlocal equalprg=js-beautify\ -s\ 2\ --html      " Format html
  autocmd FileType javascript setlocal equalprg=js-beautify\ -s\ 2        " Format js
  autocmd FileType css setlocal equalprg=js-beautify\ -s\ 2\ --css        " Format css
augroup END

augroup startup
  autocmd!
  "jump to last cursor position when opening a file
  ""dont do it when writing a commit log entry
  autocmd BufReadPost * call SetCursorPosition()
  " Boilerplate C code
  autocmd BufNewFile *.c $r ~/dotfiles/boilerplate/foo.c
  autocmd BufNewFile *.c normal kdd2ji  
  " Boilerplate cxx , i.e., opencv IP code
  autocmd BufNewFile *.cxx $r ~/dotfiles/boilerplate/foo.cxx
  autocmd BufNewFile *.cxx normal kdd6j4l
  " Boilerplate ino code
  autocmd BufNewFile *.ino $r ~/dotfiles/boilerplate/foo.ino
  autocmd BufNewFile *.ino normal kdd2j
  " Open NERDTree on startup
  autocmd vimenter * NERDTree
  " Hide it from view
  autocmd vimenter * call DecideNERDTree()
  "autocmd vimenter * Tagbar
  "autocmd vimenter * call DecideTagbar()
augroup END


augroup close
  autocmd!
  " Close vim if nerd tree is the only remaining buffer
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " Close all open side splits before deleting a buffer else vim crashes
  autocmd BufWipeout * call CloseAllSplits()
augroup END

function! CloseAllSplits()
  TagbarClose
  NERDTreeClose
endfunction

function! DecideTagbar()
  if winwidth(0)<=80
    TagbarToggle
  endif
endfunction

function! DecideNERDTree()
  if winwidth(0)<=80
    NERDTreeToggle
  endif
endfunction

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

set ff=unix
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
"set showmode                   " Show current mode
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
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅,eol:¬
set splitright
"set splitbelow

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
nmap // <leader>c<space>
vmap // <leader>cs
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
" Remove Highlight
nnoremap <leader><leader>c :noh<cr>
" Directory Movement
"nnoremap <leader><leader>d :leftabove vsplit .<CR><C-w>l:vertical resize<CR><C-w>h
nnoremap <leader><leader>d :NERDTreeToggle<CR>
" Tagbar
nnoremap <leader><leader>t :TagbarToggle<CR>
" Window Movement in insert mode
inoremap <C-w> <C-o><C-w>
" Save file as superuser
command! WR :execute ':silent w !sudo tee % > /dev/null' | :edit!
" Next buffer
nnoremap bn :bnext<CR>
" Previous buffer
nnoremap bp :bprev<CR>
" Close buffer
nnoremap bd :call CloseAllSplits()<CR>:bd<CR>
" Till I get internet back
"inoremap <Tab> <C-n>
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
if has('nvim')
  nnoremap <leader>t :terminal<CR>
  tnoremap <Esc> <C-\><C-n>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 08. Statusline Modding                                                                                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Normal Status Line

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


" Airline

"let g:airline_section_a = airline#section#create(['mode', 'crypt', 'paste', 'spell', 'iminsert'])
"let g:airline_section_b = airline#section#create(['hunks', 'branch'])
let g:airline_section_c = airline#section#create(['%t'])
"let g:airline_section_gutter = airline#section#create(['readonly'])
"let options_section_x = ['tagbar', 'filetype']
"if exists('*env#statusline')
"call add(options_section_x, '%{GitBranchInfoString()}')
"endif
let options_section_y = []
let g:airline_section_y = airline#section#create(options_section_y)
"let g:airline_section_x = airline#section#create(options_section_x)
"let g:airline_section_y = airline#section#create(['%{&fenc}', '[%{&ff}]'])
"let g:airline_section_z = airline#section#create(['%P ', g:airline_symbols.linenr, ' %l : %c'])
"let g:airline_section_error = airline#section#create(['ycm_error_count', 'syntastic', 'eclim'])
"let g:airline_section_warning = airline#section#create(['ycm_warning_count', 'whitespace'])

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
