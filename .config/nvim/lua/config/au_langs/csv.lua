local utils = require("otavioschwanck.utils")

require("config.au_langs.base").create_au_for_lang("csv", function(buf)
  local n = utils.n_buf

  n("<leader>m;", "<cmd>set filetype=csv_semicolon<CR>", "Set Delimiter to ;", buf.buf)
  n("<leader>m|", "<cmd>set filetype=csv_pipe<CR>", "Set delimiter to |", buf.buf)
  n("<leader>ma", "<cmd>RainbowAlign<CR>", "Align", buf.buf)
  n("<leader>ms", "<cmd>RainbowShrink<CR>", "Shrink", buf.buf)
  n("<leader>ml", "<cmd>RainbowLint<CR>", "Lint", buf.buf)

  vim.cmd("set filetype=csv_semicolon")
end)
