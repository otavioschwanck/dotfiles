local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local dotfiles = {
  { path = "~/.config/alacritty/alacritty.toml", display = "Alacritty" },
  { path = "~/.zshrc", display = "zshrc" },
  { path = "~/.zsh_aliases", display = "zshrc aliases" },
  { path = "~/.zsh_settings", display = "zshrc settings" },
  { path = "~/.tmux.conf", display = "Tmux" },
  { path = "~/Library/Application Support/lazygit/config.yml", display = "Lazygit" },
  { path = "~/.gitconfig", display = "GitConfig" },
  { path = "~/.config/yabai/yabairc", display = "YabaiRc" },
  { path = "~/.config/skhd/skhdrc", display = "SkhdRc" },
}

function M.call(files)
  pickers
    .new({}, {
      prompt_title = "User Files",
      finder = finders.new_table({
        results = files,
        entry_maker = function(entry)
          return {
            value = entry.path,
            display = entry.display or entry.path,
            ordinal = (entry.order or "") .. (entry.display or "") .. entry.path,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = conf.file_previewer({}),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry().value

          vim.cmd("e " .. selection)
        end)
        return true
      end,
    })
    :find()
end

function M.open_dotfiles()
  M.call(dotfiles)
end

return M
