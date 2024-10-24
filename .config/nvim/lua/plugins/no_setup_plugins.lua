return {
  { "folke/neodev.nvim",             opts = {},                                  event = "VeryLazy" },
  { "tpope/vim-rails",               event = "VeryLazy" },
  { "echasnovski/mini.comment",      event = "VeryLazy",                         opts = {} },
  { "beloglazov/vim-textobj-quotes", dependencies = { "kana/vim-textobj-user" }, event = "VeryLazy" },
  {
    "sQVe/sort.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { "otavioschwanck/new-file-template.nvim", opts = {},         event = "VeryLazy" },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  { "AndrewRadev/bufferize.vim",             cmd = "Bufferize", event = "VeryLazy" },
  { "dhruvasagar/vim-table-mode",            event = "VeryLazy" },
  {
    "axelvc/template-string.nvim",
    config = function()
      require("template-string").setup({})
    end,
    event = "InsertEnter",
  },
  { "tpope/vim-eunuch",                event = "BufEnter" }, -- Rename, Delete, etc...
  { "michaeljsmith/vim-indent-object", event = "VeryLazy" }, -- vii and vij <3
  { "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
  {
    "otavioschwanck/ruby-toolkit.nvim",
    event = "VeryLazy",
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
    event = "VeryLazy",
  },
  { "AndrewRadev/splitjoin.vim", event = "VeryLazy" },
  { "AndrewRadev/switch.vim",    event = "VeryLazy" },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      { "<leader>gB", "<cmd>Git blame<cr>", desc = "Git Blame" },
    },
  },
  {
    "AndrewRadev/sideways.vim",
    event = "VeryLazy",
    keys = {
      { "]a",  "<cmd>SidewaysJumpRight<CR>",         desc = "Sideways jump right", mode = { "v", "n" } },
      { "[a",  "<cmd>SidewaysJumpLeft<CR>",          desc = "Sideways jump left",  mode = { "v", "n" } },
      { "g]a", "<cmd>SidewaysRight<CR>",             desc = "Sideways right",      mode = { "v", "n" } },
      { "g[a", "<cmd>SidewaysLeft<CR>",              desc = "Sideways left",       mode = { "v", "n" } },
      { "aa",  "<Plug>SidewaysArgumentTextobjA<CR>", desc = "Sideways left",       mode = { "o", "x" } },
      { "ia",  "<Plug>SidewaysArgumentTextobjI<CR>", desc = "Sideways left",       mode = { "o", "x" } },
    },
  },
  { "mg979/vim-visual-multi" }
}
