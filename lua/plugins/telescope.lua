return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find [f]iles" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live [g]rep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find [b]uffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search [h]elp" })
			vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Search current [W]ord' })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
