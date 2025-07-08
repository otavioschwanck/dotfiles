return {
  {
    "otavioschwanck/telescope-alternate.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>fa",
        "<cmd>lua require('telescope-alternate.telescope').alternate()<CR>",
        desc = "Alternate Files",
      },
    },
    config = function()
      require("telescope-alternate").setup({
        mappings = {
          {
            pattern = "app/services/(.*)_services/(.*).rb",
            targets = {
              { template = "app/contracts/[1]_contracts/[2].rb", label = "Contract" },
            },
          },
          { "app/contracts/(.*)_contracts/(.*).rb", { { "app/services/[1]_services/[2].rb", "Service" } } },
          {
            "src/(.*)/service(.*)/(.*).service.ts",
            {
              { "src/[1]/controller*/*.controller.ts", "Controller", true },
              { "src/[1]/dto/*",                       "DTO",        true },
            },
          },
          {
            "src/(.*)/controller(.*)/(.*).controller.ts",
            {
              { "src/[1]/service*/*.service.ts", "Service", true },
              { "src/[1]/dto/*",                 "DTO",     true },
            },
          },
          {
            "src/(.*)/dto(.*)/(.*)",
            {
              { "src/[1]/service*/*.service.ts",       "Service",    true },
              { "src/[1]/controller*/*.controller.ts", "Controller", true },
            },
          },
          {
            "(.*)/(.*).tsx",
            {
              { "[1]/[2].module.scss", "SCSS", true },
            },
          },
          {
            "(.*)/(.*)/index.ts(.*)",
            {
              { "[1]/[2]/[2].tsx", "TypeScript", true },
            },
          },
          {
            "(.*)/(.*).module.scss",
            {
              { "[1]/[2].tsx", "TypeScript", false },
            },
          },
        },
      })

      -- require("telescope").load_extension("telescope-alternate")
    end,
  },
}
