return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local wk = require("which-key")

      opts.defaults = vim.tbl_extend("force", opts.defaults, {
        ["<leader>cc"] = { name = "+Toggle Case" },
        ["<leader>t"] = { name = "+Test" },
        ["<leader>l"] = { name = "+Tmux" },
        ["<leader>r"] = { name = "+Rails" },
        ["<leader>o"] = { name = "+Open" },
        ["<leader>ob"] = { name = "+Brownie" },
        ["<leader>op"] = { name = "+Prod Consoles" },
        ["<leader>h"] = { name = "+Help" },
      })

      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
