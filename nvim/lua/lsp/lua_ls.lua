local blink = require("blink.cmp")
return {
	cmd = {
		"lua-language-server",
	},
	filetypes = {
		"lua",
	},
	root_markers = {
		".git",
		".luacheckrc",
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"selene.toml",
		"selene.yml",
		"stylua.toml",
	},
	-- settings = {
	--     Lua = {
	--         diagnostics = {
	--             --     disable = { "missing-parameters", "missing-fields" },
	--         },
	--     },
	-- },

	single_file_support = true,
	log_level = vim.lsp.protocol.MessageType.Warning,
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
