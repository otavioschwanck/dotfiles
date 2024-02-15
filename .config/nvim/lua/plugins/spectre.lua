return {
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    keys = {
      {
        "<leader>sR",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
        remap = true,
      },
    },
  },
}
