local M = {}

function M.restart_amfi()
end

function M.start_amfi()
  local tmux = require("tmux-awesome-manager.src.term")

  tmux.run({
    cmd = "Rails Server",
    name = "sleep 5; up -d postgres redis",
    visit_first_call = false,
    close_on_timer = 1,
    project_open_as =
    "separated_session "
  })

  tmux.run({
    cmd = "Rails Server",
    name = "sleep 5; cd ~/Projetos/api; rails server",
    visit_first_call = false,
    project_open_as =
    "separated_session "
  })

  tmux.run({
    cmd = "Brownie",
    name = "cd ~/Projetos/evm-contracts; ./bin/brn start",
    visit_first_call = false,
    project_open_as =
    "separated_session "
  })

  tmux.run({
    cmd = "Brownie",
    name = "cd ~/Projetos/evm-contracts; ./bin/brn start",
    visit_first_call = false,
    project_open_as =
    "separated_session "
  })
end

return M
