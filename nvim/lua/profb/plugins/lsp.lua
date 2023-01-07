return {
  { "williamboman/mason.nvim", cmd = "Mason", config = true },
  { "williamboman/mason-lspconfig.nvim", dependencies = "williamboman/mason.nvim",
    config = {
      automatic_installation = true,
      ensure_installed = {
        "texlab", "tailwindcss", "ocamllsp", "pylsp", "svelte", "sumneko_lua"
      }
    }
  },
  { "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim", config = true },
      { 'j-hui/fidget.nvim', config = true },
      { "williamboman/mason-lspconfig.nvim" }
    },
    config = function()
      local lspconfig = require("lspconfig")
      local servers = {
        texlab = {
          auxDirectory = ".",
          bibtexFormatter = "texlab",
          latexFormatter = "latexindent",
          latexindent = { modifyLineBreaks = false },
        },
        ocamllsp = { cmd = { "ocamllsp", "--fallback-read-dot-merlin" } },
        pylsp = {},
        svelte = {},
        sumneko_lua = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        rust_analyzer = {}
      }

      for lsp, cfg in pairs(servers) do
        lspconfig[lsp].setup(cfg)
      end

      vim.cmd [[
  augroup _lsp
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.format({ async = false })
  augroup end
]]
    end
  },
}
