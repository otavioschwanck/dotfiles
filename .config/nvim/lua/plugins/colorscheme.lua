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
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
      highlight_groups = {
        Cursor = { bg = "#eb6f92", fg = "reverse" },
        CursorInsert = { bg = "#3e8fb0", fg = "reverse" },
      },
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_disable_italic_comment = 1

      -- create autocmd for colorscheme
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          vim.api.nvim_set_hl(0, "NormalFloat", { link = "NormalNC" })
          vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89bf82" })
          vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#80aa9e", bg = "#282828" })
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
      colorscheme = "rose-pine",
    },
    keys = {
      { "<leader>ol", "<cmd>Lazy<cr>", desc = "Lazy" },
    },
  },
}
