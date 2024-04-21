return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local theme = require("lualine.themes.catppuccin-mocha")
      local catppuccin_colors = require("catppuccin.palettes").get_palette()

      theme.normal.c.bg = catppuccin_colors.base
      theme.inactive.c.bg = catppuccin_colors.base
      theme.inactive.a.bg = catppuccin_colors.base

      local open_terms = {
        require("tmux-awesome-manager.src.integrations.status").open_terms,
        color = { fg = "#89b482" },
      }

      local arrow = function(props)
        local bufnr = props.buf
        return require("arrow.statusline").text_for_statusline_with_icons(bufnr)
      end

      require("lualine").setup({
        options = {
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          theme = theme,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filename", { arrow } },
          lualine_c = { "diagnostics", "diff" },
          lualine_x = { open_terms, "branch" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = { "filename", arrow },
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
