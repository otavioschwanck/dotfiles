return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
    keys = {
      { "<leader>ol", "<cmd>Lazy<cr>", desc = "Lazy" },
    },
  },
}
