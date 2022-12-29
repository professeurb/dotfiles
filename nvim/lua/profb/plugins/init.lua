return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree", 
  keys ={ { '<leader>e', '<cmd>Neotree toggle<cr>', desc = "Neotree"}},
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = true
}

