local M = {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons", "junegunn/fzf", build = "./install --bin" },
}

function M.config()
	local fzfLua = require("fzf-lua")
	fzfLua.setup({
		"fzf-tmux",
		fzf_opts = { ["--border"] = "rounded" },
		fzf_tmux_opts = { ["-p"] = "90%,85%" },
		winopts = { preview = { default = "bat" } },
	})

	vim.keymap.set("n", "<leader>fh", fzfLua.helptags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>ff", fzfLua.files, { desc = "[S]earch [F]iles" })
	vim.keymap.set("n", "<leader>fF", function()
		fzfLua.files({ cwd = "%:p:h" })
	end, { desc = "[S]earch [F]iles (cbd)" })
	vim.keymap.set("n", "<leader>/", fzfLua.grep_curbuf, { desc = "[/] Fuzzily search in current buffer" })
	vim.keymap.set("n", "<leader>fa", fzfLua.args, { desc = "[S]earch [A]rgs" })
	vim.keymap.set("n", "<leader>fs", fzfLua.builtin, { desc = "[S]earch [S]elect" })

	vim.keymap.set("v", "<leader>f", fzfLua.grep_visual, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>fw", fzfLua.grep_cword, { desc = "[S]earch current [W]ord" })
	vim.keymap.set("n", "<leader>fg", fzfLua.live_grep, { desc = "[S]earch by [G]rep" })
	vim.keymap.set("n", "<leader>fd", fzfLua.lsp_document_diagnostics, { desc = "[S]earch [D]iagnostics" })
	vim.keymap.set("n", "<leader>fr", fzfLua.resume, { desc = "[S]earch [R]esume" })
	vim.keymap.set("n", "<leader>f.", fzfLua.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
	vim.keymap.set("n", "<leader><leader>", fzfLua.buffers, { desc = "[ ] Find existing buffers" })

	vim.keymap.set("n", "<leader>fh", fzfLua.help_tags, { desc = "[S]earch [H]elp" })
	vim.keymap.set("n", "<leader>fk", fzfLua.keymaps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>fj", fzfLua.jumps, { desc = "[S]earch [K]eymaps" })
	vim.keymap.set("n", "<leader>fF", function()
		fzfLua.files({ cwd = "~/obsidian/" })
	end, { desc = "[S]earch [F]iles (obsidian)" })

	-- git
	vim.keymap.set("n", "<leader>gs", fzfLua.git_status, { desc = "Search Git Status" })
	vim.keymap.set("n", "<leader>gb", fzfLua.git_branches, { desc = "Search Git Branches" })
	vim.keymap.set("n", "<leader>gc", fzfLua.git_commits, { desc = "Search Git Commits" })
	vim.keymap.set("n", "<leader>gt", fzfLua.git_stash, { desc = "Search Git statsh" })

	vim.keymap.set("n", "<leader>f/", function()
		fzfLua.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
	end, { desc = "[S]earch [/] in Open Files" })

	vim.keymap.set("n", "<leader>fn", function()
		fzfLua.files({ cwd = vim.fn.stdpath("config") })
	end, { desc = "[S]earch [N]eovim files" })
end

return M
