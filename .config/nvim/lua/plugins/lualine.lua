return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.theme = "gruvbox-material"

      table.insert(opts.sections.lualine_x, 1, {
        function()
          if vim.g.disable_formatter then
            return "Auto Format Disabled"
          end

          return ""
        end,
        color = { fg = "#e55561" },
      })

      table.insert(opts.sections.lualine_c, 20, {
        function()
          return require("arrow.statusline").text_for_statusline_with_icons()
        end,
        color = { fg = "#a6e3a1" },
      })

      table.insert(opts.sections.lualine_x, 2, {
        require("tmux-awesome-manager.src.integrations.status").open_terms,
        color = { fg = "#a6e3a1" },
      })

      table.insert(opts.sections.lualine_c, 300, {
        function()
          local alternate_filename = vim.fn.expand("#:t")
          if alternate_filename == "" then
            return ""
          else
            return " " .. alternate_filename
          end
        end,
        color = { fg = "#f9e2af" },
      })
    end,
  },
}
