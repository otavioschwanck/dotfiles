return {
  {
    dependencies = {
      "mihyaeru21/nvim-ruby-lsp",
      opts = {},
    },
    init = function()
      require("lazyvim.util").lsp.on_attach(function(client)
        if client.name == "rubocop" then
          client.server_capabilities.documentFormattingProvider = true
        elseif client.name == "solargraph" then
          client.server_capabilities.documentFormattingProvider = false
        end
      end)
    end,
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      ---@diagnostic disable-next-line: missing-fields
      servers = {
        tsserver = {
          mason = false,
        },
        rubocop = {
          mason = false,
          cmd = { "bundle", "exec", "rubocop", "--lsp" },
        },
        solargraph = {
          mason = false,
          settings = {
            solargraph = {
              formatting = false,
              useBundler = true,
              diagnostics = false,
            },
          },
        },
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
  },
}
