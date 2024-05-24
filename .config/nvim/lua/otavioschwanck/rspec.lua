local M = {}

M.search_id = nil

M.quickfix_ns = vim.api.nvim_create_namespace("quickfix")

function M.insert_diagnostics(lines)
  local diagnostics_by_bufnr = {}

  -- Ler o arquivo de quickfix
  for line in lines do
    if line ~= "finished" then
      -- Extrair as partes da linha
      local filename, lineno, message = line:match("([^:]+):(%d+): (.+)")

      -- verify if exists a buffer with filename open
      local bufnr = vim.fn.bufnr(filename)

      if filename and lineno and message then
        lineno = tonumber(lineno)
        if not diagnostics_by_bufnr[bufnr] then
          diagnostics_by_bufnr[bufnr] = {}
        end
        table.insert(diagnostics_by_bufnr[bufnr], {
          lnum = lineno - 1, -- Linhas no Neovim são indexadas a partir de 0
          col = 0,
          severity = vim.diagnostic.severity.ERROR,
          source = "quickfix",
          message = message,
        })
      end
    end
  end

  -- Adicionar os diagnósticos ao Neovim por buffer
  for bufnr, diagnostics in pairs(diagnostics_by_bufnr) do
    vim.diagnostic.set(M.quickfix_ns, bufnr, diagnostics)
  end
end

function M.generate_random_search_id()
  M.search_id = os.time() .. math.random()

  return M.search_id
end

function M.clear_diagnostics()
  vim.diagnostic.reset(M.quickfix_ns)
end

local function file_exists()
  local f = io.open("/tmp/quickfix.out", "r")
  return f ~= nil and io.close(f)
end

function M.wait_quickfix_to_insert_diagnostics(retry_count, search_id)
  retry_count = retry_count or 0

  if search_id and search_id ~= M.search_id then
    return
  end

  search_id = search_id or M.generate_random_search_id()

  if retry_count > 500 then
    return
  end

  local lines
  local file_size

  if file_exists() then
    lines = io.lines("/tmp/quickfix.out")

    file_size = vim.fn.getfsize("/tmp/quickfix.out")
  end

  vim.defer_fn(function()
    if lines and file_size > 0 then
      M.insert_diagnostics(lines)
    else
      M.wait_quickfix_to_insert_diagnostics(retry_count + 1, search_id)
    end
  end, 1000)
end

return M
