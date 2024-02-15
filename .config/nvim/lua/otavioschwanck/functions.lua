local M = {}

function M.word_for_gq()
  local word = vim.fn.escape(vim.fn.getreg('"'), "\\/.*$~^[]")

  -- Substituir caracteres especiais por suas representações de escape
  word = word:gsub("[<>]", function(match)
    if match == "<" then
      return "\\<lt>"
    elseif match == ">" then
      return "\\<gt>"
    end
  end)

  return word
end

return M
