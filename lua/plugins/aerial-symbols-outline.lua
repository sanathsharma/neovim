-- https://github.com/stevearc/aerial.nvim
return {
	"stevearc/aerial.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("aerial").setup({
			-- use on_attach to set keymaps when aerial has attached to a buffer
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
			layout = {
				-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
				max_width = { 40, 0.2 },
				width = nil,
				min_width = 40,
			},
		})
		-- keymap to toggle aerial
		vim.keymap.set("n", "<C-o>", "<cmd>AerialToggle!<CR>")

		-- check telescope plugin setup for fuzzy searching symbols
		-- check lualine plugin setup for symbols display on current cursor position
	end,
}
