return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function()
      local wk = require("which-key")

      local defaults = {
        ["<leader>cc"] = { name = "+Toggle Case" },
        ["<leader>t"] = { name = "+Test" },
        ["<leader>l"] = { name = "+Tmux" },
        ["<leader>r"] = { name = "+Rails" },
        ["<leader>o"] = { name = "+Open" },
        ["<leader>ob"] = { name = "+Brownie" },
        ["<leader>op"] = { name = "+Prod Consoles" },
        ["<leader>h"] = { name = "+Help" },
        ["<leader>w"] = { name = "+Window" },
        ["<leader>b"] = { name = "+Buffer" },
        ["<leader>c"] = { name = "+Code" },
        ["<leader>f"] = { name = "+File" },
        ["<leader>g"] = { name = "+Git" },
        ["<leader>q"] = { name = "+Quit/Close" },
        ["<leader>s"] = { name = "+Search" },
      }

      wk.setup({})
      wk.register(defaults)
    end,
  },
}
