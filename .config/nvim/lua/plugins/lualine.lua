return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, {
        function()
          if vim.g.disable_formatter then
            return "Auto Format Disabled"
          end

          return ""
        end,
        color = { fg = "#e55561" },
      })

      table.insert(opts.sections.lualine_c, 2, {
        function()
          return require("arrow.statusline").text_for_statusline_with_icons()
        end,
        color = { fg = "#98c379" },
      })

      table.insert(opts.sections.lualine_x, 2, {
        require("tmux-awesome-manager.src.integrations.status").open_terms,
        color = { fg = "#98c379" },
      })

      table.insert(opts.sections.lualine_x, 1, {
        function()
          local alternate_filename = vim.fn.expand("#:t")
          if alternate_filename == "" then
            return ""
          else
            return "Alt: " .. alternate_filename
          end
        end,
        color = { fg = "d19a66" },
      })

      -- table.insert(opts.sections.lualine_c, 4, {
      --   function()
      --     return require("cool-substitute.status").status_with_icons()
      --   end,
      --   color = function()
      --     return { fg = require("cool-substitute.status").status_color() }
      --   end,
      -- })
    end,
  },
}
