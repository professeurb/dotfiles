local d = {
  { "williamboman/mason.nvim", cmd = "Mason", config = true },
  { "williamboman/mason-lspconfig.nvim", dependencies = "williamboman/mason.nvim",
    config = {
      automatic_installation = true,
      ensure_installed = {
        "texlab", "tailwindcss", "ocamllsp", "pylsp", "svelte", "sumneko_lua"
      }
    }
  },
  { "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup {
        debug = false,
        sources = {
          null_ls.builtins.formatting.prettier.with {
            extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            filetypes = { "astro", "css", "javascript", "djangohtml", "html", "json", "yaml", "markdown", "svelte" },
          },
          -- formatting.black.with({ extra_args = { "--fast" } }),
          -- formatting.stylua,
          -- diagnostics.flake8
        },
      }
    end
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
