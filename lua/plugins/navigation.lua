return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		config = function()
			vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
			vim.keymap.set("n", "<C-l", "<cmd> TmuxNavigateRight<CR>")
			vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
			vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup({
				global_settings = {
					-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
					save_on_toggle = true,

					-- saves the harpoon file upon every change. disabling is unrecommended.
					save_on_change = true,

					-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
					enter_on_sendcmd = false,

					-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
					tmux_autoclose_windows = false,

					-- filetypes that you want to prevent from adding to the harpoon list menu.
					excluded_filetypes = { "harpoon" },

					-- set marks specific to each git branch inside git repository
					mark_branch = true,

					-- enable tabline with harpoon marks
					tabline = false,
					tabline_prefix = "   ",
					tabline_suffix = "   ",
				},
			})

			local ui = require("harpoon.ui")
			local mark = require("harpoon.mark")

			vim.keymap.set("n", "<leader>ma", mark.add_file, { desc = "[A]dd mark" })
			vim.keymap.set("n", "<leader>mn", ui.nav_next, { desc = "Jump to [n]ext mark" })
			vim.keymap.set("n", "<leader>mp", ui.nav_prev, { desc = "Jump to [p]rev mark" })
			vim.keymap.set("n", "<leader>mm", ui.toggle_quick_menu, { desc = "Open marks [m]enu" })

			for i = 1, 4, 1 do
				vim.keymap.set("n", "<leader>m" .. i, function()
					ui.nav_file(i)
					end, { desc = "Jump to mark: " .. i })
			end
		end,
	},
}
