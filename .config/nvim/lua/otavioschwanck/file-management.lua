local M = {}

function M.better_move()
  local current_folder = vim.fn.expand("%:p:h")

  vim.api.nvim_feedkeys(":Move " .. current_folder .. "/", "n", true)

  vim.defer_fn(function()
    vim.cmd("doautocmd BufNew")
  end, 500)
end

function M.copy_relative_path()
  local value = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  vim.cmd("let @* = '" .. value .. "'")
  vim.cmd("let @+ = '" .. value .. "'")
  print("Yanked: " .. value)
end

function M.file_and_line()
  local file = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
  local line = vim.fn.line(".")

  return file .. ":" .. line
end

function M.copy_relative_path_with_line()
  local value = M.file_and_line()

  vim.cmd("let @* = '" .. value .. "'")
  vim.cmd("let @+ = '" .. value .. "'")
  print("Yanked: " .. value)
end

function M.copy_full_path()
  local value = vim.fn.expand("%:p")
  vim.cmd("let @* = '" .. value .. "'")
  vim.cmd("let @+ = '" .. value .. "'")
  print("Yanked: " .. value)
end

function M.better_rename()
  local current_file = vim.fn.expand("%p")
  local current_file_name = vim.fn.expand("%:t")
  ---@diagnostic disable-next-line: redundant-parameter
  local new_name = vim.fn.input("New name for " .. current_file_name .. ": ", current_file_name)
  local current_folder = vim.fn.expand("%:p:h")

  if new_name ~= "" and new_name ~= current_file_name then
    vim.cmd("saveas " .. current_folder .. "/" .. new_name)
    vim.fn.delete(current_file)
    vim.cmd("bd! #")
    vim.cmd("e")

    vim.defer_fn(function()
      vim.cmd("doautocmd BufNew")
    end, 500)
  end
end

function M.better_copy()
  local current_folder = vim.fn.expand("%:p:h")

  vim.api.nvim_feedkeys(":saveas " .. current_folder .. "/", "n", true)

  vim.defer_fn(function()
    vim.cmd("doautocmd BufNew")
  end, 500)
end

function M.better_delete(force)
  print("Really want to delete current file? y/n ")
  local answer

  if force then
    answer = "y"
  else
    answer = vim.fn.nr2char(vim.fn.getchar())
  end

  if answer == "y" then
    vim.cmd("Delete!")
  elseif answer == "n" then
    return 0
  else
    print('Please enter "y" or "n"')
    return M.better_delete()
  end
end

return M
