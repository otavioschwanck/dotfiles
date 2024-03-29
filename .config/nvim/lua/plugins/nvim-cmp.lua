return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-calc" },
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping.select_next_item({ select = true }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ select = true }),
        ["<CR>"] = cmp.mapping.confirm(),
        ["<C-e>"] = cmp.mapping.abort(),
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
      })

      local buffer = {
        name = "buffer",
        option = { get_bufnrs = require("otavioschwanck.cmp").get_valid_bufs },
        keyword_length = 2,
      }

      opts.sources = {
        { keyword_length = 2, name = "nvim_lsp" },
        buffer,
        { name = "luasnip", keyword_length = 2 },
        { name = "calc" },
        { name = "path" },
      }
    end,
  },
}
