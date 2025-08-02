local blink = require("blink.cmp")
local util = require("lspconfig.util")

return {
	root_dir = util.root_pattern("deno.json", "deno.jsonc"),
	single_file_support = false,
	settings = {},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		blink.get_lsp_capabilities()
	),
}
