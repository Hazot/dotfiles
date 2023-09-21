
"source $HOME/.config/nvim/plug-config/coc.vim
set encoding=utf-8
set number relativenumber
set noswapfile
set scrolloff=5
set backspace=indent,eol,start
set clipboard=unnamedplus

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set mouse=a
set expandtab
set autoindent
set fileformat=unix
set completeopt-=preview " For no preview"

let mapleader = ' '


call plug#begin('~/.config/nvim/plugged')

Plug 'morhetz/gruvbox'  " colorscheme
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sirver/ultisnips'
Plug 'tc50cal/vim-terminal'
Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/tagbar'
Plug 'neoclide/coc.nvim'
Plug 'joshdick/onedark.vim'

call plug#end()


" Colorscheme
syntax enable
colorscheme gruvbox
set t_Co=256
" set background=dark
let g:airline_theme='gruvbox'
if (has("termguicolors"))
    set termguicolors
endif

" NERDTree
let NERDTreeQuitOnOpen=1
" let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
nmap <F2> :NERDTreeToggle<CR>

" NERD keybinds
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv
nmap <F2> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>

" Tabs
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemode=':t'
nmap <leader>1 :bp<CR>
nmap <leader>2 :bn<CR>
nmap <C-w> :bd<CR>

" Ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Tagbar
nmap <F8> :TagbarToggle<CR>

