local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
	return
end

local servers = {
	texlab = {
		auxDirectory = ".",
		bibtexFormatter = "texlab",
		latexFormatter = "latexindent",
		latexindent = { modifyLineBreaks = false },
	},
	ocamllsp = {},
	pylsp = {},
	svelte = {},
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	},
}

for lsp, cfg in pairs(servers) do
	nvim_lsp[lsp].setup(cfg)
end

vim.cmd([[
  augroup _lsp
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.formatting()
  augroup end
]])

-- null-ls

local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		-- formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		-- diagnostics.flake8
	},
})
