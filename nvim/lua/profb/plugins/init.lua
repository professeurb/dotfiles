return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			local wk = require("which-key")
			wk.setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
			wk.register({
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				-- ["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>sn"] = { name = "+noice" },
				["<leader>t"] = { name = "+toggle" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = true,
		keys = { { "<leader>tt", "<cmd>TroubleToggle<CR>", desc = "Toggle Trouble" } },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = { { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Neotree" } },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	},
	{ "numToStr/Comment.nvim", event = "BufReadPre", config = true },
	{
		"kevinhwang91/nvim-ufo",
		-- enabled = false,
		event = "BufReadPre",
		dependencies = { "nvim-treesitter/nvim-treesitter", "kevinhwang91/promise-async" },
		config = function()
			vim.cmd([[ autocmd BufReadPost,FileReadPost * normal zR ]])
			require("ufo").setup({
				provider_selector = function(_, _, _)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},
	{
		"anuvyklack/hydra.nvim",
		event = "VeryLazy",
	},
	-- { 'code-biscuits/nvim-biscuits',
	--   event = "BufReadPre",
	--   dependencies = { 'nvim-treesitter/nvim-treesitter' },
	--   config = true
	-- },
	{
		"giusgad/pets.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "edluffy/hologram.nvim" },
		cmd = { "PetsNew", "PetsNewCustom" },
		config = true,
	},
	{ "boltlessengineer/bufterm.nvim", config = true, cmd = "BufTermEnter" },
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
	{ "m4xshen/autoclose.nvim", config = true, event = "InsertEnter" },
	{ "windwp/nvim-autopairs", event = "BufReadPre", config = true },
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy", config = true },
	{ "lervag/vimtex", ft = "tex" },
}
