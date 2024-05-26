local M = {}

function M.set()
  local opt = vim.opt

  opt.autowrite = true -- Enable auto write
  opt.clipboard = "unnamedplus" -- Sync with system clipboard
  opt.completeopt = "menu,menuone,noselect"
  opt.conceallevel = 2 -- Hide * markup for bold and italic
  opt.confirm = true -- Confirm to save changes before exiting modified buffer
  opt.cursorline = true -- Enable highlighting of the current line
  opt.expandtab = true -- Use spaces instead of tabs
  opt.formatoptions = "jcroqlnt" -- tcqj
  opt.grepformat = "%f:%l:%c:%m"
  opt.grepprg = "rg --vimgrep"
  opt.ignorecase = true -- Ignore case
  opt.inccommand = "nosplit" -- preview incremental substitute
  opt.list = true -- Show some invisible characters (tabs...
  opt.mouse = "a" -- Enable mouse mode
  opt.number = true -- Print line number
  opt.pumblend = 10 -- Popup blend
  opt.pumheight = 10 -- Maximum number of entries in a popup
  opt.scrolloff = 4 -- Lines of context
  opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "globals" }
  opt.shiftround = true -- Round indent
  opt.shiftwidth = 2 -- Size of an indent
  opt.shortmess:append({ W = true, I = true, c = true, A = true })
  opt.sidescrolloff = 8 -- Columns of context
  opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
  opt.smartcase = true -- Don't ignore case with capitals
  opt.smartindent = true -- Insert indents automatically
  opt.spelllang = { "en" }
  opt.splitbelow = true -- Put new windows below current
  opt.splitright = true -- Put new windows right of current
  opt.tabstop = 2 -- Number of spaces tabs count for
  opt.termguicolors = true -- True color support
  opt.timeoutlen = 300
  opt.undofile = true
  opt.undolevels = 10000
  opt.updatetime = 200 -- Save swap file and trigger CursorHold
  opt.wildmode = "longest:full,full" -- Command-line completion mode
  opt.winminwidth = 5 -- Minimum window width
  opt.wrap = false -- Disable line wrap
  opt.pumblend = 0
  vim.o.spelllang = "pt_br"

  opt.splitkeep = "cursor"

  if vim.fn.has("nvim-0.9.0") == 1 then
    opt.shortmess:append({ C = true })
  end

  -- vim-test
  vim.cmd([[
    function! TermStrategy(cmd)
      if a:cmd =~ 'rspec'
        if filereadable("/tmp/quickfix.out")
          call delete("/tmp/quickfix.out")
        endif

        lua require("otavioschwanck.rspec").clear_diagnostics()
        lua require("otavioschwanck.rspec").wait_quickfix_to_insert_diagnostics()
        lua require("tmux-awesome-manager").execute_command({ cmd = vim.api.nvim_eval("a:cmd"), name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ": tests", open_as = 'pane', focus_when_call = false, size = '35%', visit_first_call = false, visit_first_call = true, orientation = 'horizontal' })
      else
        lua require("tmux-awesome-manager").execute_command({ cmd = vim.api.nvim_eval("a:cmd"), name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. ": tests", open_as = 'window', focus_when_call = false, visit_first_call = true, orientation = 'horizontal' })
      endif
    endfunction
  ]])

  vim.g["test#runner_commands"] = { "RSpec" }
  vim.g["test#strategy"] = "mood-term"

  local neovim_file_path = vim.fn.stdpath("config")

  local full_command = "--require="
    .. neovim_file_path
    .. "/helpers/vim_formatter.rb --format VimFormatter --out /tmp/quickfix.out  --format progress"

  vim.cmd("let test#ruby#rspec#options = { 'file': '" .. full_command .. "', 'nearest': '" .. full_command .. "' }")

  vim.cmd("let g:test#custom_strategies = {'mood-term': function('TermStrategy')}")

  vim.opt.guicursor = "n-v-c:block-Cursor,i:block-CursorInsert"

  -- Fix markdown indentation settings
  vim.g.markdown_recommended_style = 0

  vim.o.winbar = "%{%v:lua.require'otavioschwanck.winbar'.eval()%}"

  vim.g.format_on_save = true
end

return M
