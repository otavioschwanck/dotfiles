return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = 3
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

      theme.normal.b.bg = catppuccin_colors.surface1
      theme.normal.c.bg = catppuccin_colors.surface0
      theme.inactive.c.bg = catppuccin_colors.bg

      local open_terms = {
        require("tmux-awesome-manager.src.integrations.status").open_terms,
        color = { fg = catppuccin_colors.green },
      }

      local function arrow()
        local status = require("arrow.statusline").text_for_statusline_with_icons()

        return status
      end

      local arrow_module = {
        arrow,
        color = { fg = catppuccin_colors.pink },
      }

      require("lualine").setup({
        options = {
          disabled_filetypes = {
            statusline = { "dashboard" },
          },
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' },
          theme = theme,
          globalstatus = false,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filename", arrow_module },
          lualine_c = { "diagnostics", "diff" },
          lualine_x = { open_terms, "branch" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename', arrow },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
      })
    end,
  },
}
