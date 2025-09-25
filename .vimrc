"------------------------------------------------------------
" PLUGINS (Using vim-plug, https://github.com/junegunn/vim-plug)
" Keep this at the top of the vimrc to ensure loading before setting options
"------------------------------------------------------------

" Automatic installation of vim-plug
" https://github.com/junegunn/vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')


" Configure packages before they are loaded
" This is required for some packages
"
" Don't auto indent based on the filetype by default
let g:polyglot_disabled = ["autoindent"]

" Install plugins using vim-plug below

Plug 'tpope/vim-commentary'
Plug 'sainnhe/everforest'
Plug 'sheerun/vim-polyglot'

call plug#end()

"------------------------------------------------------------
" END PLUGINS
"------------------------------------------------------------

" Don't try to be vi compatible
set nocompatible

" Turn on syntax highlighting
syntax on

" Show line numbers
set number

" Encoding
set encoding=utf-8

" Use spaces instead of tabs
set expandtab

" 1 tab == 2 spaces
set shiftwidth=2
set softtabstop=2
set tabstop=2

"Auto indent
set autoindent

"Smart indent
set smartindent

" Show a visual marker that a line is too long
set colorcolumn=80

" Allow filetype detection
filetype on
filetype plugin on

" Allow different space mappings for different file types
filetype plugin indent on

" Enable use of mouse in normal, visual, insert, command-line modes and when editing help files
set mouse=a

" Synchronize clipboard with vim register
" This allows you to yank in vim and paste with the system keyboard
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Show where you are in the document
set ruler

" Allow switching between buffers without them being saved to disk
set hidden

" Don't let vim popup extra menus, it is always confusing
set completeopt=menu

" Set git commit message rules
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=50,72
autocmd FileType gitcommit set spell

" Show filename
set laststatus=2

" Split new windows to the right, or below by default
set splitright
set splitbelow

" Turn on search highlighting
set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Automatically Remove trailing whitespace
autocmd FileType c,cpp,python,qml,js,json,vim,sh,Jenkinsfile,lua,txt,prolog,markdown,cmake,dockerfile autocmd BufWritePre <buffer> %s/\s\+$//e

" Set leader key to ,
let mapleader=","

function! UndoIfShellError()
    if v:shell_error
        undo
    endif
endfunction


" Setup Colorscheme
if has('termguicolors') " Important!!
  set termguicolors
endif
set background=dark
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'
" For better performance
let g:everforest_better_performance = 1
" Enable the foreground for spelling to be highlighted
let g:everforest_spell_foreground='colored'
colorscheme everforest

" Move to the next buffer
nmap <leader>t :bnext<CR>

" Move to the previous buffer
nmap <leader>T :bprevious<CR>

autocmd FileType c,cpp,java,Jenkinsfile set commentstring=//\ %s
