return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function()
      require("catppuccin").setup({
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
      })
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
