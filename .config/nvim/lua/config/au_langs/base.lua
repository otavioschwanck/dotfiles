local M = {}

function M.create_au_for_lang(lang, callback)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { lang },
    callback = callback,
  })
end

return M
