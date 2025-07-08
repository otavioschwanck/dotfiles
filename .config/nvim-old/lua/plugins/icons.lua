return {
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {
          rb = { icon = "", color = "#ff8587", name = "DevIconRb" },
          rake = { icon = "", color = "#ff8587", name = "DevIconRb" },
        }
      })
    end,
  },
}
