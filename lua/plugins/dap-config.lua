local js_based_languages = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
	"vue",
}

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
			{
				"microsoft/vscode-js-debug",
				-- After install, build it and rename the dist directory to out
				build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
				version = "*",
			},
			{
				"mxsdev/nvim-dap-vscode-js",
				config = function()
					require("dap-vscode-js").setup({
						-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
						debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
						adapters = { "pwa-node" }, -- which adapters to register in nvim-dap
					})
				end,
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			require("dap-go").setup()
			dapui.setup()

			dap.adapters["chrome"] = {
				type = "executable",
				command = "chrome-debug-adapter",
				args = { "--remote-debugging-port=9222" },
			}

			for _, language in ipairs(js_based_languages) do
				dap.configurations[language] = {
					-- Debug single nodejs files
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
					},
					-- Debug nodejs processes (make sure to add --inspect when you run the process)
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						-- processId = require("dap.utils").pick_process,
						cwd = vim.fn.getcwd(),
						protocol = "inspector",
						sourceMaps = true,
					},
					-- Debug web applications (client side)
					{
						type = "chrome",
						request = "launch",
						name = "Launch & Debug Chrome",
						url = function()
							local co = coroutine.running()
							return coroutine.create(function()
								vim.ui.input({
									prompt = "Enter URL: ",
									default = "http://localhost:3000",
								}, function(url)
									if url == nil or url == "" then
										return
									else
										coroutine.resume(co, url)
									end
								end)
							end)
						end,
						webRoot = vim.fn.getcwd(),
						protocol = "inspector",
						sourceMaps = true,
						userDataDir = false,
					},
					{
						type = "chrome",
						request = "attach",
						name = "Attach to chrome",
						program = "${file}",
						processId = require("dap.utils").pick_process,
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						webRoot = "${workspaceFolder}",
					},

					-- Divider for the launch.json derived configs
					{
						name = "----- ↓ launch.json configs ↓ -----",
						type = "",
						request = "launch",
					},
				}
			end

			-- event listeners
			dap.listeners.before.attach.dapui_config = function()
				dapui.open({ reset = true })
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open({ reset = true })
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

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
