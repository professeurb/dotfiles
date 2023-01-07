return {
  { "folke/tokyonight.nvim",
    event = "VeryLazy",
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end
  },
  { "dracula/vim", event = "VeryLazy" },
  { "numToStr/Sakura.nvim", event = "VeryLazy" },
  { "EdenEast/nightfox.nvim", event = "VeryLazy" },
  { "rebelot/kanagawa.nvim", event = "VeryLazy" },
  { "rose-pine/neovim", event = "VeryLazy" },
  { "nyoom-engineering/oxocarbon.nvim", event = "VeryLazy" },
}
