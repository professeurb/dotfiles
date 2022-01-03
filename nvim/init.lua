require("profb.options")
require("profb.plugins")
require("profb.mappings")
require("profb.lsp")
require("profb.cmp")
require("profb.telescope")
require("profb.toggleterm")
require("profb.whichkey")

vim.cmd([[ colorscheme nordfox ]])

vim.cmd([[
let g:vimtex_compiler_engine = 'lualatex'
]])

vim.cmd([[
set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]])
