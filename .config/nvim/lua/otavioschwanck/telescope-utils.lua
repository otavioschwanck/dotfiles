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
    M.prettyFilesPicker({ picker = "git_files" })
  else
    M.prettyFilesPicker({ picker = "find_files" })
  end
end

function M.prettyFilesPicker(pickerAndOptions)
  -- Parameter integrity check
  if type(pickerAndOptions) ~= "table" or pickerAndOptions.picker == nil then
    print("Incorrect argument format. Correct format is: { picker = 'desiredPicker', (optional) options = { ... } }")

    -- Avoid further computation
    return
  end

  -- Ensure 'options' integrity
  local options = pickerAndOptions.options or {}

  -- Use Telescope's existing function to obtain a default 'entry_maker' function
  -- ----------------------------------------------------------------------------
  -- INSIGHT: Because calling this function effectively returns an 'entry_maker' function that is ready to
  --          handle entry creation, we can later call it to obtain the final entry table, which will
  --          ultimately be used by Telescope to display the entry by executing its 'display' key function.
  --          This reduces our work by only having to replace the 'display' function in said table instead
  --          of having to manipulate the rest of the data too.
  local originalEntryMaker = telescopeMakeEntryModule.gen_from_file(options)

  -- INSIGHT: 'entry_maker' is the hardcoded name of the option Telescope reads to obtain the function that
  --          will generate each entry.
  -- INSIGHT: The paramenter 'line' is the actual data to be displayed by the picker, however, its form is
  --          raw (type 'any) and must be transformed into an entry table.
  options.entry_maker = function(line)
    -- Generate the Original Entry table
    local originalEntryTable = originalEntryMaker(line)

    -- INSIGHT: An "entry display" is an abstract concept that defines the "container" within which data
    --          will be displayed inside the picker, this means that we must define options that define
    --          its dimensions, like, for example, its width.
    local displayer = telescopeEntryDisplayModule.create({
      separator = " ", -- Telescope will use this separator between each entry item
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { remaining = true },
      },
    })

    -- LIFECYCLE: At this point the "displayer" has been created by the create() method, which has in turn
    --            returned a function. This means that we can now call said function by using the
    --            'displayer' variable and pass it actual entry values so that it will, in turn, output
    --            the entry for display.
    --
    -- INSIGHT: We now have to replace the 'display' key in the original entry table to modify the way it
    --          is displayed.
    -- INSIGHT: The 'entry' is the same Original Entry Table but is is passed to the 'display()' function
    --          later on the program execution, most likely when the actual display is made, which could
    --          be deferred to allow lazy loading.
    --
    -- HELP: Read the 'make_entry.lua' file for more info on how all of this works
    originalEntryTable.display = function(entry)
      -- Get the Tail and the Path to display
      local tail, pathToDisplay = M.getPathAndTail(entry.value)

      -- Add an extra space to the tail so that it looks nicely separated from the path
      local tailForDisplay = tail .. " "

      -- Get the Icon with its corresponding Highlight information
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

      -- INSIGHT: This return value should be a tuple of 2, where the first value is the actual value
      --          and the second one is the highlight information, this will be done by the displayer
      --          internally and return in the correct format.
      return displayer({
        { icon, iconHighlight },
        tailForDisplay,
        { pathToDisplay, "TelescopeResultsComment" },
      })
    end

    return originalEntryTable
  end

  -- Finally, check which file picker was requested and open it with its associated options
  if pickerAndOptions.picker == "find_files" then
    require("telescope.builtin").find_files(options)
  elseif pickerAndOptions.picker == "git_files" then
    require("telescope.builtin").git_files(options)
  elseif pickerAndOptions.picker == "oldfiles" then
    require("telescope.builtin").oldfiles(options)
  elseif pickerAndOptions.picker == "" then
    print("Picker was not specified")
  else
    print("Picker is not supported by Pretty Find Files")
  end
end

