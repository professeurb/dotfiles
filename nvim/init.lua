-- https://github.com/fadelpamungkas/dotfiles
-- https://github.com/ziontee113/lazy-nvim-config
-- https://github.com/tcmmichaelb139/.dotfiles/tree/main/nvim/.config/nvim
-- https://github.com/AdiCahyaSaputra/my-neovim-setup
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("profb.mappings")
require("profb.options")

require("lazy").setup("profb.plugins", {
	defaults = { lazy = true },
	install = { colorscheme = { "habamax" } },
	checker = { enabled = false },
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
