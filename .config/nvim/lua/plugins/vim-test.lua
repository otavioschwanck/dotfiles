return {
  {
    "vim-test/vim-test",
    event = "VeryLazy",
    keys = {
      { "<leader>ts", "<cmd>TestNearest<cr>", desc = "Test nearest" },
      { "<leader>tf", "<cmd>RSpec --only-failures --format documentation<CR>", desc = "Re-run faileds" },
      { "<leader>tv", "<cmd>TestFile<cr>", desc = "Test File" },
      { "<leader>ta", "<cmd>TestSuite<cr>", desc = "Test Suite" },
      { "<leader>tr", "<cmd>TestLast<cr>", desc = "Test Last" },
    },
    -- setup is on lua/config/options.lua:11
  },
}
