return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-calc",
  },
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    local buffer = {
      name = "buffer",
      option = { get_bufnrs = require("otavioschwanck.cmp").get_valid_bufs },
      keyword_length = 2,
    }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item({ select = true }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ select = true }),
        ["<CR>"] = cmp.mapping.confirm(),
        ["<C-e>"] = cmp.mapping.complete(),
        ["<C-N>"] = cmp.mapping(function(_)
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump(1)
          end
        end, { "i", "s" }),
        ["<C-P>"] = cmp.mapping(function(_)
          if luasnip.locally_jumpable() then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
        ["<BS>"] = cmp.mapping(function(_)
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Del>", true, true, true), "x")
          luasnip.jump(1)
        end, { "s" }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
      },
      sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        buffer,
        { name = "calc" },
      },
    })
  end,
}
