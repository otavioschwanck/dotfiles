return {
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gT", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "LazyGit Current File" },
    },
  },
}
