return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({ size = 120 })

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, height = 100 })

      function _lazygit_toggle()
        lazygit:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>",
        { noremap = true, silent = true, desc = "LazyGit" })
    end
  },
}
