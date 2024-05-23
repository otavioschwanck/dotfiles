return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    config = function()
      vim.o.laststatus = vim.g.lualine_laststatus

      local theme = require("lualine.themes.catppuccin-mocha")
      local catppuccin_colors = require("catppuccin.palettes").get_palette()

      theme.normal.c.bg = catppuccin_colors.base
      theme.inactive.c.bg = catppuccin_colors.base
      theme.inactive.a.bg = catppuccin_colors.base

      local open_terms = {
        require("tmux-awesome-manager.src.integrations.status").open_terms,
        color = { fg = catppuccin_colors.green },
      }

      require("lualine").setup({
        options = {
          disabled_filetypes = {
            statusline = { "dashboard" },
          },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          theme = theme,
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {},
          lualine_c = { "diagnostics", "diff" },
          lualine_x = { open_terms, "branch" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = { "filename" },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}
