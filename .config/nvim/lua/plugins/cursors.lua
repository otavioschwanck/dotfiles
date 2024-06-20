return {
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged joao
    opts = {}, -- This causes the plugin setup function to be called
    keys = {
      { "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "x" }, desc = "Add cursor and move down" },
      { "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" }, desc = "Add cursor and move up" },

      { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move down" },

      { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" }, desc = "Add or remove cursor" },

      { "<Leader>d", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
      {
        "<Leader>D",
        "<Cmd>MultipleCursorsAddMatchesV<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword in previous area",
      },

      {
        "<C-n>",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword",
      },
      { "<Leader>Y", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },

      { "<Leader>U", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
    },
  },
}
