return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      format_on_save = {
        timeout_ms = 5000,
        quiet = true,
        async = false,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        javascriptscript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
    },
  },
}
