-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- Disable deprecated commands from neo-tree
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager

  use { 'echasnovski/mini.nvim', branch = 'stable' } -- Bunch of mini plugins

  use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup() end } -- Automatically close brackets
  use { 'lukas-reineke/indent-blankline.nvim', tag = 'v2.20.6' } -- Add indentation guides even on blank lines

  -- Remove with nvim 0.10
  use {'ojroques/nvim-osc52'} -- Clipboard that works across SSH, same method as Zellij

  -- UI
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } } -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x', requires = { 'kyazdani42/nvim-web-devicons', 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'} } 
  use 'numToStr/Navigator.nvim' -- Splits navigation
  use 'akinsho/toggleterm.nvim' -- Toggleable terminal
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Add git related info in the signs columns and popups
  use {"shortcuts/no-neck-pain.nvim", tag = "*" }
  use { "sitiom/nvim-numbertoggle" }

  -- LSP & Completion
  use 'nvim-treesitter/nvim-treesitter' -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter-textobjects' -- Additional textobjects for treesitter
  use { 'neovim/nvim-lspconfig', tag = 'v0.1.7' } -- Collection of configurations for built-in LSP client
  use 'towolf/vim-helm'

  -- Style
  use { 'norcalli/nvim-colorizer.lua', config = function() require('colorizer').setup() end } -- Show color blocks around color codes
  -- use 'RRethy/nvim-base16' -- Colorscheme pack
  -- use 'rebelot/kanagawa.nvim' -- Colorscheme
  -- use 'luisiacc/gruvbox-baby'
  use 'ellisonleao/gruvbox.nvim'
  use { 'folke/todo-comments.nvim', config = function() require('todo-comments').setup() end}
  use 'HiPhish/rainbow-delimiters.nvim'

  if is_bootstrap then
      require('packer').sync()
  end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- Split direction
vim.o.splitbelow = true
vim.o.splitright = true

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

--Enable mouse mode
vim.o.mouse = 'a'

-- We may need this for toggleterm
-- vim.o.hidden = true

--Share clipboard with system
vim.o.clipboard='unnamedplus'

local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

vim.g.clipboard = {
  name = 'osc52',
  copy = {['+'] = copy, ['*'] = copy},
  paste = {['+'] = paste, ['*'] = paste},
}

-- Now the '+' register will copy to system clipboard using OSC52
-- vim.keymap.set('n', '<leader>c', '"+y')
-- vim.keymap.set('n', '<leader>cc', '"+yy')

--Enable break indent
vim.o.breakindent = true

-- Tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
-- vim.cmd('colorscheme kanagawa')
-- vim.cmd('colorscheme base16-gruvbox-light-medium')
-- vim.cmd('colorscheme gruvbox-baby')
vim.o.background = "light" -- or "light" for light mode
vim.cmd('colorscheme gruvbox')

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clean search highlight with ESC
vim.api.nvim_set_keymap('', '<ESC>', "<cmd>noh<CR><ESC>", { noremap = true, silent = true })

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.o.updatetime = 300
vim.api.nvim_exec(
  [[
  augroup lsp
    autocmd!
    autocmd CursorHold * lua vim.diagnostic.open_float({focusable = false})
  augroup end
  ]],
  false
)

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- require("no-neck-pain").setup({
--   autocmds = { enableOnVimEnter = true }
-- })

-- Mini
require('mini.completion').setup()
vim.keymap.set('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { expr = true })
vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
require('mini.comment').setup()
require('mini.indentscope').setup() -- view indent levels with an animate line
require('mini.notify').setup()
require('mini.statusline').setup()

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- -- Telescope
require('telescope').setup {
  defaults = {
    generic_sorter = require('mini.fuzzy').get_telescope_sorter,
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    }
  },
}

-- Telescope shortcuts
local telescope = require('telescope.builtin')
vim.keymap.set('', '<C-f>', function() end, { noremap = true, silent = true})
vim.keymap.set('n', '<C-f>', telescope.current_buffer_fuzzy_find, { noremap = true, silent = true})
vim.keymap.set('n', '<C-p>', telescope.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader><space>', telescope.live_grep, { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
  },
  -- textobjects = {
  --   select = {
  --     enable = true,
  --     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
  --     keymaps = {
  --       -- You can use the capture groups defined in textobjects.scm
  --       ['af'] = '@function.outer',
  --       ['if'] = '@function.inner',
  --       ['ac'] = '@class.outer',
  --       ['ic'] = '@class.inner',
  --     },
  --   },
  --   move = {
  --     enable = true,
  --     set_jumps = true, -- whether to set jumps in the jumplist
  --     goto_next_start = {
  --       [']m'] = '@function.outer',
  --       [']]'] = '@class.outer',
  --     },
  --     goto_next_end = {
  --       [']M'] = '@function.outer',
  --       [']['] = '@class.outer',
  --     },
  --     goto_previous_start = {
  --       ['[m'] = '@function.outer',
  --       ['[['] = '@class.outer',
  --     },
  --     goto_previous_end = {
  --       ['[M'] = '@function.outer',
  --       ['[]'] = '@class.outer',
  --     },
  --   },
  -- },
}

-- LSP settings
local nvim_lsp = require('lspconfig')
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- Enable the following language servers
nvim_lsp.rust_analyzer.setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      procMacro = {
        enable = true
      },
      diagnostics = {
            enable = true,
            disabled = {"unresolved-proc-macro"},
            experimental = {
              enable = true
            }
      },
    }
  }
}

nvim_lsp.gopls.setup{
  on_attach = on_attach
}

nvim_lsp.helm_ls.setup {
  settings = {
    ['helm-ls'] = {
      yamlls = {
        enabled = false,
      }
    }
  }
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

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

require('Navigator').setup()
-- Alt + hjkl splits navigation on Mac
-- May need another set for terminal?
vim.api.nvim_set_keymap('n', '˙', "<CMD>lua require('Navigator').left()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '∆', "<CMD>lua require('Navigator').down()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '˚', "<CMD>lua require('Navigator').up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '¬', "<CMD>lua require('Navigator').right()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>Neotree toggle=true focus<CR>', { noremap = true, silent = true })
