return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		{ "williamboman/mason-lspconfig.nvim", opts = { auto_install = true } },
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local lspconfig = require("lspconfig")

		-- Servers with default settings
		local servers = { "svelte", "marksman", "pyright", "html" }
		for _, server in ipairs(servers) do
			lspconfig[server].setup({ capabilities = capabilities })
		end

		-- TypeScript — won't start in Deno projects (no tsconfig/package.json there)
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
			single_file_support = false,
		})

		-- Deno — won't start in Node projects (no deno.json there)
		lspconfig.denols.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
			single_file_support = false,
		})

		-- Lua — Neovim-aware
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						checkThirdParty = false,
						library = { vim.env.VIMRUNTIME },
					},
				},
			},
		})

		-- Only add keymaps that Neovim 0.11 doesn't provide by default
		-- Built-in defaults: K=hover, grn=rename, gra=code action, grr=references,
		--   gri=implementation, gO=document symbols, [d/]d=diagnostics, CTRL-S=sig help
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(ev)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
				end
				map("gd", vim.lsp.buf.definition, "Go to definition")
				map("gD", vim.lsp.buf.declaration, "Go to declaration")
				map("gt", vim.lsp.buf.type_definition, "Go to type definition")
				map("<leader>dl", "<cmd>Telescope diagnostics<cr>", "Diagnostics list")
			end,
		})
	end,
}