-- Generates a Grep Search picker but beautified
-- ----------------------------------------------
-- This is a wrapping function used to modify the appearance of pickers that provide Grep Search
-- functionality, mainly because the default one doesn't look good. It does this by changing the 'display()'
-- function that Telescope uses to display each entry in the Picker.
--
-- @param (table) pickerAndOptions - A table with the following format:
--                                   {
--                                      picker = '<pickerName>',
--                                      (optional) options = { ... }
--                                   }
function M.prettyGrepPicker(pickerAndOptions)
  -- Parameter integrity check
  if type(pickerAndOptions) ~= "table" or pickerAndOptions.picker == nil then
    print("Incorrect argument format. Correct format is: { picker = 'desiredPicker', (optional) options = { ... } }")

    -- Avoid further computation
    return
  end

  -- Ensure 'options' integrity
  local options = pickerAndOptions.options or {}

  -- Use Telescope's existing function to obtain a default 'entry_maker' function
  -- ----------------------------------------------------------------------------
  -- INSIGHT: Because calling this function effectively returns an 'entry_maker' function that is ready to
  --          handle entry creation, we can later call it to obtain the final entry table, which will
  --          ultimately be used by Telescope to display the entry by executing its 'display' key function.
  --          This reduces our work by only having to replace the 'display' function in said table instead
  --          of having to manipulate the rest of the data too.
  local originalEntryMaker = telescopeMakeEntryModule.gen_from_vimgrep(options)

  -- INSIGHT: 'entry_maker' is the hardcoded name of the option Telescope reads to obtain the function that
  --          will generate each entry.
  -- INSIGHT: The paramenter 'line' is the actual data to be displayed by the picker, however, its form is
  --          raw (type 'any) and must be transformed into an entry table.
  options.entry_maker = function(line)
    -- Generate the Original Entry table
    local originalEntryTable = originalEntryMaker(line)

    -- INSIGHT: An "entry display" is an abstract concept that defines the "container" within which data
    --          will be displayed inside the picker, this means that we must define options that define
    --          its dimensions, like, for example, its width.
    local displayer = telescopeEntryDisplayModule.create({
      separator = " ", -- Telescope will use this separator between each entry item
      items = {
        { width = fileTypeIconWidth },
        { width = nil },
        { width = nil }, -- Maximum path size, keep it short
        { remaining = true },
      },
    })

    -- LIFECYCLE: At this point the "displayer" has been created by the create() method, which has in turn
    --            returned a function. This means that we can now call said function by using the
    --            'displayer' variable and pass it actual entry values so that it will, in turn, output
    --            the entry for display.
    --
    -- INSIGHT: We now have to replace the 'display' key in the original entry table to modify the way it
    --          is displayed.
    -- INSIGHT: The 'entry' is the same Original Entry Table but is is passed to the 'display()' function
    --          later on the program execution, most likely when the actual display is made, which could
    --          be deferred to allow lazy loading.
    --
    -- HELP: Read the 'make_entry.lua' file for more info on how all of this works
    originalEntryTable.display = function(entry)
      ---- Get File columns data ----
      -------------------------------

      -- Get the Tail and the Path to display
      local tail, pathToDisplay = M.getPathAndTail(entry.filename)

      -- Get the Icon with its corresponding Highlight information
      local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

      ---- Format Text for display ----
      ---------------------------------

      -- Add coordinates if required by 'options'
      local coordinates = ""

      if not options.disable_coordinates then
        if entry.lnum then
          coordinates = string.format(" -> %s", entry.lnum)
        end
      end

      -- Append coordinates to tail
      tail = tail .. coordinates

      -- Add an extra space to the tail so that it looks nicely separated from the path
      local tailForDisplay = tail .. " "

      -- Encode text if necessary
      ---@diagnostic disable-next-line: param-type-mismatch
      local text = options.file_encoding and vim.iconv(entry.text, options.file_encoding, "utf8") or entry.text

      -- INSIGHT: This return value should be a tuple of 2, where the first value is the actual value
      --          and the second one is the highlight information, this will be done by the displayer
      --          internally and return in the correct format.
      return displayer({
        { icon, iconHighlight },
        tailForDisplay,
        { pathToDisplay, "TelescopeResultsComment" },
        text,
      })
    end

    return originalEntryTable
  end

  -- Finally, check which file picker was requested and open it with its associated options
  if pickerAndOptions.picker == "live_grep" then
    require("telescope.builtin").live_grep(options)
  elseif pickerAndOptions.picker == "grep_string" then
    require("telescope.builtin").grep_string(options)
  elseif pickerAndOptions.picker == "" then
    print("Picker was not specified")
  else
    print("Picker is not supported by Pretty Grep Picker")
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

function M.grep_layout()
  local columns = vim.o.columns
  local lines = vim.o.lines

  if columns > 280 and lines > 30 then
    return "horizontal"
  elseif lines > 30 then
    return "vertical"
  else
    return "flex"
  end
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
            layout_strategy = require("otavioschwanck.telescope-utils").grep_layout(),
          })
        end)
        return true
      end,
    })
    :find()
end

-- Return the module for use
return M
