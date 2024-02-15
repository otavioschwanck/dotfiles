return {
  {
    "gbprod/yanky.nvim",
    dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
    opts = {
      preserve_cursor_position = {
        enabled = true,
      },
      highlight = { timer = 250 },
      ring = {
        history_length = 50,
        storage = "shada",
        sync_with_numbered_registers = true,
      },
    },
    keys = {
      -- stylua: ignore
      { "<leader>p", function() require("telescope").extensions.yank_history.yank_history({}) end, desc = "Open Yank History" },

      {
        "y",
        "<Plug>(YankyYank)",
        mode = { "n", "x" },
        desc = "Yank text",
      },
      {
        "p",
        "<Plug>(YankyPutAfter)",
        mode = { "n", "x" },
        desc = "Put yanked text after cursor",
      },
      {
        "P",
        "<Plug>(YankyPutBefore)",
        mode = { "n", "x" },
        desc = "Put yanked text before cursor",
      },
      {
        "<C-p>",
        "<Plug>(YankyCycleForward)",
        desc = "Cycle forward through yank history",
      },
      {
        "<C-n>",
        "<Plug>(YankyCycleBackward)",
        desc = "Cycle backward through yank history",
      },
      {
        "]p",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put indented after cursor (linewise)",
      },
      {
        "[p",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put indented before cursor (linewise)",
      },
      {
        "]P",
        "<Plug>(YankyPutIndentAfterLinewise)",
        desc = "Put indented after cursor (linewise)",
      },
      {
        "[P",
        "<Plug>(YankyPutIndentBeforeLinewise)",
        desc = "Put indented before cursor (linewise)",
      },
      {
        ">p",
        "<Plug>(YankyPutIndentAfterShiftRight)",
        desc = "Put and indent right",
      },
      {
        "<p",
        "<Plug>(YankyPutIndentAfterShiftLeft)",
        desc = "Put and indent left",
      },
      {
        ">P",
        "<Plug>(YankyPutIndentBeforeShiftRight)",
        desc = "Put before and indent right",
      },
      {
        "<P",
        "<Plug>(YankyPutIndentBeforeShiftLeft)",
        desc = "Put before and indent left",
      },
      {
        "=p",
        "<Plug>(YankyPutAfterFilter)",
        desc = "Put after applying a filter",
      },
      {
        "=P",
        "<Plug>(YankyPutBeforeFilter)",
        desc = "Put before applying a filter",
      },
    },
  },
}
