return {
  {
    "mhartington/formatter.nvim",
    event = "BufWritePre",
    keys = {
      { "<leader>cf", "<cmd>Format<cr>", desc = "Format File" },
    },
    config = function()
      require("formatter").setup({
        logging = false,
        filetype = {
          ruby = {
            require("otavioschwanck.formatter-rubocop"),
          },
          javascript = { require("formatter.filetypes.javascript").prettier },
          typescript = { require("formatter.filetypes.typescript").prettier },
          javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
          typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
          lua = { require("formatter.filetypes.lua").stylua },
        },
      })

      local augroup = vim.api.nvim_create_augroup
      local autocmd = vim.api.nvim_create_autocmd

      augroup("__formatter__", { clear = true })
      autocmd("BufWritePost", {
        group = "__formatter__",
        callback = function()
          if not vim.g.disable_formatter then
            vim.cmd("FormatWrite")
          end
        end,
      })
    end,
  },
}
