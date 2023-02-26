local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{ "<leader>?", "<cmd>Telescope oldfiles<CR>" },
		{ "<leader><space>", "<cmd>Telescope buffers<CR>" },
		{ "<leader>vo", "<cmd>Telescope aerial<cr>", desc = "Code Outline" },
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end,
		},
	},
	dependencies = {
		{ "anuvyklack/hydra.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{
			"stevearc/aerial.nvim",
			keys = { { "<leader>to", "<cmd>AerialToggle<CR>", desc = "Toggle Outline" } },
			config = function()
				local aerial = require("aerial")
				aerial.setup()
			end,
		},
	},
}

function M.config()
	local telescope = require("telescope")

	local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _r_: resume      _u_: undotree
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _h_: vim help    _c_: execute command
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _k_: keymaps     _;_: commands history 
                 _O_: options     _?_: search history
 ^
                 _<Enter>_: Telescope           _<Esc>_
]]

	-- local builtin = require("telescope.builtin")

	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-u>"] = false,
					["<C-d>"] = false,
				},
			},
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
			aerial = {
				show_nesting = {
					["_"] = false,
					python = true,
				},
			},
		},
	})

	-- Enable telescope fzf native, if installed
	telescope.load_extension("fzf")
	telescope.load_extension("aerial")

	--
	local Hydra = require("hydra")
	local cmd = require("hydra.keymap-util").cmd
	Hydra({
		name = "Telescope",
		hint = hint,
		config = {
			color = "teal",
			invoke_on_body = true,
			hint = {
				position = "middle",
				border = "rounded",
			},
		},
		mode = "n",
		body = "<Leader>f",
		heads = {
			{ "f", cmd("Telescope find_files") },
			{ "g", cmd("Telescope live_grep") },
			{ "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
			{ "h", cmd("Telescope help_tags"), { desc = "vim help" } },
			{ "m", cmd("MarksListBuf"), { desc = "marks" } },
			{ "k", cmd("Telescope keymaps") },
			{ "O", cmd("Telescope vim_options") },
			{ "r", cmd("Telescope resume") },
			{ "p", cmd("Telescope projects"), { desc = "projects" } },
			{ "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
			{ "?", cmd("Telescope search_history"), { desc = "search history" } },
			{ ";", cmd("Telescope command_history"), { desc = "command-line history" } },
			{ "c", cmd("Telescope commands"), { desc = "execute command" } },
			{ "u", cmd("silent! %foldopen! | UndotreeToggle"), { desc = "undotree" } },
			{ "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
			{ "<Esc>", nil, { exit = true, nowait = true } },
		},
	})
end

return M
