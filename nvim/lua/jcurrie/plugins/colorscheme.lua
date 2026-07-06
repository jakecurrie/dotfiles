return {
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 900,
    keys = {
      { "<leader>ut", "<cmd>Themery<cr>", desc = "Switch Theme" },
    },
    opts = {
      themes = {
        {
          name = "Kanagawa Paper Ink",
          colorscheme = "kanagawa-paper-ink",
        },
        {
          name = "Everforest",
          colorscheme = "everforest",
        },
        {
          name = "Tokyo Night",
          colorscheme = "tokyonight-night",
        },
        {
          name = "Rose Pine",
          colorscheme = "rose-pine-main",
        },
      },
      livePreview = true,
    },
  },
}
