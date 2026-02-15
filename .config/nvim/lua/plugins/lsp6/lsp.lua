return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			--local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

			local lspconfig = require("lspconfig")
      
      local is_in_deno_repo = lspconfig.util.root_pattern('deno.json', 'import_map.json', 'deno.jsonc')(vim.fn.getcwd())
      local is_in_deno_part_of_repo = vim.fn.match(vim.fn.expand '%:p', 'supabase/functions') > -1

      if is_in_deno_repo or is_in_deno_part_of_repo then
        if client.name == 'ts_ls' then
          client.stop()
          return
        end
      end

    
    lspconfig.svelte.setup({
                capabilities = capabilities
            })


      lspconfig.marksman.setup({
        capabilities = capabilities
      })

      lspconfig.pyright.setup({
        capabilities = capabilities
      })

		lspconfig.ts_ls.setup({
				capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
        filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        single_file_support = false,
        on_attach = function(client, bufnr)
            -- Disable formatting from tsserver
            client.server_capabilities.document_formatting = false
        end,
   --      commands = {
   --          OrganizeImports = {
   --              organize_imports,
   --                  description = "Organize Imports",
   --          },
   --      },
			})

      lspconfig.denols.setup({
        capabilities = capabilities,
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
          on_attach = function(client, bufnr)
            vim.cmd "LspStop ts_ls"
          end,
     })

			lspconfig.html.setup({
				capabilities = capabilities,
			})

			-- lspconfig.tailwindcss.setup({
			-- 	capabilities = capabilities,
			-- })

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						telemetry = {
							enable = false,
						},
						hint = {
							enable = true,
						},
					},
				},
			})

			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, {})
			vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

			-- Errors
			vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, {})
			vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {})
			vim.keymap.set("n", "g]", vim.diagnostic.goto_next, {})
			vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, {})
		end,
	},
}
