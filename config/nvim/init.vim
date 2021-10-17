" Plugin Directory
call plug#begin('~/.local/share/nvim/plugged')

" Always loaded plugins
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'akinsho/toggleterm.nvim'

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

" Elxir
Plug 'elixir-editors/vim-elixir', {'for': 'elixir'}

" Typescript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescriptreact'] }
Plug 'peitalin/vim-jsx-typescript', { 'for': ['javascriptreact', 'typescriptreact'] }

" sql
Plug 'lifepillar/pgsql.vim', { 'for': 'sql' }

"sh
Plug 'sbdchd/neoformat', {'for': ['sql', 'sh'] }

"toml
Plug 'cespare/vim-toml', {'for': ['toml']}

"nix
Plug 'LnL7/vim-nix', {'for': ['nix']}

call plug#end()

" pluging specific 
" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let NERDTreeShowHidden=1

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
set clipboard=unnamedplus
" does not launch vi
set nocompatible
" colors for theme
set termguicolors
" set theme
colorscheme base16-gruvbox-dark-hard
" syntax highlighting
syntax enable
" indentation
filetype plugin indent on
" Make backspace work
set backspace=2
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set smartindent
set number

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
inoremap <expr> <c-space> "\<C-n>"

" file search
nnoremap <leader><leader> :Rg<Cr>

lua require('nvim-autopairs').setup()

" LSP
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" Errors in Red
hi LspDiagnosticsVirtualTextError guifg=Red ctermfg=Red
" Warnings in Yellow
hi LspDiagnosticsVirtualTextWarning guifg=Yellow ctermfg=Yellow
" Info and Hints in White
hi LspDiagnosticsVirtualTextInformation guifg=White ctermfg=White
hi LspDiagnosticsVirtualTextHint guifg=White ctermfg=White

" Underline the offending code
hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline

" LSP
lua <<EOF
local nvim_lsp = require('lspconfig')
local configs = require('lspconfig/configs')
local util = require('lspconfig/util')

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

-- Rust
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.rust_analyzer.setup({on_attach=on_attach, capabilities=capabilities})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
  }
)

vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler

-- Completion
require('compe').setup({
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
  };
})

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true
  },
  rainbow = {
    enable = true
  },
  ensure_installed = "maintained"
})

require('toggleterm').setup({
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal', --| 'vertical' | 'window' | 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
})
EOF

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
augroup lsp
    autocmd!
    " Show diagnostic popup on cursor hold
    autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})
    " Enable type inlay hints
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs
    \ lua require('lsp_extensions').inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }
augroup end

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

