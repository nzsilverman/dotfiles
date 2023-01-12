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

" Install plugins using vim-plug below

Plug 'pangloss/vim-javascript'
Plug 'peterhoeg/vim-qml'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'sainnhe/everforest'
Plug 'sheerun/vim-polyglot'
Plug 'ycm-core/YouCompleteMe'

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
set tabstop=2

"Auto indent
set autoindent

"Smart indent
set smartindent

" Allow filetype detection
filetype on
filetype plugin on

" Allow different space mappings for different file types
filetype plugin indent on

" Enable use of mouse in normal, visual, insert, command-line modes and when editing help files
set mouse=a

" Synchronize clipboard with vim register
" This allows you to yank in vim and paste with the system keyboard
set clipboard^=unnamed

" Show where you are in the document
set ruler

" Don't let vim popup extra menus, it is always confusing
set completeopt=menu

" Set git commit message rules
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=73

" Show filename
set laststatus=2

" Turn on search highlighting
set hlsearch
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Automatically Remove trailing whitespace
autocmd FileType c,cpp,python,qml,js,json,vim,sh autocmd BufWritePre <buffer> %s/\s\+$//e

" Set leader key to ,
let mapleader=","

function! UndoIfShellError()
    if v:shell_error
        undo
    endif
endfunction

" Autoformat cpp files on save
function FormatCppOnSave()
  "if !empty(findfile('.clang-format', expand('%:p:h') . ';')) " Uncomment if vim should only autoformat if a clang format file exists in this directory, or a parent directory
  let cursor_pos = getpos('.')
  :%! clang-format
  call UndoIfShellError()
  call setpos('.', cursor_pos)
  "endif " Uncomment if needed
endfunction
autocmd FileType c,cpp,h autocmd BufWritePre <buffer> silent :call FormatCppOnSave() | redraw!

" Autoformat python files on save using yapf
function FormatPythonOnSave()
  let cursor_pos = getpos('.')
  :%! yapf
  call UndoIfShellError()
  call setpos('.', cursor_pos)
endfunction
autocmd FileType python autocmd BufWritePre <buffer> silent :call FormatPythonOnSave() | redraw!

" Don't search for filenames in addition to content within files when using
" :Rg search with fzf plugin
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Show vim where fzf is installed
set rtp+=/opt/homebrew/bin/fzf

" Open fzf plugin shortcuts
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>w :Windows<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>
nnoremap <silent> <Leader>/ :BLines<CR>

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

" Setup and configure You Complete Me
"
" Use homebrew's clangd. For this to work, you complete me must be installed
" with --system-libclang
let g:ycm_clangd_binary_path = trim(system('brew --prefix llvm')).'/bin/clangd'
" Don't display ycm errors. They are annoying if completion is not setup
" properly for a specific repository
let g:ycm_show_diagnostics_ui = 0
" Whitelist extra conf files
let g:ycm_extra_conf_globlist = ['/Users/nathansilverman/pyka/software/repos/flight-controller/*']
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
" Don't hover automatically, only when leader-d is pressed
let g:ycm_auto_hover = ''
nmap <leader>d <plug>(YCMHover)
augroup HighlightCppInHover
  autocmd!
  autocmd FileType c,cpp let b:ycm_hover = {
    \ 'command': 'GetDoc',
    \ 'syntax': &filetype
    \ }
augroup END
