local M = {}

function M.eval()
  local win_count = vim.fn.winnr("$")

  if win_count <= 1 then
    return ""
  end

  local file_path = vim.api.nvim_eval_statusline("%f", {}).str
  local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "⊚" or ""

  local status = require("arrow.statusline").text_for_statusline_with_icons()

  return "%#WinBarPath#  " .. file_path .. "%*" .. "%#WinBarModified#" .. modified .. "%* " .. status
end

return M
