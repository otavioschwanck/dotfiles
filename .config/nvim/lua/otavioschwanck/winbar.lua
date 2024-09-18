local M = {}

local palette = {
  text_path = "#928374",
  file = "#ebdbb2",
  red = "#cc241d",
}

vim.api.nvim_set_hl(0, "WinBarPath", { fg = palette.text_path })
vim.api.nvim_set_hl(0, "WinBarFileName", { fg = palette.file })
vim.api.nvim_set_hl(0, "WinBarModified", { fg = palette.red })

function M.eval()
  local file_path = vim.api.nvim_eval_statusline("%f", {}).str
  local modified = vim.api.nvim_eval_statusline("%M", {}).str == "+" and "⊚" or ""

  if string.match(file_path, "^~/") then
    file_path = vim.fn.fnamemodify(file_path, ":~:.")
  end

  local is_a_file = vim.fn.filereadable(file_path) == 1

  if not is_a_file then
    return file_path
  end

  local splitted_path = vim.split(file_path, "/")

  local path = ""
  local filename = ""

  if #splitted_path == 1 then
    path = ""
    filename = splitted_path[#splitted_path]
  else
    path = table.concat(vim.list_slice(splitted_path, 1, #splitted_path - 1), "/")
    filename = splitted_path[#splitted_path]
  end

  local status = require("arrow.statusline").text_for_statusline_with_icons()

  return "%#WinBarPath#  "
      .. path
      .. "/%*%#WinBarFileName#"
      .. filename
      .. "%* "
      .. "%#WinBarModified#"
      .. (not (modified == "") and (modified .. " ") or "")
      .. "%*"
      .. status
end

return M
