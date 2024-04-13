return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local util = require("lspconfig/util")

			-- tsserver setup
			local function organize_imports()
				local params = {
					command = "_typescript.organizeImports",
					arguments = { vim.api.nvim_buf_get_name(0) },
				}
				vim.lsp.buf.execute_command(params)
			end

			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { verison = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = { vim.env.VIMRUNTIME },
							},
							completion = {
								enable = true,
								callSnippet = "Replace",
							},
							telemetry = { enable = false },
							hint = {
								enable = true,
								arrayIndex = "Disable",
							},
						},
					},
				},
				tsserver = {
					init_options = {
						preferences = {
							disableSuggestions = false,
							-- region: inlay hints preferences
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
							importModuleSpecifierPreference = "non-relative",
							-- endregion: inlay hints preferences
						},
					},
					commands = {
						OrganizeImports = {
							organize_imports,
							description = "Organize Imports",
						},
					},
				},
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = util.root_pattern("go.work", "go.mod", ".git"),
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
							},
						},
					},
				},
			}

			-- setup mason
			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"biome",
				"rust_analyzer",
			})

			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local function opts(desc)
						return { buffer = ev.buf, desc = "LSP: " .. desc }
					end

					local tsBuiltin = require("telescope.builtin")

					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to [d]eclaration"))
					vim.keymap.set("n", "gd", tsBuiltin.lsp_definitions, opts("Go to [d]efination"))
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Show hover documentation"))
					vim.keymap.set("n", "gi", tsBuiltin.lsp_implementations, opts("Go to [i]mplementation"))
					vim.keymap.set("n", "gr", tsBuiltin.lsp_references, opts("Go to [r]eferences"))

					vim.keymap.set({ "n", "v" }, "<leader>ac", vim.lsp.buf.code_action, opts("Show [C]ode actions"))
					vim.keymap.set("n", "<leader>D", tsBuiltin.lsp_type_definitions, opts("Type [D]efinition"))
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("[R]e[n]ame"))
					vim.keymap.set("n", "<leader>fs", tsBuiltin.lsp_document_symbols, opts("find document [S]ymbols"))
					vim.keymap.set(
						"n",
						"<leader>fr",
						tsBuiltin.lsp_dynamic_workspace_symbols,
						opts("find dynamic workspace symbols")
					)
				end,
			})

			-- auto run OrganizeImports for js/ts files when file is saved
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				command = "OrganizeImports",
				pattern = { "*.js", "*.jsx", "*.cjs", "*.ts", "*.tsx" },
			})

			-- toggle lsp inlay_hints keymap if lsp supports it, otherwise this shall throw error
			vim.keymap.set("n", "<leader>th", function()
				if vim.lsp.inlay_hint == nil then
					print("Error: inlay hints not supported by LSP")
					return
				end

				local current_buffer = vim.api.nvim_get_current_buf()
				-- toggle inlay hints
				vim.lsp.inlay_hint.enable(current_buffer, not vim.lsp.inlay_hint.is_enabled())
			end, { desc = "Toggle inlay [h]ints" })

			-- enable inlayhints by default if lsp supports it
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttach_inlayhints", { clear = true }),
				callback = function(event)
					if vim.lsp.inlay_hint ~= nil then
						vim.lsp.inlay_hint.enable(event.buf, true)
					end
				end,
			})
		end,
	},
}
