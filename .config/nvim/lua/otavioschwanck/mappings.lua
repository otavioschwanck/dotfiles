local M = {}

function M.set()
  local file_management = require("otavioschwanck.file-management")
  local utils = require("otavioschwanck.utils")
  local ff = require("otavioschwanck.lang_helpers.ruby").find_in_folder

  local n = utils.n
  local c = utils.c
  local v = utils.v
  local nv = utils.nv
  local x = utils.x

  x("<", "<gv")
  x(">", ">gv")

  n("x", '"_x')
  n("<leader>qq", "<cmd>qall<CR>")
  n("<Esc>", ":noh<CR><esc>")

  -- Command Mode Mappings
  c("<C-h>", "<Left>")
  c("<C-k>", "<S-right>")
  c("<C-j>", "<S-left>")
  c("<C-l>", "<Right>")
  c("<C-a>", "<Home>")
  c("<C-e>", "<End>")
  c("<C-d>", "<Del>")

  -- Basic Editor Stuff
  n("\\", "<cmd>wall<CR>")
  nv("-", "$")
  n(",", "<C-w>w")
  n("<C-w>,", "<C-w>W", {})
  n("<C-w>;", "<C-w>w", {})
  n("<C-e>", "<cmd>b#<CR>")
  n("ge", "<cmd>b#<CR>")
  -- nv("M", "m")

  v("J", ":m '>+1<CR>gv=gv")
  v("K", ":m '<-2<CR>gv=gv")
  n("yb", ":%y+<CR>")

  -- Leader Mappings
  -- t
  n("<leader>to", "<cmd>cg /tmp/quickfix.out<CR><cmd>copen<CR><cmd>cfirst<CR>", "Open Quickfix Output")

  -- f
  n("<leader>fC", file_management.better_copy, "Copy")
  n("<leader>fM", file_management.better_move, "Move")
  n("<leader>fd", file_management.better_delete, "Delete")
  n("<leader>fD", function()
    file_management.better_delete(true)
  end, "Delete")
  n("<leader>fR", file_management.better_rename, "Rename")
  n("<leader>fy", file_management.copy_relative_path, "Copy Filename")
  n("<leader>fl", file_management.copy_relative_path_with_line, "Copy Filename With Line")
  n("<leader>fY", file_management.copy_full_path, "Copy Filename With Line")
  n("<leader>fp", require("otavioschwanck.dotfiles").open_dotfiles, "Open Dotfiles")
  n("]q", "<cmd>cnext<CR>zz")
  n("[q", "<cmd>cprev<CR>zz")

  -- r
  n("<leader>rm", ff("app/models", "Find Model"), "Find Model")
  n("<leader>rq", ff("app/contracts", "Find Contracts"), "Find Model")
  n("<leader>rz", ff("app/serializers", "Find Serialiazers"), "Find Contracts")
  n("<leader>rc", ff("app/controllers", "Find Controller"), "Find Serialiazers")
  n("<leader>rv", ff("app/views", "Find View"), "Find Controller")
  n("<leader>ra", ff("config/locales", "Find Locales"), "Find View")
  n("<leader>ru", ff("spec/factories", "Find Factories"), "Find Locales")
  n("<leader>rs", ff("app/services", "Find Services"), "Find Factories")
  n("<leader>rS", ff("app/business", "Find Business"), "Find Services")
  n("<leader>rn", ff("db/migrate", "Find Migration"), "Find Business")
  n("<leader>ro", ff("app/avo/resources/", "Find Avo Resource"), "Find Migration")
  n("<leader>rj", ff("app/jobs", "Find Jobs"), "Find Migration")

  n("<leader>rI", require("otavioschwanck.lang_helpers.ruby").reset_rails_db, "Find Migration")
  n("<leader>rK", require("otavioschwanck.lang_helpers.ruby").kill_ruby_instances, "Find Migration")

  -- h
  n("<leader>hD", ":!rm -rf ~/.local/share/nvim/swap/*<CR>", "Delete SWP files")
  n("<leader>hr", require("otavioschwanck.lsp").restart_lsp, "Restart LSP")

  -- w
  n("<leader>wq", "<C-w>q", "Kill Window")
  n("<leader>wj", "<C-w>j", "Move Down")
  n("<leader>wk", "<C-w>k", "Move Up")
  n("<leader>wh", "<C-w>h", "Move Left")
  n("<leader>wl", "<C-w>l", "Move Right")
  n("<leader>wo", "<C-w>o", "Close Others")

  vim.cmd([[
    nnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"
    vnoremap <expr> 0 (col('.') - 1) == match(getline('.'),'\S') ? "<Home>" : "^"

    nmap viq vaqloho
    nmap vq viq
    nmap dq diq
    nmap yq yiq
    nmap cq ciq
    nmap vij vaI
    nmap vai vaI
    nmap vaj vaIj
    nmap dij daI
    nmap daI daI
    nmap daj vaIjd
    nmap cij caI
    nmap caj vaI
    nmap cai caI
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

    xnoremap <silent><expr> I mode() ==# "V" ? "<C-v>$^I" : "I"
    xnoremap <silent><expr> A mode() ==# "V" ? "<C-v>$A" : "A"
    xnoremap <silent><expr> i mode() ==# "V" ? "<C-v>$\<Home>I" : "i"
  ]])
end

return M
