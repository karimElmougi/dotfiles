" Plugin Directory
call plug#begin('~/.local/share/nvim/plugged')

" Always loaded plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-html', 'coc-json', 'coc-pairs', 'coc-snippets', 'coc-highlight']
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'
Plug 'scrooloose/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'matze/vim-move'
Plug 'machakann/vim-highlightedyank'

Plug 'andymass/vim-matchup'

" Theme
Plug 'chriskempson/base16-vim'

" language specific Plugins
"
" Go
Plug 'fatih/vim-go', { 'for': 'go' }

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Elxir
Plug 'elixir-editors/vim-elixir', {'for': 'elixir'}

" Typescript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescriptreact'] }
Plug 'peitalin/vim-jsx-typescript', { 'for': ['javascriptreact', 'typescriptreact'] }

" sql
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }

"sh
Plug 'sbdchd/neoformat', {'for': ['sql', 'sh'] }
call plug#end()

" pluging specific 
" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

" rainbow
let g:rainbow_active = 1

" fzf
nnoremap <C-p> :FZF<CR>
let g:fzf_action = { 'ctrl-t': 'tab split', 'ctrl-s': 'split', 'ctrl-v': 'vsplit' }

" NERDComment
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

" general
set mouse=a
set splitbelow
set splitright
set updatetime=300
set clipboard+=unnamedplus
" does not launch vi
set nocompatible
" colors for theme
set termguicolors
" set theme
colorscheme base16-gruvbox-dark-hard
" syntax highlighting
syntax on
" Make backspace work
set backspace=2
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent
" set relative line numbers and absolute
set number
set relativenumber
set clipboard=unnamed

" keybinds
" use vim-move to move lines up or down using <S-J> and <S-K>
let g:move_key_modifier = 'S'

set hlsearch
noremap <ESC> :noh<CR><ESC>

" use alt+hjkl to move between split/vplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

let mapleader=","

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" file search
nnoremap <leader><leader> :Rg<Cr>

