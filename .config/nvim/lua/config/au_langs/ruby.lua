local utils = require("otavioschwanck.utils")

require("config.au_langs.base").create_au_for_lang("ruby", function(buf)
  local n = utils.n_buf
  local v = utils.v_buf

  n("<leader>mc", require("otavioschwanck.ruby").get_class_name, "Get Class Name", buf.buf)
  n("<leader>mC", require("otavioschwanck.ruby").search_class_name, "Search Class Name", buf.buf)
  n("<leader>md", require("otavioschwanck.ruby").comment_rubocop, "Comment Rubocop", buf.buf)
  n("<leader>mf", "<cmd>lua require('ruby-toolkit').create_function_from_text()<CR>", "Create Function", buf.buf)
  n("<leader>d", "<cmd>norm Obinding.pry<CR><cmd>wall<cr>", "Add Debugger", buf.buf)
  n("<leader>D", "<cmd>execute '%s/.*binding.pry\\n//gre'<CR><cmd>wall<cr>", "Clear Debugger", buf.buf)

  n("<leader>a", require("otavioschwanck.ruby").open_test_alternate, "Create Function", buf.buf)
  n("<leader>A", require("otavioschwanck.ruby").open_test_alternate_split, "Create Function", buf.buf)
  n("<leader>cF", ":w | :silent !bundle exec rubocop -A %<CR>:e %<CR>", "Run Rubocop", buf.buf)

  v("<leader>mf", "<cmd>lua require('ruby-toolkit').extract_to_function()<CR>", "Extract Function", buf.buf)
end)
