return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[\\]] -- <C-\> is not used because of conflicting short cut with vim-tmux-navigator
			})
		end,
	},
}
