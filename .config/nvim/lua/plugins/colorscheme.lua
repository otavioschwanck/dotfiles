return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      flavour = "macchiato",
      transparent_background = true,
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.g.gruvbox_material_background = "soft"

      -- create autocmd for colorscheme
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "NormalFloat", { link = "NormalNC" })
          vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89bf82" })
          vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#7daea3", bg = "#282828" })
          vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#d4be98", bg = "#0f3a42" })
          vim.api.nvim_set_hl(0, "@string.special.symbol", { fg = "#e78a4e" })
        end,
      })

      -- vim.g.gruvbox_material_transparent_background = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
    keys = {
      { "<leader>ol", "<cmd>Lazy<cr>", desc = "Lazy" },
    },
  },
}
