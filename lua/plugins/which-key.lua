return {             -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		require("which-key").register({
			-- Document existing key chains
			["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },

			-- custom key chains
			["<leader>f"] = { name = "[F]uzzy find", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[G]o to", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
			["<leader>a"] = { name = "[A]ctions", _ = "which_key_ignore" },
			["<leader>h"] = { name = "Git actions", _ = "which_key_ignore" },
		})
	end,
}
