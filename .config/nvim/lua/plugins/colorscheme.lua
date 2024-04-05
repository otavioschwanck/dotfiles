return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      flavour = "mocha",
      custom_highlights = function()
        return {
          NormalFloat = { link = "Normal" },
        }
      end,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        telescope = {
          enabled = true,
          style = "nvchad",
        },
      },
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
