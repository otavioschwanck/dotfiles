return {
  {
    "roobert/search-replace.nvim",
    event = "VeryLazy",
    config = function()
      require("search-replace").setup({})

      local opts = {}

      local call_visual_command = function()
        local current_mode = vim.fn.mode()

        if current_mode == "V" or current_mode == "<C-V>" then
          vim.cmd("SearchReplaceWithinVisualSelection")
        else
          vim.cmd("SearchReplaceSingleBufferVisualSelection")
        end
      end

      vim.keymap.set("x", "gq", call_visual_command, opts) -- selecao
      vim.keymap.set("v", "gQ", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", opts)

      vim.api.nvim_set_keymap("n", "gq", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts)
      vim.api.nvim_set_keymap("n", "gQ", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts)
    end,
  },
}
