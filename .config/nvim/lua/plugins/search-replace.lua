return {
  {
    "roobert/search-replace.nvim",
    event = "VeryLazy",
    config = function()
      require("search-replace").setup({})

      local opts = {}

      vim.api.nvim_set_keymap("v", "gq", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts)
      vim.api.nvim_set_keymap("v", "gQ", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", opts)

      vim.api.nvim_set_keymap("n", "gq", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts)
      vim.api.nvim_set_keymap("n", "gQ", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts)
    end,
  },
}
