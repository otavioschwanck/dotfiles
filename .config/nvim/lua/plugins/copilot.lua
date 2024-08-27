-- :CopilotChat <input>? - Open chat window with optional input
-- :CopilotChatOpen - Open chat window
-- :CopilotChatClose - Close chat window
-- :CopilotChatToggle - Toggle chat window
-- :CopilotChatStop - Stop current copilot output
-- :CopilotChatReset - Reset chat window
-- :CopilotChatSave <name>? - Save chat history to file
-- :CopilotChatLoad <name>? - Load chat history from file
-- :CopilotChatDebugInfo - Show debug information
-- :CopilotChatModels - View and select available models. This is reset when a new instance is made. Please set your model in init.lua for persistence.
-- :CopilotChatModel - View the currently selected model.
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    keys = {
      { "<leader>pp", "<cmd>CopilotChatToggle<CR>", desc = "Toggle" },
      { "<leader>pR", "<cmd>CopilotChatReset<CR>", desc = "Reset Chat" },

      { "<leader>pe", "<cmd>CopilotChatExplain<CR>", desc = "Write explanation", mode = { "v", "n" } },
      { "<leader>pr", "<cmd>CopilotChatReview<CR>", desc = "Review Code", mode = { "v", "n" } },
      { "<leader>pf", "<cmd>CopilotChatFix<CR>", desc = "Fix Problem", mode = { "n", "v" } },
      { "<leader>po", "<cmd>CopilotChatOptimize<CR>", desc = "Optimize Code", mode = { "n", "v" } },
      { "<leader>pd", "<cmd>CopilotChatDocs<CR>", desc = "Add Docs", mode = { "n", "v" } },
      { "<leader>pt", "<cmd>CopilotChatTests<CR>", desc = "Generate Tests", mode = { "n", "v" } },
      { "<leader>pd", "<cmd>CopilotChatFixDiagnostic<CR>", desc = "Fix Diagnostic Error", mode = { "n", "v" } },
      { "<leader>pc", "<cmd>CopilotChatCommit<CR>", desc = "Write Commit Message" },
      { "<leader>pC", "<cmd>CopilotChatCommitStaged<CR>", desc = "Write Commit Message Staged" },
    },
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
          keymap = {
            accept = "<C-j>",
            accept_word = "<C-l>",
            accept_line = false,
            next = "<C-f>",
            prev = "<C-b>",
            dismiss = "<C-]>",
          },
        },
      })
    end,
  },
}
