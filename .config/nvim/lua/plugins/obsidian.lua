return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>sn", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
    { "<leader>bn", "<cmd>ObsidianNew<cr>", desc = "New Note" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/notes/",
      },
    },
  },
}
