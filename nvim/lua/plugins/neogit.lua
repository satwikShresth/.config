local M = {
	"neogitorg/neogit",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		"ibhagwan/fzf-lua", -- optional
		"echasnovski/mini.pick", -- optional
		"folke/snacks.nvim", -- optional
	},
}

function M.config()
	local icons = require("assets.icons")

	local neogit = require("neogit")
	neogit.setup({
		disable_signs = false,
		-- disable_hint = true,
		disable_context_highlighting = false,
		disable_commit_confirmation = true,
		disable_insert_on_commit = "auto",
		auto_refresh = true,
		disable_builtin_notifications = false,
		use_magit_keybindings = false,
		kind = "tab",
		commit_popup = { kind = "split" },
		popup = { kind = "split" },
		signs = {
			section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
			item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
			hunk = { "", "" },
		},
		integrations = { diffview = true },
	})
	vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Open Neogit" })
end

return M
