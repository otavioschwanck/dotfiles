local M = {}

function M.restart_amfi()
end

function M.start_amfi()
  local run = require("tmux-awesome-manager").execute_command

  run({
    name = "Run Docker",
    cmd = "up -d postgres redis",
    visit_first_call = false,
    close_on_timer = 1,
    open_as = "separated_session"
  })

  run({
    name = "Rails Server",
    cmd = "sleep 3; cd ~/Projetos/api; rails server",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Brownie",
    cmd = "cd ~/Projetos/evm-contracts; ./bin/brn start",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Shun",
    cmd = "sleep 2; cd ~/Projetos/shun; yarn start:dev",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Dapp",
    cmd = "cd ~/Projetos/dapp; yarn dev",
    visit_first_call = false,
    open_as = "separated_session"
  })
end

return M
