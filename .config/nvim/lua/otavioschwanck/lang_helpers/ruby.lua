local M = {}

function M.comment_rubocop()
  local error = vim.diagnostic.get()
  local line = vim.fn.line(".")
  local bufnr = vim.fn.bufnr()
  local current_error

  ---@diagnostic disable-next-line: unused-local
  for __, v in ipairs(error) do
    ---@diagnostic disable-next-line: undefined-field
    if v.lnum + 1 == line and bufnr == v.bufnr then
      if not current_error then
        current_error = v
      end
    end
  end

  if current_error then
    local current_line = vim.fn.getline(".")
    local real_cop_name = current_error.code

    if string.match(current_line, "# rubocop:disable") then
      vim.cmd("normal! A, " .. real_cop_name)
    else
      vim.cmd("normal! A # rubocop:disable " .. real_cop_name)
    end
  end
end

function M.search_class_name()
  local class_name = M.get_class_name()
  if class_name ~= "" then
    vim.cmd("Telescope grep_string search=" .. class_name)
  end
end

function M.reset_rails_db()
  require("tmux-awesome-manager").execute_command({
    cmd =
    "cd ~/Projetos/shun; yarn db:reset; cd ~/Projetos/api; bin/rails db:environment:set RAILS_ENV=development; rails db:drop db:create db:migrate;rails db:seed",
    name = "db:reset",
    open_as = "pane",
    focus_when_call = false,
    visit_first_call = true,
    size = "25%",
  })
end

function M.kill_ruby_instances()
  vim.cmd("silent !killall -9 rails ruby spring bundle;lsof -i :3000 | grep LISTEN | awk '{print $2}' | xargs kill;")

  vim.defer_fn(function()
    vim.cmd("LspStart solargraph")
  end, 2000)
end

function M.find_in_folder(folder, title)
  return function()
    if vim.fn.isdirectory(folder) == 1 then
      vim.cmd(
        "lua require'telescope.builtin'.find_files({ cwd = '"
        .. folder
        .. "', prompt_title = '"
        .. title
        .. "', path_display = 'absolute' })"
      )
    else
      print("Directory: '" .. folder .. "' not found in this project...")
    end
  end
end

function M.open_test_alternate_split()
  local test_path = M.open_test_alternate()

  vim.cmd("wincmd o")
  vim.cmd("wincmd v")

  M.open_test_alternate()

  if test_path and not (string.match(tostring(test_path), "app/")) then
    vim.cmd("wincmd x")
  end
end

function M.open_test_alternate()
  local test_path = vim.fn.eval("rails#buffer().alternate()")

  vim.cmd("e " .. test_path)

  return test_path
end

function M.get_class_name()
  local filetype = vim.bo.filetype

  if filetype == "ruby" then
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local class_name = ""

    for _, line in ipairs(lines) do
      local module_match = string.match(line, "module (%w+)")
      local class_match = string.match(line, "class (%w+)")

      if module_match then
        class_name = class_name .. module_match .. "::"
      elseif class_match then
        class_name = class_name .. class_match
        break
      end
    end

    if class_name ~= "" and class_name ~= "ChainApi" then
      vim.fn.setreg("+", class_name)
      vim.fn.setreg("*", class_name)
      print("Copied to clipboard: " .. class_name)

      return class_name
    else
      print("No class or module found")

      return ""
    end
  end
end

return M
