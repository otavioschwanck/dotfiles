return {
  { "otavioschwanck/new-file-template.nvim", opts = {}, event = "VeryLazy" },
  {
    "smjonas/live-command.nvim",
    event = "LazyFile",
    config = function()
      require("live-command").setup({
        commands = {
          Norm = { cmd = "norm!" },
          G = { cmd = "g" },
        },
      })
    end,
  },
  {
    "AndrewRadev/undoquit.vim",
    event = "LazyFile",
    keys = {
      { "<leader>wu", "<cmd>norm <C-w>u<CR>", desc = "Undo Window" },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "LazyFile",
    opts = {},
  },
  -- { "otavioschwanck/cool-substitute.nvim", opts = { setup_keybindings = true }, event = "VeryLazy" },
  { "AndrewRadev/bufferize.vim", cmd = "Bufferize", event = "VeryLazy" },
  { "dhruvasagar/vim-table-mode", event = "VeryLazy" },
  {
    "axelvc/template-string.nvim",
    config = function()
      require("template-string").setup({})
    end,
    event = "InsertEnter",
  }, -- automatically add quotes to template string
  { "tpope/vim-eunuch", event = "BufEnter" }, -- Rename, Delete, etc...
  { "michaeljsmith/vim-indent-object", event = "VeryLazy" }, -- vii and vij <3
  {
    "otavioschwanck/ruby-toolkit.nvim",
    -- dir = "~/Projetos/ruby-toolkit.nvim",
    event = "VeryLazy",
  },
  { "tpope/vim-rails", ft = "ruby" },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
    event = "VeryLazy",
  },
  { "AndrewRadev/splitjoin.vim", event = "VeryLazy" },
  { "AndrewRadev/switch.vim", event = "VeryLazy" },
  -- {
  --   "AndrewRadev/sideways.vim",
  --   event = "VeryLazy",
  --   keys = {
  --     { "]a", "<cmd>SidewaysJumpRight<CR>", desc = "Sideways jump right", mode = { "v", "n" } },
  --     { "[a", "<cmd>SidewaysJumpLeft<CR>", desc = "Sideways jump left", mode = { "v", "n" } },
  --   },
  -- },
}
