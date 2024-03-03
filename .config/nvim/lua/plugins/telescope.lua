return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "prochri/telescope-all-recent.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        config = function()
          require("telescope-all-recent").setup({
            pickers = {
              find_files = {
                disable = false,
                use_cwd = true,
                sorting = "recent",
              },
            },
          })
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        keys = {
          {
            "<leader>.",
            function()
              require("telescope").extensions.file_browser.file_browser({
                path = "%:p:h",
              })
            end,
            desc = "File Browser",
          },
        },
      },
      {
        "fdschmidt93/telescope-egrepify.nvim",
        keys = {
          {
            "<leader>sd",
            function()
              require("telescope").extensions.egrepify.egrepify({
                additional_args = "-j1",
                search_dirs = { vim.fn.fnamemodify(vim.fn.expand("%:~:h"), ":.") },
              })
            end,
            desc = "Live Grep On Current Dir",
          },
          {
            "<leader>/",
            function()
              require("telescope").extensions.egrepify.egrepify({
                additional_args = "-j1",
              })
            end,
            desc = "Live Grep",
          },
          {
            "<leader>so",
            "<cmd>Telescope egrepify grep_open_files=true<CR>",
            desc = "Grep on Open Files",
          },
          {
            "<leader>sp",
            function()
              require("telescope").extensions.egrepify.egrepify({
                additional_args = "-j1",
              })
            end,
            desc = "Live Grep",
          },
        },
      },
    },
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
        git_files = {
          show_untracked = true,
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<C-e>"] = function(picker)
              require("telescope.actions").send_selected_to_qflist(picker)
              vim.cmd("copen")
            end,
          },
        },
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            height = 0.8,
          },
          vertical = {
            prompt_position = "top",
          },
        },
        sorting_strategy = "ascending",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local fb_actions = require("telescope").extensions.file_browser.actions

      if not opts.extensions then
        opts.extensions = {}
      end

      opts.extensions = vim.tbl_extend("force", opts.extensions, {
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
      })

      telescope.setup(opts)

      telescope.load_extension("file_browser")
      telescope.load_extension("fzf")
    end,
    keys = {
      { "<leader>sR", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>fR", false },
      { "<leader>gs", false },
      { "<leader>so", false },
      { "<leader><CR>", "<cmd>Telescope resume<CR>", desc = "Telescope Resume" },
      {
        "<leader><space>",
        function()
          require("otavioschwanck.telescope-utils").project_files()
        end,
        desc = "Find Project Files",
      },
      {
        "<leader>ff",
        function()
          require("otavioschwanck.telescope-utils").project_files()
        end,
        desc = "Find Project Files",
      },
      {
        "<leader>,",
        function()
          require("otavioschwanck.telescope-utils").prettyBuffersPicker({
            only_cwd = true,
            ignore_current_buffer = true,
            sort_mru = true,
          })
        end,
        desc = "Find Buffers (CWD)",
      },
      {
        "<leader><",
        function()
          require("otavioschwanck.telescope-utils").prettyBuffersPicker({ only_cwd = false })
        end,
        desc = "Find All Buffers",
      },
      {
        "<leader><tab>",
        function()
          require("telescope.builtin").git_status()
        end,
        desc = "Git Status (CWD)",
      },
      {
        "<leader>sr",
        function()
          require("telescope.builtin").oldfiles({ cwd_only = true })
        end,
        desc = "Recent (CWD)",
      },
      {
        "<leader>ss",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Search On Current Buffer",
      },
      {
        "<leader>si",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Search Document Symbols",
      },
      {
        "<leader>sj",
        function()
          require("telescope.builtin").lsp_workspace_symbols()
        end,
        desc = "Search Workspace Symbols",
      },
    },
  },
}
