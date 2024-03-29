return {
  -- "otavioschwanck/arrow.nvim",
  {
    dir = "~/Projetos/arrow.nvim/",
    dependencies = {
      "cbochs/portal.nvim",
      opts = {},
      event = "VeryLazy",
    },
    opts = {
      separate_save_and_remove = true,
      always_show_path = false,
      hide_handbook = true,
      relative_path = true,
      save_key = "git_root",
      show_icons = true,
      leader_key = ";",
      full_path_list = { "update_spec", "create_spec", "edit_spec", "destroy_spec", "delete_spec" },
      global_bookmarks = false,
      separate_by_branch = true,
    },
    event = "VeryLazy",
    keys = {
      {
        "H",
        function()
          require("arrow.persist").previous()
        end,
        desc = "Previous Arrow",
      },
      {
        "L",
        function()
          require("arrow.persist").next()
        end,
        desc = "Next Arrow",
      },
    },
  },
}
