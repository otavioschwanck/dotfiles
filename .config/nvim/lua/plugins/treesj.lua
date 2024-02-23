return {
  {
    "Wansmer/treesj",
    requires = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    keys = { { "gs", "<cmd>TSJToggle<cr>", desc = "Toggle treesj" } },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
        max_join_length = 600,
      })
    end,
  },
}
