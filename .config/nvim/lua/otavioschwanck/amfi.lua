local M = {}

local run = require("tmux-awesome-manager").execute_command

function M.restart_amfi()
  require("otavioschwanck.lang_helpers.ruby").kill_ruby_instances()
  require("tmux-awesome-manager").kill_all_terms()

  run({
    name = "Run Docker",
    cmd = "up -d postgres redis",
    visit_first_call = false,
    close_on_timer = 1,
    open_as =
    "separated_session"
  })

  run({
    name = "Brownie",
    cmd = "cd ~/Projetos/evm-contracts; ./bin/brn clean_and_start",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Rails Server",
    cmd =
    "sleep 3; cd ~/Projetos/shun; yarn db:reset; cd ~/Projetos/api; bin/rails db:environment:set RAILS_ENV=development; rails db:drop db:create db:migrate;rails db:seed; rails server",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Shun",
    cmd = "sleep 7; cd ~/Projetos/shun; yarn start:dev",
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

function M.start_amfi()
  run({
    name = "Run Docker",
    cmd = "up -d postgres redis",
    visit_first_call = false,
    close_on_timer = 1,
    open_as =
    "separated_session"
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
