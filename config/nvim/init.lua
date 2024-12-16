-- Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

--Set highlight on search
vim.opt.hlsearch = true

--Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

--Enable mouse mode
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.opt.breakindent = true

-- Tab settings
vim.o.tabstop = 2
vim.o.shiftwidth = 2
-- vim.o.expandtab = true
-- vim.o.autoindent = true
-- vim.o.smartindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "▏ ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.o.background = "light" -- or "light" for light mode

-- Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.o.updatetime = 300
vim.api.nvim_create_autocmd("CursorHold", {
	desc = "Open floating diagnostic window on CursorHold",
	group = vim.api.nvim_create_augroup("cursor-lsp-diag", {}),
	callback = function()
		vim.diagnostic.open_float({ focusable = false })
	end,
})

---------------------------------------------------
--
--              Plugin Config
--
---------------------------------------------------

-- Install packer
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
		{ "windwp/nvim-autopairs", event = "InsertEnter", opts = {} }, -- Automatically close brackets
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		}, -- Show color blocks around color codes
		{
			"shortcuts/no-neck-pain.nvim",
			tag = "v2.1.3",
			opts = {
				autocmds = { enableOnVimEnter = true },
				width = 120,
				integrations = {
					NeoTree = {
						-- The position of the tree.
						---@type "left"|"right"
						position = "left",
						-- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
						reopen = true,
					},
				},
			},
		},
		{ -- Add indentation guides even on blank lines
			"lukas-reineke/indent-blankline.nvim",
			tag = "v3.8.6",
			main = "ibl",
			dependencies = { "treesitter" },
			config = function()
				local highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				}
				local hooks = require("ibl.hooks")
				-- create the highlight groups in the highlight setup hook, so they are reset
				-- every time the colorscheme changes
				hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
					vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
					vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
					vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
					vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
					vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
					vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
					vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
				end)

				require("ibl").setup({ indent = { highlight = highlight } })
				-- require("ibl").setup { scope = { highlight = highlight } }
				hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
			end,
		},

		{
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = { signs = false },
		},
		{ "HiPhish/rainbow-delimiters.nvim", tag = "v0.7.0", dependencies = { "treesitter" } },

		{
			-- 'RRethy/nvim-base16' -- Colorscheme pack
			-- 'rebelot/kanagawa.nvim' -- Colorscheme
			-- 'luisiacc/gruvbox-baby'
			"ellisonleao/gruvbox.nvim",
			config = function()
				vim.cmd("colorscheme gruvbox")
			end,
			-- vim.cmd('colorscheme kanagawa')
			-- vim.cmd('colorscheme base16-gruvbox-light-medium')
			-- vim.cmd('colorscheme gruvbox-baby')
		},

		{ -- Bunch of mini plugins
			"echasnovski/mini.nvim",
			branch = "stable",
			config = function()
				require("mini.comment").setup()
				require("mini.notify").setup()
				require("mini.statusline").setup({ use_icons = vim.g.have_nerd_font })
			end,
		},

		{ -- Autoformat
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					-- Disable "format_on_save lsp_fallback" for languages that don't
					-- have a well standardized coding style. You can add additional
					-- languages here or re-enable it for the disabled ones.
					local disable_filetypes = { c = true, cpp = true }
					local lsp_format_opt
					if disable_filetypes[vim.bo[bufnr].filetype] then
						lsp_format_opt = "never"
					else
						lsp_format_opt = "fallback"
					end
					return {
						timeout_ms = 500,
						lsp_format = lsp_format_opt,
					}
				end,
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					--
					-- You can use 'stop_after_first' to run the first available formatter from the list
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			},
		},

		-- LSP & Completion
		{ -- Autocompletion
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				-- Snippet Engine & its associated nvim-cmp source
				{
					"L3MON4D3/LuaSnip",
					build = (function()
						-- Build Step is needed for regex support in snippets.
						-- This step is not supported in many windows environments.
						-- Remove the below condition to re-enable on windows.
						if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
							return
						end
						return "make install_jsregexp"
					end)(),
					dependencies = {
						-- `friendly-snippets` contains a variety of premade snippets.
						--    See the README about individual language/framework/plugin snippets:
						--    https://github.com/rafamadriz/friendly-snippets
						-- {
						--   'rafamadriz/friendly-snippets',
						--   config = function()
						--     require('luasnip.loaders.from_vscode').lazy_load()
						--   end,
						-- },
					},
				},
				"saadparwaiz1/cmp_luasnip",

				-- Adds other completion capabilities.
				--  nvim-cmp does not ship with all sources by default. They are split
				--  into multiple repos for maintenance purposes.
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-path",
			},
			config = function()
				-- See `:help cmp`
				local cmp = require("cmp")
				local luasnip = require("luasnip")
				luasnip.config.setup({})

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					completion = { completeopt = "menu,menuone,noinsert" },

					-- For an understanding of why these mappings were
					-- chosen, you will need to read `:help ins-completion`
					--
					-- No, but seriously. Please read `:help ins-completion`, it is really good!
					mapping = cmp.mapping.preset.insert({
						-- Scroll the documentation window [b]ack / [f]orward
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),

						-- If you prefer more traditional completion keymaps,
						-- you can uncomment the following lines
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping.select_next_item(),
						["<S-Tab>"] = cmp.mapping.select_prev_item(),

						-- Manually trigger a completion from nvim-cmp.
						--  Generally you don't need this, because nvim-cmp will display
						--  completions whenever it has completion options available.
						["<C-Space>"] = cmp.mapping.complete({}),

						-- Think of <c-l> as moving to the right of your snippet expansion.
						--  So if you have a snippet that's like:
						--  function $name($args)
						--    $body
						--  end
						--
						-- <c-l> will move you to the right of each of the expansion locations.
						-- <c-h> is similar, except moving you backwards.
						["<C-l>"] = cmp.mapping(function()
							if luasnip.expand_or_locally_jumpable() then
								luasnip.expand_or_jump()
							end
						end, { "i", "s" }),
						["<C-h>"] = cmp.mapping(function()
							if luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							end
						end, { "i", "s" }),

						-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
						--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
					}),
					sources = {
						{
							name = "lazydev",
							-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
							group_index = 0,
						},
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "path" },
					},
				})
			end,
		},
		{ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			name = "treesitter",
			build = ":TSUpdate",
			main = "nvim-treesitter.configs", -- Sets main module to use for opts
			opts = {
				ensure_installed = {
					"bash",
					"c",
					"cmake",
					"cpp",
					"csv",
					"cue",
					"diff",
					"dockerfile",
					"gitignore",
					"git_rebase",
					"gitattributes",
					"go",
					"gomod",
					"gosum",
					"html",
					"javascript",
					"json",
					"json5",
					"lua",
					"luadoc",
					"make",
					"markdown",
					"markdown_inline",
					"rust",
					"sql",
					"terraform",
					"toml",
					"typescript",
					"query",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
				},
				-- Autoinstall languages that are not installed
				-- auto_install = true,
				-- sync_install = true,
				highlight = {
					enable = true,
					-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
					--  If you are experiencing weird indenting issues, add the language to
					--  the list of additional_vim_regex_highlighting and disabled languages for indent.
					additional_vim_regex_highlighting = { "ruby" },
				},
				indent = { enable = true, disable = { "ruby" } },
			},
		},
		-- 'towolf/vim-helm'

		-- Lua
		{ -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },

		{ -- Main LSP Configuration
			"neovim/nvim-lspconfig",
			dependencies = {
				-- Automatically install LSPs and related tools to stdpath for Neovim
				{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
				"williamboman/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",

				-- Useful status updates for LSP.
				-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
				{ "j-hui/fidget.nvim", opts = {} },

				-- Allows extra capabilities provided by nvim-cmp
				"hrsh7th/cmp-nvim-lsp",
			},
			config = function()
				--  This function gets run when an LSP attaches to a particular buffer.
				--    That is to say, every time a new file is opened that is associated with
				--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
				--    function will be executed to configure the current buffer
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc, mode)
							mode = mode or "n"
							vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						local telescope = require("telescope.builtin")

						-- Jump to the definition of the word under your cursor.
						--  This is where a variable was first declared, or where a function is defined, etc.
						--  To jump back, press <C-t>.
						map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")

						-- Find references for the word under your cursor.
						map("gr", telescope.lsp_references, "[G]oto [R]eferences")

						-- Jump to the implementation of the word under your cursor.
						--  Useful when your language has ways of declaring types without an actual implementation.
						map("gi", telescope.lsp_implementations, "[G]oto [I]mplementation")

						-- Jump to the type of the word under your cursor.
						--  Useful when you're not sure what type a variable is and you want to see
						--  the definition of its *type*, not where it was *defined*.
						map("<leader>D", telescope.lsp_type_definitions, "Type [D]efinition")

						-- Fuzzy find all the symbols in your current document.
						--  Symbols are things like variables, functions, types, etc.
						map("<leader>ds", telescope.lsp_document_symbols, "[D]ocument [S]ymbols")

						-- Rename the variable under your cursor.
						--  Most Language Servers support renaming across files, etc.
						map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

						-- Execute a code action, usually your cursor needs to be on top of an error
						-- or a suggestion from your LSP for this to activate.
						map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

						-- WARN: This is not Goto Definition, this is Goto Declaration.
						--  For example, in C this would take you to the header.
						map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

						map("K", vim.lsp.buf.hover, "Show type size")
						map("C-K", vim.lsp.buf.signature_help, "I don't know what this does")

						-- The following two autocommands are used to highlight references of the
						-- word under your cursor when your cursor rests there for a little while.
						--    See `:help CursorHold` for information about when this is executed
						--
						-- When you move your cursor, the highlights will be cleared (the second autocommand).
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if
							client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight)
						then
							local highlight_augroup =
								vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.document_highlight,
							})

							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = vim.lsp.buf.clear_references,
							})

							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({
										group = "kickstart-lsp-highlight",
										buffer = event2.buf,
									})
								end,
							})
						end

						-- The following code creates a keymap to toggle inlay hints in your
						-- code, if the language server you are using supports them
						--
						-- This may be unwanted, since they displace some of your code
						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end
					end,
				})

				-- Change diagnostic symbols in the sign column (gutter)
				if vim.g.have_nerd_font then
					local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
					local diagnostic_signs = {}
					for type, icon in pairs(signs) do
						diagnostic_signs[vim.diagnostic.severity[type]] = icon
					end
					vim.diagnostic.config({ signs = { text = diagnostic_signs } })
				end

				-- LSP servers and clients are able to communicate to each other what features they support.
				--  By default, Neovim doesn't support everything that is in the LSP specification.
				--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
				--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities =
					vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

				-- Enable the following language servers
				--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
				--
				--  Add any additional override configuration in the following tables. Available keys are:
				--  - cmd (table): Override the default command used to start the server
				--  - filetypes (table): Override the default list of associated filetypes for the server
				--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
				--  - settings (table): Override the default settings passed when initializing the server.
				--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
				local servers = {
					-- clangd = {},
					gopls = {},
					-- pyright = {},
					rust_analyzer = {
						settings = {
							procMacro = {
								enable = true,
							},
							diagnostics = {
								enable = true,
								disabled = { "unresolved-proc-macro" },
								experimental = {
									enable = true,
								},
							},
						},
					},
					-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

					lua_ls = {
						-- cmd = { ... },
						-- filetypes = { ... },
						-- capabilities = {},
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
								diagnostics = { disable = { "missing-fields" } },
							},
						},
					},
				}

				-- Ensure the servers and tools above are installed
				--  To check the current status of installed tools and/or manually install
				--  other tools, you can run
				--    :Mason
				--
				--  You can press `g?` for help in this menu.
				require("mason").setup()

				-- You can add other tools here that you want Mason to install
				-- for you, so that they are available from within Neovim.
				local ensure_installed = vim.tbl_keys(servers or {})
				vim.list_extend(ensure_installed, {
					"stylua", -- Used to format Lua code
				})
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				require("mason-lspconfig").setup({
					ensure_installed = {},
					automatic_installation = false,
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							-- This handles overriding only values explicitly passed
							-- by the server configuration above. Useful when disabling
							-- certain features of an LSP (for example, turning off formatting for ts_ls)
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end,
					},
				})
			end,
		},

		-- UI
		"sitiom/nvim-numbertoggle",
		{ -- Adds git related signs to the gutter, as well as utilities for managing changes
			"lewis6991/gitsigns.nvim",
			opts = {
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			},
		},
		{ -- Toggleable terminal
			"akinsho/toggleterm.nvim",
			config = function()
				require("toggleterm").setup({
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
					direction = "horizontal", --| 'vertical' | 'window' | 'float',
					close_on_exit = true, -- close the terminal window when the process exits
					shell = vim.o.shell, -- change the default shell
				})
			end,
		},
		{ -- Splits navigation
			"numToStr/Navigator.nvim",
			config = function()
				local navigator = require("Navigator")
				navigator.setup({})
				-- Alt + hjkl splits navigation on Mac
				-- May need another set for terminal?
				vim.keymap.set("n", "˙", navigator.left, { noremap = true, silent = true })
				vim.keymap.set("n", "∆", navigator.down, { noremap = true, silent = true })
				vim.keymap.set("n", "˚", navigator.up, { noremap = true, silent = true })
				vim.keymap.set("n", "¬", navigator.right, { noremap = true, silent = true })
			end,
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			cmd = "Neotree",
			keys = {
				{ "<C-n>", ":Neotree toggle=true focus<CR>", desc = "NeoTree toggle", silent = true },
			},
		},
		{ -- Fuzzy Finder (files, lsp, etc)
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			branch = "0.1.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{ -- If encountering errors, see telescope-fzf-native README for installation instructions
					"nvim-telescope/telescope-fzf-native.nvim",

					-- `build` is used to run some command when the plugin is installed/updated.
					-- This is only run then, not every time Neovim starts up.
					build = "make",

					-- `cond` is a condition used to determine whether this plugin should be
					-- installed and loaded.
					cond = function()
						return vim.fn.executable("make") == 1
					end,
				},
				{ "nvim-telescope/telescope-ui-select.nvim" },

				-- Useful for getting pretty icons, but requires a Nerd Font.
				{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			},
			config = function()
				-- Telescope is a fuzzy finder that comes with a lot of different things that
				-- it can fuzzy find! It's more than just a "file finder", it can search
				-- many different aspects of Neovim, your workspace, LSP, and more!
				--
				-- The easiest way to use Telescope, is to start by doing something like:
				--  :Telescope help_tags
				--
				-- After running this command, a window will open up and you're able to
				-- type in the prompt window. You'll see a list of `help_tags` options and
				-- a corresponding preview of the help.
				--
				-- Two important keymaps to use while in Telescope are:
				--  - Insert mode: <c-/>
				--  - Normal mode: ?
				--
				-- This opens a window that shows you all of the keymaps for the current
				-- Telescope picker. This is really useful to discover what Telescope can
				-- do as well as how to actually do it!

				-- [[ Configure Telescope ]]
				-- See `:help telescope` and `:help telescope.setup()`
				require("telescope").setup({
					-- You can put your default mappings / updates / etc. in here
					--  All the info you're looking for is in `:help telescope.setup()`
					--
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown(),
						},
					},
				})

				-- Enable Telescope extensions if they are installed
				pcall(require("telescope").load_extension, "fzf")
				pcall(require("telescope").load_extension, "ui-select")

				local telescope = require("telescope.builtin")

				-- See `:help telescope.builtin`
				vim.keymap.set("", "<C-f>", function() end, { noremap = true, silent = true })
				vim.keymap.set("n", "<C-f>", telescope.current_buffer_fuzzy_find, { noremap = true, silent = true })
				vim.keymap.set("n", "<C-p>", telescope.find_files, { noremap = true, silent = true })
				vim.keymap.set("n", "<leader><space>", telescope.live_grep, { noremap = true, silent = true })
				-- vim.keymap.set('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
				-- vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
				-- vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
				-- vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
				-- vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
				-- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
				-- vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
				-- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
				-- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
				-- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

				-- Slightly advanced example of overriding default behavior and theme
				-- vim.keymap.set('n', '<leader>/', function()
				--   -- You can pass additional configuration to Telescope to change the theme, layout, etc.
				--   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				--     winblend = 10,
				--     previewer = false,
				--   })
				-- end, { desc = '[/] Fuzzily search in current buffer' })
			end,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

-- Enable the following language servers
-- nvim_lsp.helm_ls.setup {
--   settings = {
--     ['helm-ls'] = {
--       yamlls = {
--         enabled = false,
--       }
--     }
--   }
-- }

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"
