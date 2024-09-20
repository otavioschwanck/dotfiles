return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "VeryLazy",
    config = function()
      local mason_langs = {
        "lua_ls",
        "jsonls",
        "solidity",
        "yamlls",
        "jsonls",
      }

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = { exclude = { "solargraph", "rubocop" } }, -- don't install it please
        ensure_installed = mason_langs,
      })

      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, lang in ipairs(mason_langs) do
        lspconfig[lang].setup({ capabilities = lsp_capabilities })
      end

      lspconfig.ts_ls.setup({
        capabilities = lsp_capabilities,
      })

      lspconfig.solidity.setup({
        capabilities = lsp_capabilities,
        settings = {
          solidity = {
            includePath = "",
            remapping = { ["@OpenZeppelin/"] = "dependencies/OpenZeppelin/openzeppelin-contracts@4.6.0/" },
          },
        },
      })

      lspconfig.solargraph.setup({
        capabilities = lsp_capabilities,
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
        end,
        settings = {
          solargraph = {
            formatting = false,
            autoformat = false,
            useBundler = true,
            diagnostics = false,
          },
        },
      })

      lspconfig.rubocop.setup({
        capabilities = lsp_capabilities,
        cmd = { "bundle", "exec", "rubocop", "--lsp" },
      })

      local border_opts = {
        border = { { "╭" }, { "─" }, { "╮" }, { "│" }, { "╯" }, { "─" }, { "╰" }, { "│" } },
        scrollbar = false,
      }

      vim.diagnostic.config({
        float = border_opts,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          local telescope = require("telescope.builtin")

          -- Displays hover information about the symbol under the cursor
          bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")

          -- Jump to the definition
          bufmap("n", "gd", telescope.lsp_definitions)

          -- Jump to declaration
          bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")

          -- Lists all the implementations for the symbol under the cursor
          bufmap("n", "gI", telescope.lsp_implementations)

          -- Jumps to the definition of the type symbol
          bufmap("n", "gT", telescope.lsp_type_definitions)

          -- Lists all the references
          bufmap("n", "gr", telescope.lsp_references)

          -- Displays a function's signature information
          bufmap("n", "gK", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

          -- Renames all references to the symbol under the cursor
          bufmap("n", "<gr>", "<cmd>lua vim.lsp.buf.rename()<cr>")

          -- Selects a code action available at the current cursor position
          bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>")

          -- Show diagnostics in a floating window
          bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
        end,
      })
    end,
  },
}
