return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"j-hui/fidget.nvim",
			opts = {
				integration = { ["nvim-tree"] = { enable = true } },
				notification = {
					window = { winblend = 0 },
				},
			},
		},
		"saghen/blink.cmp",
	},
	config = function()
		-- LSP ATTACH
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Basic LSP mappings
				map("K", vim.lsp.buf.hover, "Hover")
				map("gl", vim.diagnostic.open_float, "Float")
				map("gr", vim.lsp.buf.references, "References")
				map("gi", vim.lsp.buf.implementation, "Implementation")
				map("gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				-- Safe fzf-lua mappings with fallback
				local fzf_ok, fzf_lua = pcall(require, "fzf-lua")
				if fzf_ok and fzf_lua.lsp_document_symbols then
					map("gO", fzf_lua.lsp_document_symbols, "Open Document Symbols")
				else
					map("gO", vim.lsp.buf.document_symbol, "Open Document Symbols")
				end

				if fzf_ok and fzf_lua.lsp_dynamic_workspace_symbols then
					map("gW", fzf_lua.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
				else
					map("gW", vim.lsp.buf.workspace_symbol, "Open Workspace Symbols")
				end

				if fzf_ok and fzf_lua.lsp_type_definitions then
					map("grt", fzf_lua.lsp_type_definitions, "[G]oto [T]ype Definition")
				else
					map("grt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
				end

				---@param client vim.lsp.Client
				---@param method vim.lsp.protocol.Method
				---@param bufnr? integer some lsp support methods only in specific files
				---@return boolean
				local function client_supports_method(client, method, bufnr)
					if vim.fn.has("nvim-0.11") == 1 then
						return client:supports_method(method, bufnr)
					else
						return client.supports_method(method, { bufnr = bufnr })
					end
				end

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if
					client
					and client_supports_method(
						client,
						vim.lsp.protocol.Methods.textDocument_documentHighlight,
						event.buf
					)
				then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if
					client
					and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
				then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})

		-- Diagnostic Config
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			} or {},
			virtual_text = false,
		})

		local lspconfig = require("lspconfig")
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Language Server Configurations

		-- Lua Language Server
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = { vim.env.VIMRUNTIME },
					},
					diagnostics = { globals = { "vim" } },
					telemetry = { enable = false },
				},
			},
		})

		-- Python Language Server
		lspconfig.pylsp.setup({
			capabilities = capabilities,
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = { maxLineLength = 88 },
						black = { enabled = true },
						isort = { enabled = true },
					},
				},
			},
		})

		-- Deno Language Server
		lspconfig.denols.setup(require("lsp.denols"))

		-- TypeScript Language Server
		lspconfig.ts_ls.setup(require("lsp.ts_ls"))
	end,
}
