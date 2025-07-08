return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Open Tree" },
    { "<leader>E", "<cmd>Neotree %<cr>", desc = "Open Cur File on Tree" },
  },
  opts = {
    follow_current_file = {
      enabled = false,
    },
  },
}
