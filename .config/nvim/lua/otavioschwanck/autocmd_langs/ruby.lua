local utils = require("otavioschwanck.utils")

require("otavioschwanck.autocmd_langs.base").create_au_for_lang("ruby", function(buf)
  local n = utils.n_buf
  local v = utils.v_buf

  -- Leader root to be quick
  n("<leader>=", ":w | :silent !bundle exec rubocop -A %<CR>:e %<CR>", "Rubocop", buf.buf)
  n("<leader>tc", require("otavioschwanck.rspec").clear_diagnostics, "Clear RSpec diagnostics")
  n("<leader>mc", require("otavioschwanck.lang_helpers.ruby").get_class_name, "Get Class Name", buf.buf)
  n("<leader>mC", require("otavioschwanck.lang_helpers.ruby").search_class_name, "Search Class Name", buf.buf)
  n("<leader>md", require("otavioschwanck.lang_helpers.ruby").comment_rubocop, "Comment Rubocop", buf.buf)
  n("<leader>mf", "<cmd>lua require('ruby-toolkit').create_function_from_text()<CR>", "Create Function", buf.buf)
  n("<leader>d", "<cmd>norm Obinding.pry<CR><cmd>wall<cr>", "Add Debugger", buf.buf)
  n("<leader>D", "<cmd>execute '%s/.*binding.pry\\n//gre'<CR><cmd>wall<cr>", "Clear Debugger", buf.buf)

  n("<leader>a", require("otavioschwanck.lang_helpers.ruby").open_test_alternate, "Go to Test", buf.buf)
  n("<leader>A", require("otavioschwanck.lang_helpers.ruby").open_test_alternate_split, "Go to Test (split)", buf.buf)
  n("<leader>cF", ":w | :silent !bundle exec rubocop -A %<CR>:e %<CR>", "Run Rubocop", buf.buf)

  v("<leader>mf", "<cmd>lua require('ruby-toolkit').extract_to_function()<CR>", "Extract Function", buf.buf)
end)
