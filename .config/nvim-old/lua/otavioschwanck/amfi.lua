local M = {}

local run = require("tmux-awesome-manager").execute_command

local sleep_factor = 1
local project_folder = "~/Projetos"
local run_docker = true
local rails_server_start_sleep = 3 * sleep_factor
local shun_server_start_sleep = 2 * sleep_factor
local shun_on_restart_start_sleep = (rails_server_start_sleep + 4) * sleep_factor

function M.restart_amfi(start_dapp)
  require("otavioschwanck.lang_helpers.ruby").kill_ruby_instances()
  require("tmux-awesome-manager").kill_all_terms()

  if run_docker then
    run({
      name = "Run Docker",
      cmd = "up -d postgres redis",
      visit_first_call = false,
      close_on_timer = 1,
      open_as =
      "separated_session"
    })
  end

  run({
    name = "Brownie",
    cmd = "cd " .. project_folder .. "/evm-contracts; ./bin/brn clean_and_start",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Rails Server",
    cmd =
        "sleep " ..
        rails_server_start_sleep ..
        "; cd " ..
        project_folder ..
        "/shun; yarn db:reset; cd " ..
        project_folder ..
        "/api; bin/rails db:environment:set RAILS_ENV=development; rails db:drop db:create db:migrate;rails db:seed; rails server",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Shun",
    cmd = "sleep " .. shun_on_restart_start_sleep .. "; cd " .. project_folder .. "/shun; yarn start:dev",
    visit_first_call = false,
    open_as = "separated_session"
  })

  if start_dapp then
    run({
      name = "Dapp",
      cmd = "cd " .. project_folder .. "/dapp; yarn dev",
      visit_first_call = false,
      open_as = "separated_session"
    })
  end
end

function M.start_amfi(start_dapp)
  if run_docker then
    run({
      name = "Run Docker",
      cmd = "up -d postgres redis",
      visit_first_call = false,
      close_on_timer = 1,
      open_as =
      "separated_session"
    })
  end

  run({
    name = "Rails Server",
    cmd = "sleep " .. rails_server_start_sleep .. "; cd " .. project_folder .. "/api; rails server",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Brownie",
    cmd = "cd " .. project_folder .. "/evm-contracts; ./bin/brn start",
    visit_first_call = false,
    open_as = "separated_session"
  })

  run({
    name = "Shun",
    cmd = "sleep " .. shun_server_start_sleep .. "; cd " .. project_folder .. "/shun; yarn start:dev",
    visit_first_call = false,
    open_as = "separated_session"
  })

  if start_dapp then
    run({
      name = "Dapp",
      cmd = "cd " .. project_folder .. "/dapp; yarn dev",
      visit_first_call = false,
      open_as = "separated_session"
    })
  end
end

return M
