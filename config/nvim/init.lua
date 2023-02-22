-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

-- Disable deprecated commands from neo-tree
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'famiu/feline.nvim' -- Status line
  use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'} -- Tabs
  use 'famiu/bufdelete.nvim' -- Nicer buffer deleter commands, compliments the buffeline tabs
  use { 'nvim-neo-tree/neo-tree.nvim', branch = 'v2.x', requires = { 'kyazdani42/nvim-web-devicons', 'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'} } 
  use 'terrortylor/nvim-comment' -- Comment visual regions/lines
  use 'windwp/nvim-autopairs' -- Automatically close brackets
  use 'p00f/nvim-ts-rainbow' -- Rainbow brackets
  use 'numToStr/Navigator.nvim' -- Splits navigation
  use 'norcalli/nvim-colorizer.lua' -- Show color blocks around color codes
  use 'RRethy/nvim-base16' -- Colorscheme pack
  use 'akinsho/toggleterm.nvim' -- Toggleable terminal

  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'

  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'nvim-lua/lsp_extensions.nvim' -- Extensions to the LSP (like inlay hints)
  use 'simrat39/rust-tools.nvim' -- Rust-specific LSP integration
  use 'ray-x/lsp_signature.nvim'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lua'
  use 'ray-x/cmp-treesitter'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
end)

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

-- Split direction
vim.o.splitbelow = true
vim.o.splitright = true

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

-- We may need this for toggleterm
-- vim.o.hidden = true

--Share clipboard with system
vim.o.clipboard='unnamedplus'

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
vim.cmd('colorscheme base16-onedark')

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
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

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

-- autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs lua require('lsp_extensions').inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

-- Check for file changes when focusing
vim.api.nvim_exec(
  [[
    autocmd BufEnter,FocusGained * checktime
  ]],
  false
)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

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

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    }
  },
}

-- Telescope shortcuts
vim.api.nvim_set_keymap('', '<C-f>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-p>', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })

-- Tags shortcuts, revisit one day?
-- vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })

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
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Rust Tools
require('rust-tools').setup({})

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

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require("lsp_signature").setup()

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require('luasnip')

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- ['<C-p>'] = cmp.mapping.select_prev_item(),
    -- ['<C-n>'] = cmp.mapping.select_next_item(),
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
    { name = 'treesitter' },
  },
}

-- feline config
local colors = {
    bg = '#282c34',
    fg = '#abb2bf',
    yellow = '#e0af68',
    cyan = '#56b6c2',
    darkblue = '#081633',
    green = '#98c379',
    orange = '#d19a66',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#61afef',
    red = '#e86671'
}

local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}

local function file_osinfo()
    local os = vim.loop.os_uname().sysname
    if os == 'Linux' then
        return ' LINUX'
    elseif os == 'Darwin' then
        return ' MAC'
    else
        return ' WINDOWS'
    end
end

local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'

local lsp_get_diag = function(sev)
  local items = vim.diagnostic.get(0, { severity = sev })
  local count = 0
  for _ in pairs(items) do
    count = count + 1
  end
  return (count > 0) and ' '..count..' ' or ''
end

-- LuaFormatter off

