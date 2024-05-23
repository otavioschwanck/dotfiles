return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"RRethy/nvim-treesitter-endwise",
			{
				"nvim-treesitter/nvim-treesitter-context",
				event = "VeryLazy",
				config = function()
					require("treesitter-context").setup({
						enable = true,
						max_lines = 1,
						trim_scope = "outer",
						patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
							-- For all filetypes
							-- Note that setting an entry here replaces all other patterns for this entry.
							-- By setting the 'default' entry below, you can control which nodes you want to
							-- appear in the context window.
							default = {
								"class",
								"function",
								"method",
								"for", -- These won't appear in the context
								"while",
								"if",
								"switch",
								"case",
								"element",
								"call",
							},
						},
						exact_patterns = {},

						zindex = 20, -- The Z-index of the context window
						mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
						separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
					})
				end,
			},
		},
		event = "VeryLazy",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = {
					"ruby",
					"html",
					"css",
					"scss",
					"javascript",
					"typescript",
					"solidity",
					"yaml",
					"json",
					"lua",
					"vim",
					"query",
					"embedded_template",
					"bash",
					"tsx",
				},

				highlight = {
					enable = true,
				},

				indent = { enable = true, disable = { "ruby", "python" } },

				textobjects = {
					swap = {
						enable = true,
						swap_next = {
							["g]f"] = "@function.outer",
						},
						swap_previous = {
							["g[f"] = "@function.outer",
						},
					},
				},

				endwise = { enable = true },
			})
		end,
	},
}
