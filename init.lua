vim.cmd.syntax("off")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.netrw_banner = false
vim.g.netrw_list_hide = [[^\.\.\=/\=$]]

vim.g.wildcharm = "<C-z>" -- allows to have tab in mappings

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.laststatus = 3

vim.o.hlsearch = false
vim.opt.incsearch = true

vim.o.mouse = "a"

vim.o.undofile = true

vim.opt.list = false
vim.opt.listchars = { space = '⋅', tab = '→ ' }
vim.opt.showbreak = "↪ "

vim.wo.wrap = false

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { silent = true })

-- Use ripgrep for :grep
vim.o.grepprg = "rg --vimgrep --smart-case --follow"
vim.opt.grepformat:prepend('%f:%l:%c:%m')

vim.cmd.iabbrev("<expr>", ",d", "strftime('%Y-%m-%d')")

vim.keymap.set("n", "gp", "`[v`]")

vim.opt.wildignore = { "node_modules/*", "dist/*" }

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.smarttab = true

-- Join lines but keep cursor in same position!!
vim.keymap.set("n", "J", "mbJ`b")

vim.keymap.set("n", ",", ":lua= ")
vim.keymap.set("n", "<leader>L", ":luafile %<CR>")
vim.keymap.set("n", "<BS>", ":b#<CR>")

vim.keymap.set("n", "<leader>c", ':copen<cr>', { silent = true })

vim.keymap.set("n", "<leader>E", function()
	vim.cmd.cd('~/.config/nvim')
	vim.cmd.e('init.lua')
end, { silent = true })

vim.keymap.set("n", "[b", ":bp<cr>", { silent = true })
vim.keymap.set("n", "]b", ":bn<cr>", { silent = true })
vim.keymap.set("n", "[c", ":cprev<cr>", { silent = true })
vim.keymap.set("n", "]c", ":cnext<cr>", { silent = true })
vim.keymap.set("n", "<leader>o", ":only<cr>", { silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.diagnostic.config({
	virtual_text = true,
})

-- remove trailing whitespace!
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function(_)
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = { 'n:i', 'v:s' },
	desc = 'Disable diagnostics in insert and select mode',
	callback = function(e) vim.diagnostic.disable(e.buf) end
})

vim.api.nvim_create_autocmd('ModeChanged', {
	pattern = 'i:n',
	desc = 'Enable diagnostics when leaving insert mode',
	callback = function(e) vim.diagnostic.enable(e.buf) end
})

-- NOTE: Originally tried to put this in FileType event autocmd but it is apparently too early for `set modifiable` to take effect
vim.api.nvim_create_autocmd('BufWinEnter', {
	group = vim.api.nvim_create_augroup('YOUR_GROUP_HERE', { clear = true }),
	desc = 'allow updating quickfix window',
	pattern = 'quickfix',
	callback = function(_)
		vim.bo.modifiable = true
		-- :vimgrep's quickfix window display format now includes start and end column (in vim and nvim) so adding 2nd format to match that
		vim.bo.errorformat = '%f|%l col %c| %m,%f|%l col %c-%k| %m'
		vim.keymap.set(
			'n',
			'<C-s>',
			'<Cmd>cgetbuffer|set nomodified|echo "quickfix/location list updated"<CR>',
			{ buffer = true, desc = 'Update quickfix/location list with changes made in quickfix window' }
		)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>n", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-- js using spaces, not tabs
vim.api.nvim_create_autocmd('FileType', {
	-- :lua= vim.bo.filetype
	pattern = { "css", "scss", "typescriptreact", "typescript" },
	callback = function(_)
		vim.bo.expandtab = true
		vim.bo.tabstop = 16
		vim.bo.shiftwidth = 2
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { "typescriptreact", "typescript" },
	callback = function(_)
		vim.bo.formatprg = "prettier --parser typescript"
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { "css", "scss" },
	callback = function(_)
		vim.bo.formatprg = "prettier --parser css"
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { "go" },
	callback = function(_)
		vim.bo.formatprg = "gofmt"
		-- vim.bo.formatexpr = "v:vim.lsp.formatexpr()"
	end
})

vim.api.nvim_create_user_command('X', function(input)
	vim.print(input)
	vim.keymap.set(
		"n",
		"<leader> ",
		"mzvip:" .. input.args .. "<CR>`z",
		{ buffer = true }
	)
end, { nargs = 1 })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ 'navarasu/onedark.nvim' },
	{ "neovim/nvim-lspconfig" },
	{ "godlygeek/tabular" },
	{ "lewis6991/gitsigns.nvim" },
	{ "numToStr/Comment.nvim",                  opts = {} },
	{ "ruifm/gitlinker.nvim",                   dependencies = { "nvim-lua/plenary.nvim" } },
	{ 'nvim-telescope/telescope-ui-select.nvim' },
	{ "kylechui/nvim-surround",                 version = "*",                             event = "VeryLazy" },
	{ 'nvim-telescope/telescope.nvim',          tag = '0.1.5',                             dependencies = { 'nvim-lua/plenary.nvim' } },
	{ "nvim-treesitter/nvim-treesitter",        build = ":TSUpdate" },
})

require("onedark").setup { style = "darker" }
vim.cmd.colorscheme("onedark")

local configs = require("nvim-treesitter.configs")
---@diagnostic disable-next-line: missing-fields
configs.setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "typescript", "html" },
	sync_install = false,
	highlight = { enable = false },
	indent = { enable = false },
})

local gs = require("gitsigns")
gs.setup()
vim.keymap.set("n", "[h", gs.prev_hunk, { silent = true })
vim.keymap.set("n", "]h", gs.next_hunk, { silent = true })
vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { silent = true })
vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { silent = true })
vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { silent = true })
vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { silent = true })

local capabilities = nil

local lspc = require("lspconfig")

lspc.tsserver.setup({
	capabilities = capabilities,
})

lspc.pyright.setup({
	capabilities = capabilities,
})

lspc.gopls.setup({
	capabilities = capabilities,
	settings = {
		gopls = {
			staticcheck = true,
			hints = { assignVariableTypes = true },
			analyses = {
				unusedparams = true,
				nilness = true,
			},
		},
	},
})

lspc.lua_ls.setup({
	workspace = { checkThirdParty = false },
	capabilities = capabilities,
	settings = {
		-- See: https://github.com/neovim/nvim-lspconfig/blob/41a8269/doc/server_configurations.md#sumneko_lua
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

require("gitlinker").setup({
	opts = {
		remote = nil, -- force the use of a specific remote
		add_current_line_on_normal_mode = true,
		action_callback = require("gitlinker.actions").copy_to_clipboard,
		print_url = true,
	},
})
vim.keymap.set("n", "gl", '<cmd>lua require"gitlinker".get_buf_range_url("n", {})<cr>', { silent = true })
vim.keymap.set("v", "gl", ':lua require"gitlinker".get_buf_range_url("v", {})<cr>', { silent = true })

require("telescope").setup {
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {
				-- even more opts
			}
		},
	},
	pickers = {
		live_grep = {
			theme = "dropdown",
			opts = {
				additional_args = { "--pcre2" }
			}
		},
		find_files = {
			theme = "dropdown",
		},
		spell_suggest = {
			prompt_title = "",
			layout_config = {
				height = 10,
				width = 40
			}
		}
	}
}
require("telescope").load_extension("ui-select")

vim.keymap.set("n", "<leader>t", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>r", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>S", require("telescope.builtin").spell_suggest)

require("nvim-surround").setup()
vim.keymap.set("n", "<leader>.", ":Explore<CR>")
vim.keymap.set("n", "<leader>u", ":e %<<C-z>")
