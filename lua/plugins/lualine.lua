return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
			},
			sections = {
				lualine_a = { {
					"mode",
					fmt = function(str)
						return str:sub(1, 1)
					end,
				} },
				lualine_b = {
					{
						"branch",
						fmt = function(str)
							local max_length = vim.o.columns / 3.5
							if string.len(str) > max_length then
								return str:sub(1, max_length) .. "..."
							end
							return str
						end,
					},
					"diff",
					"diagnostics",
				},
				lualine_c = { "filename" },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
