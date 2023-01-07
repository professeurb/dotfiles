return {
  { 'simrat39/symbols-outline.nvim',
    cmd = "SymbolsOutline",
    config = true
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = { { '<leader>e', '<cmd>Neotree toggle<cr>', desc = "Neotree" } },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = true
  },
  { 'lukas-reineke/indent-blankline.nvim',
    event = "BufReadPre",
    config = {
      char = '┊',
      show_trailing_blankline_indent = false,
    }
  },
  { 'kevinhwang91/nvim-ufo',
    enabled = false,
    event = "BufReadPre",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'kevinhwang91/promise-async' },
    config = function()
      vim.cmd [[ autocmd BufReadPost,FileReadPost * normal zR ]]
      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
      }
    end
  },
  { 'code-biscuits/nvim-biscuits',
    event = "BufReadPre",
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true
  },
  { 'ThePrimeagen/vim-be-good', cmd = "VimBeGood" }
}
