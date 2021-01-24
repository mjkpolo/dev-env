call plug#begin('~/.vim/plugged')
" Essentials
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
" Theme
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
" Conjure for Clojure
Plug 'Olical/conjure', {'tag': 'v4.10.0'}
Plug 'clojure-vim/vim-jack-in'
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
" YCM and Nerdtree
Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
call plug#end()

" youcopmleteme & syntastic
set completeopt-=preview
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" fzf
map ; :Files<CR>

" Nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>

" Theme
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark='hard'
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ }

" Tagbar
map <C-b> :TagbarToggle<CR>

" borrowed geohot config
syntax on
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ai
set number
set hlsearch
set ruler

" Personal Config
tnoremap <Esc> <C-\><C-n>
set pastetoggle=<F3>
set mouse=a

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
