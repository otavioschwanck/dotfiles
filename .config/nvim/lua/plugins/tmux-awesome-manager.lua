return {
  {
    "otavioschwanck/tmux-awesome-manager.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>lf", "<cmd>Telescope tmux-awesome-manager list_terms<CR>",      desc = "Search Commands" },
      {
        "<leader>l",
        function()
          require("tmux-awesome-manager").send_text_to()
        end,
        desc = "Send Text to Tmux",
        mode = { "v", "x" },
      },
      { "<leader>ll", "<cmd>Telescope tmux-awesome-manager list_open_terms<CR>", desc = "Search Open Terminals" },
      {
        "<leader>lk",
        function()
          require("tmux-awesome-manager").kill_all_terms()
        end,
        desc = "Kill all Terms",
      },
    },
    config = function()
      require("telescope").load_extension("tmux-awesome-manager")

      require("tmux-awesome-manager").setup({
        project_open_as = "separated_session",
        session_name = "Servers",
        per_project_commands = {
          api = { { cmd = "rails s", name = "rails server" } },
          dapp = { { cmd = "rm -rf .next; yarn dev", name = "dapp server" } },
          shun = { { cmd = "yarn start:dev", name = "shun server" } },
          ["evm-contracts"] = { { cmd = "bin/brn start", name = "evm-contracts server" } },
        },
        default_size = "25%",
        use_icon = true,
        open_new_as = "pane",
        visit_first_call = true,
      })

      local tmux = require("tmux-awesome-manager.src.term")

      local set = function(key, opts)
        vim.keymap.set("n", key, tmux.run(opts), { silent = true, noremap = true, desc = opts.name })
      end

      set("<leader>obc", {
        cmd = "bin/brn clean_and_start",
        name = "brownie clean and start",
        open_as = "separated_session",
        visit_first_call = false,
      })
      set("<leader>od", {
        cmd = "up -d postgres redis",
        name = "Run Docker Stuff",
        open_as = "separated_session",
        visit_first_call = false,
        close_on_timer = 2,
      })
      set("<leader>rr", {
        cmd = "rails console",
        name = "rails console",
        open_as = "window",
        visit_first_call = true,
      })
      set("<leader>oy", { cmd = "yarn install", name = "yarn install", open_as = "pane" })
      set("<leader>oYc", { cmd = "yarn check-translations", name = "yarn check-translations", open_as = "pane" })
      set("<leader>os", {
        cmd = "~/.sync-config.sh",
        name = "sync dotfiles",
        open_as = "pane",
        close_on_timer = 2,
        visit_first_call = false,
      })
      vim.keymap.set("n", "<leader>#", function()
        require("tmux-awesome-manager").run_project_terms()
      end, { silent = true, noremap = true, desc = "Run Project Terms" })

      set("<leader>obC", { cmd = "brownie compile", name = "Brownie Compile", open_as = "pane" })
      set("<leader>obd", { cmd = "python console.py", name = "Brownie Console (local)" })
      set("<leader>obs", { cmd = "python console.py --network polygon-test", name = "Brownie Console (Staging)" })
      set("<leader>obp", { cmd = "python console.py --network polygon-main", name = "Brownie Console (Production)" })

      set("<leader>opp", {
        cmd =
        "aws ssm start-session --profile amfi_prod --target $(AWS_PROFILE=amfi_prod ./codedeploy/instance-id.sh prd)",
        name = "!!!API Prod!!!",
        open_as = "separated_session",
        focus_when_call = true,
      })

      set("<leader>ops", {
        cmd = "aws ssm start-session --profile amfi --target $(AWS_PROFILE=amfi ./codedeploy/instance-id.sh stg)",
        name = "API STG",
        open_as = "separated_session",
        focus_when_call = true,
      })

      set("<leader>+", {
        cmd = "bundle exec rubocop -A",
        name = "rubocop",
        open_as = "pane",
        close_on_timer = 2,
        visit_first_call = false,
        focus_when_call = false,
      })

      set("<leader>rb", {
        cmd = "bundle install",
        name = "Bundle Install",
        open_as = "pane",
        close_on_timer = 2,
        visit_first_call = false,
        focus_when_call = false,
      })

      set("<leader>rg", {
        cmd = "rails generate %1",
        name = "Rails Generate",
        questions = {
          {
            question = "Rails generate: ",
            required = true,
            open_as = "pane",
            close_on_timer = 4,
            visit_first_call = false,
            focus_when_call = false,
          },
        },
      })

      set("<leader>rd", {
        cmd = "rails destroy %1",
        name = "Rails Destroy",
        questions = { { question = "Rails destroy: ", required = true } },
        open_as = "pane",
        close_on_timer = 4,
        visit_first_call = false,
        focus_when_call = false,
      })

      set("<leader>ri", {
        cmd = "rails db:migrate",
        name = "Rails db:migrate",
        open_as = "pane",
        close_on_timer = 4,
        visit_first_call = false,
        focus_when_call = false,
      })

      set("<leader>oYp", {
        cmd = "yarn prettier",
        name = "Prettier",
        open_as = "pane",
        close_on_timer = 2,
        visit_first_call = false,
        focus_when_call = false,
      })
    end,
  },
}