local comps = {
    vi_mode = {
        left = {
            provider = function()
              return '  ' .. vi_mode_utils.get_vim_mode()
            end,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color(),
                    -- fg = colors.bg
                }
                return val
            end,
            right_sep = ' '
        },
        right = {
            -- provider = '▊',
            provider = '' ,
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = vi_mode_utils.get_mode_color()
                }
                return val
            end,
            left_sep = ' ',
            right_sep = ' '
        }
    },
    file = {
        info = {
            provider = {
              name = 'file_info',
              opts = {
                type = 'relative',
                file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_readonly_icon = '  ',
                -- file_modified_icon = '',
                file_modified_icon = '',
                -- file_modified_icon = 'ﱐ',
                -- file_modified_icon = '',
                -- file_modified_icon = '',
                -- file_modified_icon = '',
              }
            },
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        encoding = {
            provider = 'file_encoding',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        type = {
            provider = 'file_type'
        },
        os = {
            provider = file_osinfo,
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            }
        },
        position = {
            provider = 'position',
            left_sep = ' ',
            hl = {
                fg = colors.cyan,
                -- style = 'bold'
            }
        },
    },
    left_end = {
        provider = function() return '' end,
        hl = {
            fg = colors.bg,
            bg = colors.blue,
        }
    },
    line_percentage = {
        provider = 'line_percentage',
        left_sep = ' ',
        hl = {
            style = 'bold'
        }
    },
    scroll_bar = {
        provider = 'scroll_bar',
        left_sep = ' ',
        hl = {
            fg = colors.blue,
            style = 'bold'
        }
    },
    diagnos = {
        err = {
            -- provider = 'diagnostic_errors',
            provider = function()
                return '' .. lsp_get_diag(vim.diagnostic.severity.ERROR)
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('ERROR') end,
            hl = {
                fg = colors.red
            }
        },
        warn = {
            -- provider = 'diagnostic_warnings',
            provider = function()
                return '' ..  lsp_get_diag(vim.diagnostic.severity.WARN)
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('WARN') end,
            hl = {
                fg = colors.yellow
            }
        },
        info = {
            -- provider = 'diagnostic_info',
            provider = function()
                return '' .. lsp_get_diag(vim.diagnostic.severity.INFO)
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('INFO') end,
            hl = {
                fg = colors.blue
            }
        },
        hint = {
            -- provider = 'diagnostic_hints',
            provider = function()
                return '' .. lsp_get_diag(vim.diagnostic.severity.HINT)
            end,
            -- left_sep = ' ',
            enabled = function() return lsp.diagnostics_exist('HINT') end,
            hl = {
                fg = colors.cyan
            }
        },
    },
    lsp = {
        name = {
            provider = 'lsp_client_names',
            -- left_sep = ' ',
            right_sep = ' ',
            -- icon = '  ',
            icon = '慎',
            hl = {
                fg = colors.yellow
            }
        }
    },
    git = {
        branch = {
            provider = 'git_branch',
            icon = ' ',
            -- icon = ' ',
            left_sep = ' ',
            hl = {
                fg = colors.violet,
                style = 'bold'
            },
        },
        add = {
            provider = 'git_diff_added',
            hl = {
                fg = colors.green
            }
        },
        change = {
            provider = 'git_diff_changed',
            hl = {
                fg = colors.orange
            }
        },
        remove = {
            provider = 'git_diff_removed',
            hl = {
                fg = colors.red
            }
        }
    }
}

local components = {
  active = {},
  inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

table.insert(components.active[1], comps.vi_mode.left)
table.insert(components.active[1], comps.file.info)
table.insert(components.active[1], comps.git.branch)
table.insert(components.active[1], comps.git.add)
table.insert(components.active[1], comps.git.change)
table.insert(components.active[1], comps.git.remove)
table.insert(components.inactive[1], comps.vi_mode.left)
table.insert(components.inactive[1], comps.file.info)
table.insert(components.active[3], comps.diagnos.err)
table.insert(components.active[3], comps.diagnos.warn)
table.insert(components.active[3], comps.diagnos.hint)
table.insert(components.active[3], comps.diagnos.info)
table.insert(components.active[3], comps.lsp.name)
table.insert(components.active[3], comps.file.os)
table.insert(components.active[3], comps.file.position)
table.insert(components.active[3], comps.line_percentage)
table.insert(components.active[3], comps.scroll_bar)
table.insert(components.active[3], comps.vi_mode.right)


-- TreeSitter
-- local ts_utils = require("nvim-treesitter.ts_utils")
-- local ts_parsers = require("nvim-treesitter.parsers")
-- local ts_queries = require("nvim-treesitter.query")
--[[ table.insert(components.active[2], {
  provider = function()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    return ("%d:%s [%d, %d] - [%d, %d]")
      :format(node:symbol(), node:type(), node:range())
  end,
  enabled = function()
    local ok, ts_parsers = pcall(require, "nvim-treesitter.parsers")
    return ok and ts_parsers.has_parser()
  end
}) ]]

-- require'feline'.setup {}
require('feline').setup {
    colors = { bg = colors.bg, fg = colors.fg },
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
        filetypes = {
            'packer',
            'NvimTree',
            'fugitive',
            'fugitiveblame'
        },
        buftypes = {'terminal'},
        bufnames = {}
    }
}

require("bufferline").setup{
  options = {
    offsets = {{
      filetype = "NvimTree",
      text = "Files",
      highlight = "Directory",
      text_align = "left"
    }},
    close_command = function(bufnum)
      require('bufdelete').bufdelete(bufnum, true)
    end,
    right_mouse_command = function(bufnum)
      require('bufdelete').bufdelete(bufnum, true)
    end
  }
}

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

require('nvim_comment').setup() -- Mapped to gcc and gc by default

require('nvim-autopairs').setup{}

require('colorizer').setup()

require('Navigator').setup()
-- Alt + hjkl splits navigation on Mac
-- May need another set for terminal?
vim.api.nvim_set_keymap('n', '˙', "<CMD>lua require('Navigator').left()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '∆', "<CMD>lua require('Navigator').down()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '˚', "<CMD>lua require('Navigator').up()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '¬', "<CMD>lua require('Navigator').right()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>Neotree toggle=true focus<CR>', { noremap = true, silent = true })
