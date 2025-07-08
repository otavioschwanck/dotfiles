return {
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", desc = "Diff view" },
      { "<leader>qd", "<cmd>DiffviewClose<cr><cmd>cclose<CR>", desc = "Diff view" },
    },
  },
}
