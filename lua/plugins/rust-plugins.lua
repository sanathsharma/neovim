return {
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			local bufnr = vim.api.nvim_get_current_buf()
			vim.keymap.set("n", "<leader>ca", function()
				vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
				-- or vim.lsp.buf.codeAction() if you don't want grouping.
			end, { silent = true, buffer = bufnr })

			-- snippets based on lsp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.g.rustaceanvim = {
				server = {
					capabilities,
				},
			}
		end,
	},
	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			require("cmp").setup.buffer({
				sources = { { name = "crates" } },
			})
			crates.show()
			require("core.utils").load_mappings("crates")

			-- keymapings
			vim.keymap.set("n", "<leader>rsu", function()
				require("crates").upgrade_all_crates()
			end, {})
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
}
