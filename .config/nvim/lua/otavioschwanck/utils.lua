local M = {}

function M.t(map, func, desc)
  vim.keymap.set("t", map, func, { silent = true, noremap = true, desc = desc or "" })
end

function M.c(map, func)
  vim.keymap.set("c", map, func)
end

function M.n(map, func, desc)
  vim.keymap.set("n", map, func, { silent = true, noremap = true, desc = desc or "" })
end

function M.n_buf(map, func, desc, buf)
  vim.keymap.set("n", map, func, { silent = true, noremap = true, desc = desc or "", buffer = buf })
end

function M.v(map, func, desc)
  vim.keymap.set({ "v", "x" }, map, func, { silent = true, noremap = true, desc = desc or "" })
end

function M.nv(map, func, desc)
  vim.keymap.set({ "v", "n" }, map, func, { silent = true, noremap = true, desc = desc or "" })
end

function M.x(map, func, desc)
  vim.keymap.set("x", map, func, { silent = true, noremap = true, desc = desc or "" })
end

function M.v_buf(map, func, desc, buf)
  vim.keymap.set("v", map, func, { silent = true, noremap = true, desc = desc or "", buffer = buf })
end

return M
