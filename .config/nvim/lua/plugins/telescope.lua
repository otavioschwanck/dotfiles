return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
      },
      {
        "prochri/telescope-all-recent.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        config = function()
          require("telescope-all-recent").setup({
            database = {
              max_timestamps = 10,
            },
            pickers = {
              find_files = {
                disable = false,
                use_cwd = true,
                sorting = "recent",
              },
              git_files = {
                disable = false,
                use_cwd = true,
                sorting = "recent",
              },
            },
          })
        end,
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          require("otavioschwanck.telescope").project_files()
        end,
        desc = "Project Files",
      },
      {
        "<leader>sp",
        function()
          require("telescope.builtin").live_grep({
            additional_args = "-j1",
          })
        end,
        desc = "Live Grep",
      },
      { "<leader>,",     "<cmd>Telescope buffers ignore_current_buffer=true sort_mru=true<CR>", desc = "Buffers" },
      { "<leader>*",     "<cmd>Telescope grep_string<CR>",                                      desc = "Search String At Cursor" },
      { "<leader><cr>",  "<cmd>Telescope resume<cr>",                                           desc = "Resume Last Search" },
      { "<leader>sh",    "<cmd>Telescope help_tags<cr>",                                        desc = "Help" },
      { "<leader><tab>", "<cmd>Telescope git_status<cr>",                                       desc = "Git Status" },
      { "<leader>ss",    "<cmd>Telescope current_buffer_fuzzy_find<cr>",                        desc = "Fuzzy on Current buffer" },
      { "<leader>x",     "<cmd>Telescope diagnostics<cr>",                                      desc = "Diagnostics" },
      { "<leader>si",    "<cmd>Telescope lsp_document_symbols<cr>",                             desc = "Document Symbols" },
      { "<leader>sj",    "<cmd>Telescope lsp_workspace_symbols<cr>",                            desc = "Workspace Symbols" },
      {
        "<leader>.",
        "<cmd>Telescope file_browser path=%:p:h hidden=true respect_gitignore=false<CR>",
        desc = "File Browser",
      },
      p = { ":Telescope yank_history<CR>", "Yank History" },
      {
        "<leader>sD",
        function()
          require("otavioschwanck.telescope").live_grep_on_folder()
        end,
        desc = "Live Grep On Multiple Folders",
      },
      {
        "<leader>sd",
        function()
          require("telescope.builtin").live_grep({
            additional_args = "-j1",
            search_dirs = { vim.fn.fnamemodify(vim.fn.expand("%:~:h"), ":.") },
          })
        end,
        desc = "Live Grep On Current Folder",
      },
      {
        "<leader>sD",
        function()
          require("otavioschwanck.telescope").live_grep_on_folder()
        end,
        desc = "Live Grep On Multiple Folders",
      },
    },
    event = "VeryLazy",
    config = function()
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            ".*.git/.*",
            "node_modules/.*",
            "sorbet/.*",
            "tmp/.*",
            "vendor/.*",
            "storage/.*",
          },
          layout_config = {
            prompt_position = "top",
            height = 0.8,
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<C-e>"] = function(picker)
                actions.send_selected_to_qflist(picker)
                vim.cmd("copen")
              end,
            },
          },
        },
        pickers = {
          live_grep = {
            layout_config = {
              preview_cutoff = 120,
              width = 0.9,
            },
          },
          find_files = {
            hidden = true,
          },
          git_files = {
            show_untracked = true,
          },
        },
        extensions = {
          file_browser = {
            hidden = true,
            prompt_path = true,
            hide_parent_dir = true,
            grouped = true,
            mappings = {
              ["i"] = {
                ["<A-c>"] = fb_actions.create,
                ["<S-CR>"] = fb_actions.create_from_prompt,
                ["<C-space>"] = fb_actions.create_from_prompt,
                ["<A-r>"] = fb_actions.rename,
                ["<A-m>"] = fb_actions.move,
                ["<A-y>"] = fb_actions.copy,
                ["<A-d>"] = fb_actions.remove,
                ["<C-o>"] = fb_actions.open,
                ["<C-g>"] = fb_actions.goto_parent_dir,
                ["<C-e>"] = fb_actions.goto_home_dir,
                ["<C-b>"] = fb_actions.goto_cwd,
                ["<C-t>"] = fb_actions.change_cwd,
                ["<C-f>"] = fb_actions.toggle_browser,
                ["<C-h>"] = fb_actions.toggle_hidden,
                ["<C-s>"] = fb_actions.toggle_all,
                ["<C-r>"] = fb_actions.toggle_respect_gitignore,
                ["<bs>"] = fb_actions.backspace,
              },
              ["n"] = {
                ["<C-space>"] = fb_actions.create_from_prompt,
                ["r"] = fb_actions.rename,
                ["d"] = fb_actions.remove,
                ["p"] = fb_actions.copy,
                ["P"] = fb_actions.move,
                ["x"] = fb_actions.move,
              },
            },
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      })

      telescope.load_extension("yank_history")
      telescope.load_extension("file_browser")
      telescope.load_extension("fzf")
    end,
  },
}
