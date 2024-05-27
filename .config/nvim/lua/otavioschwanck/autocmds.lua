local M = {}

function M.set()
  require("otavioschwanck.autocmd_langs.ruby")
  require("otavioschwanck.autocmd_langs.csv")

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
      if vim.g.format_on_save then
        require("conform").format({ bufnr = args.buf })
      end
    end,
  })

  local two_space_languages =
    { "ruby", "yaml", "javascript", "typescript", "typescriptreact", "javascriptreact", "eruby", "lua" }

  local four_space_languages = { "solidity" }

  -- on window resize, run <C-w>=
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    pattern = "*",
    callback = function()
      vim.cmd("wincmd =")
    end,
  })

  local autocommands = {
    {
      { "BufWritePre" },
      { "*" },
      function()
        vim.cmd('call mkdir(expand("<afile>:p:h"), "p")')
      end,
    },
    {
      { "FileType" },
      two_space_languages,
      function()
        vim.cmd("setlocal shiftwidth=2 tabstop=2")
      end,
    },
    {
      { "FileType" },
      four_space_languages,
      function()
        vim.cmd("setlocal shiftwidth=4 tabstop=4")
      end,
    },
  }

  vim.api.nvim_create_augroup("otavioschwanck", { clear = true })

  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    group = "otavioschwanck",
    desc = "return cursor to where it was last time closing the file",
    pattern = "*",
    command = 'silent! normal! g`"zv',
  })

  for i = 1, #autocommands, 1 do
    vim.api.nvim_create_autocmd(autocommands[i][1], { pattern = autocommands[i][2], callback = autocommands[i][3] })
  end
end

return M
