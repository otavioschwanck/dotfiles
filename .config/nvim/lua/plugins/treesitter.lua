return {

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ruby",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "solidity",
        "yaml",
        "json",
        "lua",
        "vim",
        "query",
        "embedded_template",
        "bash",
        "tsx",
      })

      opts.indent = { enable = true, disable = { "ruby", "python" } }

      opts.textobjects = vim.tbl_deep_extend("force", opts.textobjects, {
        swap = {
          enable = true,
          swap_next = {
            ["g]f"] = "@function.outer",
          },
          swap_previous = {
            ["g[f"] = "@function.outer",
          },
        },
      })

      opts.endwise = { enable = true }
    end,
  },
}
