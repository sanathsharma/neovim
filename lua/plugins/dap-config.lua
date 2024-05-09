return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("dapui").setup()

			-- keymaps
			vim.keymap.set(
				"n",
				"<leader>dt",
				"<cmd>lua require('dapui').toggle()<CR>",
				{ noremap = true, desc = "[T]oggle DAP UI" }
			)
			vim.keymap.set(
				"n",
				"<leader>db",
				"<cmd>DapToggleBreakpoint<CR>",
				{ noremap = true, desc = "[T]oggle DAP breakpoint" }
			)
			vim.keymap.set("n", "<leader>dc", "<cmd>DapContinue<CR>", { noremap = true, desc = "DAP continue" })
			vim.keymap.set(
				"n",
				"<leader>dr",
				"<cmd>lua require('dapui').open({ reset = true })<CR>",
				{ noremap = true, desc = "[R]eset DAP UI" }
			)
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
	},
}
