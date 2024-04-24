-- Declare the module
local M = {}

-- Store Utilities we'll use frequently
local Path = require("plenary.path")
local telescopeUtilities = require("telescope.utils")
local telescopeMakeEntryModule = require("telescope.make_entry")
local plenaryStrings = require("plenary.strings")
local devIcons = require("nvim-web-devicons")
local telescopeEntryDisplayModule = require("telescope.pickers.entry_display")
local scan = require("plenary.scandir")
local os_sep = Path.path.sep
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")

-- Obtain Filename icon width
-- --------------------------
-- INSIGHT: This width applies to all icons that represent a file type
local fileTypeIconWidth = plenaryStrings.strdisplaywidth(devIcons.get_icon("fname", { default = true }))

---- Helper functions ----

-- Gets the File Path and its Tail (the file name) as a Tuple
function M.getPathAndTail(fileName)
  -- Get the Tail
  local bufferNameTail = telescopeUtilities.path_tail(fileName)

  -- Now remove the tail from the Full Path
  local pathWithoutTail = require("plenary.strings").truncate(fileName, #fileName - #bufferNameTail, "")

  -- Apply truncation and other pertaining modifications to the path according to Telescope path rules
  local pathToDisplay = telescopeUtilities.transform_path({
    path_display = { "truncate" },
  }, pathWithoutTail)

  -- Return as Tuple
  return bufferNameTail, pathToDisplay
end

local is_inside_work_tree = {}

M.project_files = function()
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require("telescope.builtin").git_files({})
  else
    require("telescope.builtin").find_files({})
  end
end

function M.prettyBuffersPicker(localOptions)
  if localOptions ~= nil and type(localOptions) ~= "table" then
    print("Options must be a table.")
    return
  end

  local options = localOptions or {}

  local originalEntryMaker = telescopeMakeEntryModule.gen_from_buffer(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)

    local displayer = telescopeEntryDisplayModule.create({
      separator = " ",
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { width = nil },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      local tail, path = M.getPathAndTail(entry.filename)
      local tailForDisplay = tail .. " "
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

      return displayer({
        { icon, iconHighlight },
        tailForDisplay,
        { "(" .. entry.bufnr .. ")", "TelescopeResultsNumber" },
        { path, "TelescopeResultsComment" },
      })
    end

    return originalEntryTable
  end

  require("telescope.builtin").buffers(options)
end

function M.live_grep_on_folder(opts)
  opts = opts or {}
  local data = {}
  scan.scan_dir(vim.loop.cwd(), {
    hidden = opts.hidden,
    only_dirs = true,
    respect_gitignore = opts.respect_gitignore,
    on_insert = function(entry)
      table.insert(data, entry .. os_sep)
    end,
  })
  table.insert(data, 1, "." .. os_sep)

  pickers
    .new(opts, {
      prompt_title = "Folders for Live Grep",
      finder = finders.new_table({ results = data, entry_maker = make_entry.gen_from_file(opts) }),
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
      additional_args = { "-j1" },
      attach_mappings = function(prompt_bufnr)
        action_set.select:replace(function()
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local dirs = {}
          local selections = current_picker:get_multi_selection()
          if vim.tbl_isempty(selections) then
            table.insert(dirs, action_state.get_selected_entry().value)
          else
            for _, selection in ipairs(selections) do
              table.insert(dirs, selection.value)
            end
          end

          actions.close(prompt_bufnr)

          local cwd = vim.fn.getcwd() .. "/"

          for i, item in ipairs(dirs) do
            dirs[i] = string.gsub(item, cwd, "")
          end

          require("telescope").extensions.egrepify.egrepify({
            search_dirs = dirs,
          })
        end)
        return true
      end,
    })
    :find()
end

-- Return the module for use
return M
