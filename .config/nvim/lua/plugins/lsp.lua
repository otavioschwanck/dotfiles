---@diagnostic disable: missing-fields
return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    ---@diagnostic disable-next-line: missing-fields
    servers = {
      tsserver = {
        mason = false, -- i prefer to install outside
      },
      -- rubocop = {
      --   mason = false,
      --   cmd = { "bundle", "exec", "rubocop", "--lsp" },
      -- },
      solargraph = {
        mason = false,
        settings = {
          solargraph = {
            formatting = false, -- using at formatter.lua
            useBundler = true,
            diagnostics = true,
          },
        },
      },
      -- ruby_ls = {},
      solidity = {
        settings = {
          solidity = {
            includePath = "",
            remapping = { ["@OpenZeppelin/"] = "dependencies/OpenZeppelin/openzeppelin-contracts@4.6.0/" },
          },
        },
      },
    },
  },
}
