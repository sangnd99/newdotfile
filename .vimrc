" [[ Global configs ]]
syntax on
filetype on

let mapleader = " "
let maplocalleader = " "
let g:netrw_banner = 0

set termguicolors
set number
set relativenumber
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent
set noswapfile
set nobackup
set ruler
set pumheight=10
set signcolumn=yes
set noshowmode
set updatetime=300
set timeoutlen=500
set scrolloff=10
set splitbelow
set splitright
set ignorecase
set smartcase
set cursorline
set clipboard="unnamedplus"
set breakindent
set laststatus=2
set colorcolumn="80"
set confirm
set nolist
set hlsearch

" [[ Status line ]]
let mode_map = {
	\ 'n': 'NORMAL',
	\ 'i': 'INSERT',
	\ 'v': 'VISUAL',
	\ 'V': 'V-LINE',
	\ "\<C-v>": 'V-BLOCK',
	\ 'c': 'COMMAND',
	\ 's': 'SELECT',
	\ 'S': 'S-LINE',
	\ "\<C-s>": 'S-BLOCK',
	\ 'R': 'REPLACE',
	\ 't': 'TERMINAL',
	\}

set statusline=
set statusline+=\%#PMenuSel#\ %{get(mode_map,mode(),mode())}\ %#StatusLine#
set statusline+=\ 
set statusline+=%t
set statusline+=%m
set statusline+=%=
set statusline+=[%v/%l]
set statusline+=\ 
set statusline+=%{&fileencoding?&fileencoding:&encoding}
set statusline+=\ 
set statusline+=\[%{&filetype}\]

" [[ Keymappings ]]
nnoremap <silent> <leader>e :Ex<cr>
nnoremap <silent> <C-u> <C-u>zz
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv
nnoremap <silent> <leader>h :noh<cr>
nnoremap <silent> <C-d> <C-d>zz
nnoremap <silent> <C-j> <C-w>j 
nnoremap <silent> <C-k> <C-w>k 
nnoremap <silent> <C-h> <C-w>h 
nnoremap <silent> <C-l> <C-w>l 
vnoremap <silent> < <gv
vnoremap <silent> > >gv
vnoremap <silent> K :m '<-2<cr>gv=gv
vnoremap <silent> J :m '>+1<cr>gv=gv
inoremap jk <esc>
tnoremap <esc><esc> <C-\><C-N>

" [[ Plugins ]]
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" Detect tabstop and shiftwidth automatically
Plug 'tpope/vim-sleuth'

" Colorscheme
Plug 'ghifarit53/tokyonight-vim'

" Fuzzy Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Enable LSP
Plug 'prabirshrestha/vim-lsp'

" Install language servers and configure them for vim-lsp
Plug 'mattn/vim-lsp-settings'

" Autocomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Comment
Plug 'tpope/vim-commentary'

call plug#end()

" [[ Configure plugins ]]
" Colorscheme
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 0
colorscheme tokyonight

" fzf-vim
nnoremap <leader>pf :Files<cr>
nnoremap <leader>pb :Buffers<cr>
nnoremap <leader>ps :Rg 

" Autocomplete
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" LSP
let g:lsp_use_native_client = 1
let g:lsp_semantic_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_float_cursor = 1

function! s:on_lsp_buffer_enabled() abort
	setlocal omnifunc=lsp#complete
	if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
	nmap <buffer> [d				 <plug>(lsp-previous-diagnostic)
	nmap <buffer> ]d				 <plug>(lsp-next-diagnostic)
	nmap <buffer> <leader>rn <plug>(lsp-rename)
	nmap <buffer> <leader>ca <plug>(lsp-code-action-float)
	nmap <buffer> gd 				 <plug>(lsp-definition)
	nmap <buffer> gD 				 <plug>(lsp-declaration)
	nmap <buffer> gr 				 <plug>(lsp-references)
	nmap <buffer> gI				 <plug>(lsp-implementation)
	nmap <buffer> K					 <plug>(lsp-hover)
	nmap <buffer> J					 :LspDocumentDiagnostics<cr>
	nmap <buffer> <C-k>			 <plug>(lsp-signature-help)
  nmap <buffer> <leader>f  :Format<cr>  
  nnoremap <buffer> <expr> <C-b> lsp#scroll(-4)
  nnoremap <buffer> <expr> <C-f> lsp#scroll(+4)

	let g:lsp_format_sync_timeout = 1000
	command! Format LspDocumentFormatSync
endfunction

augroup lsp_install
	au!
	autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:asynccomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
