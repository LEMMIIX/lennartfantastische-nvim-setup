return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile"},
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},

		config = function()
			local cmp = require('cmp')
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities())



			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"clangd",
				},
				automatic_installation = false,
				automatic_enable = false,

				handlers = {
					function (server_name)
						--print("setting up ", server_name)		-- Kontrollprint zum Testen welche language server geladen werden

						if server_name == "clangd" then
							-- Spezielle Konfiguration für clangd mit Qt-Unterstützung
							require("lspconfig").clangd.setup({
								capabilities = capabilities,
								cmd = {
									"clangd",
									"--background-index",
									"--clang-tidy",
									"--header-insertion=iwyu",
									"--completion-style=detailed",
									"--suggest-missing-includes",
									-- Qt-spezifische Flags
									"--query-driver=K:/Qt/Tools/mingw1120_64/bin/g++.exe",
								},
								filetypes = { "c", "cpp", "objc", "objcpp", "hpp", "h", "ui" },
								root_dir = function(fname)
									return require('lspconfig').util.root_pattern('CMakeLists.txt', 'compile_commands.json', '.git')(fname) or vim.fn.getcwd()
								end,
							})
						else
        require("lspconfig")[server_name].setup {
            capabilities = capabilities,
        }
    end
					end,
				}
			})

			local cmp_select = { behavior = cmp.SelectBehavior.Select }

			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),	-- Vorschlagliste PREVIOUS
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),	-- Vorschlagliste NEXT
					['<C-y>'] = cmp.mapping.confirm({ select = true }),		-- Vorschlag AKZEPTIEREN
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
				}, {
					{ name = 'buffer' },
				})
			})

			vim.diagnostic.config({
				-- update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	}
}
