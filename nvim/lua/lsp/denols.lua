return {
	root_dir = require("lspconfig").util.root_pattern({ "deno.json", "deno.jsonc" }),
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
	root_markers = { "deno.json", "deno.jsonc", "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}
