vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }

-- disable lazy autoformat
vim.g.autoformat = true

-- line number normal
vim.opt.number = true
vim.opt.relativenumber = false

-- vim-test
vim.cmd([[
  function! TermStrategy(cmd)
    lua require("tmux-awesome-manager").execute_command({ cmd = vim.api.nvim_eval("a:cmd"), name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ": tests", open_as = 'window', focus_when_call = false, visit_first_call = true, orientation = 'horizontal' })
  endfunction
]])

vim.g["test#runner_commands"] = { "RSpec" }
vim.g["test#strategy"] = "mood-term"
vim.cmd("let g:test#custom_strategies = {'mood-term': function('TermStrategy')}")

vim.g["netrw_banner"] = 0

vim.opt.shortmess:append({ W = true, I = true, c = true, A = true }) -- stop asking to edit file (SWP)

vim.o.inccommand = "split"

-- set spell to pt_br
vim.o.spelllang = "pt_br"

vim.opt.guicursor = "n-v-c:block-Cursor,i:block-CursorInsert"

vim.opt.laststatus = 0

vim.api.nvim_set_hl(0, "Statusline", { link = "Normal" })
vim.api.nvim_set_hl(0, "StatuslineNC", { link = "Normal" })

vim.opt.statusline = " "
