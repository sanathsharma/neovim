return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		--  require("catppuccin").setup() -- config function does this automatically
		vim.cmd.colorscheme("catppuccin")
	end,
}
