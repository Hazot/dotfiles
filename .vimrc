syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set ai
set noswapfile
set number
set relativenumber
set smartindent
set hlsearch
set ruler
set paste
set mouse=a
set clipboard=unnamedplus

" Plug

" keybindings
nnoremap <SPACE> <Nop>
let mapleader = " "
nnoremap <esc> :noh<return><esc>
" nnoremap <C-c> :noh<return><C-c>

"--" Moves highlighted text together in visual mode with J and K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"--" Does not move mouse when appending lines with J
nnoremap J mzJ`z

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

"--" Can delete highlight without copying it and then paste the current buffer
xnoremap <leader>p \"_dP


"--" Yank multiple lines to clipboard easily
nnoremap <leader>y +y
vnoremap <leader>y +y
nnoremap <leader>Y   +Y

"--" Only difference between escape and ctrl+c
inoremap <C-c> <Esc>

"--" Do not use Q
nnoremap Q <nop>

"--" Can easily replace all the words in a file
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

"--" Have j and k working with word wrap
nnoremap k gk
nnoremap j gj
