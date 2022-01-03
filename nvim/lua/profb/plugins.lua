local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins hre
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself

	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	-- https://github.com/windwp/nvim-autopairs
	-- use({
	--	"windwp/nvim-autopairs",
	--	config = function()
	--		require("nvim-autopairs").setup({
	--			check_ts = true,
	--		})
	--	end,
	-- })

	-- https://github.com/nvim-lualine/lualine.nvim
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
			config = function()
				require("lualine").setup({
					options = {
						-- section_separators = { left = '?', right = '?'},
						component_separators = "",
					},
				})
			end,
		},
	})

	-- https://github.com/lukas-reineke/indent-blankline.nvim
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	})

	use({
		"folke/which-key.nvim",
	})

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use("lunarvim/darkplus.nvim")
	-- use "rose-pine/neovim"
	-- use "arcticicestudio/nord-vim"
	use("rebelot/kanagawa.nvim")
	use("EdenEast/nightfox.nvim")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		opt = true,
		cmd = "Telescope",
		module = "telescope",
		requires = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				opt = true,
				event = "UIEnter",
				run = "make",
			},
			{ "nvim-lua/plenary.nvim" },
			{
				"benfowler/telescope-luasnip.nvim",
				opt = true,
				module = "telescope._extensions.luasnip",
			},
		},
	})

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	-- use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("tami5/lspsaga.nvim") -- icons for LSP diagnostics
	use("onsails/lspkind-nvim") -- vscode-like pictograms for neovim lsp completion items

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-calc" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
	})

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
	})
	use({ "rafamadriz/friendly-snippets" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		opt = true,
		event = "UIEnter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- one of "all", "maintained", or a list of languages
				ensure_installed = "maintained",
				sync_install = false,
				highlight = {
					enable = true, -- false will disable the whole extension
					-- disable = { "c", "rust" },  -- list of language that will be disabled
				},
				rainbow = {
					enable = true,
				},
				autopairs = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<leader>+",
						node_incremental = "<leader>=",
						node_decremental = "<leader>-",
						scope_incremental = "<leader>}",
						scope_decremental = "<leader>{",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},
				},
			})
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		after = "nvim-treesitter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		after = "nvim-treesitter",
	})
	--	use({
	--		"nvim-treesitter/playground",
	--	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup()
		end,
	})
	-- use({ "f-person/git-blame.nvim" })

	use("akinsho/toggleterm.nvim")

	-- TeX
	use("lervag/vimtex")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
