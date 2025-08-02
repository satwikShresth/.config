-- return {
-- 	"nvim-tree/nvim-tree.lua",
-- 	event = "VeryLazy",
-- 	config = function()
-- 		local function my_on_attach(bufnr)
-- 			local api = require("nvim-tree.api")
--
-- 			local function opts(desc)
-- 				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
-- 			end
--
-- 			api.config.mappings.default_on_attach(bufnr)
--
-- 			vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
-- 			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
-- 			vim.keymap.del("n", "<C-k>", { buffer = bufnr })
-- 			vim.keymap.set("n", "<S-k>", api.node.open.preview, opts("Open Preview"))
-- 			vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
-- 			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
-- 		end
--
-- 		local icons = require("assets.icons")
--
-- 		local ntree = require("nvim-tree")
-- 		ntree.setup({
-- 			on_attach = my_on_attach,
-- 			sync_root_with_cwd = true,
-- 			renderer = {
-- 				add_trailing = false,
-- 				group_empty = false,
-- 				highlight_git = false,
-- 				full_name = false,
-- 				highlight_opened_files = "none",
-- 				root_folder_label = ":t",
-- 				indent_width = 2,
-- 				indent_markers = {
-- 					enable = false,
-- 					inline_arrows = true,
-- 					icons = {
-- 						corner = "└",
-- 						edge = "│",
-- 						item = "│",
-- 						none = " ",
-- 					},
-- 				},
-- 				icons = {
-- 					git_placement = "before",
-- 					padding = " ",
-- 					symlink_arrow = " ➛ ",
-- 					glyphs = {
-- 						default = icons.ui.Text,
-- 						symlink = icons.ui.FileSymlink,
-- 						bookmark = icons.ui.BookMark,
-- 						folder = {
-- 							arrow_closed = icons.ui.ChevronRight,
-- 							arrow_open = icons.ui.ChevronShortDown,
-- 							default = icons.ui.Folder,
-- 							open = icons.ui.FolderOpen,
-- 							empty = icons.ui.EmptyFolder,
-- 							empty_open = icons.ui.EmptyFolderOpen,
-- 							symlink = icons.ui.FolderSymlink,
-- 							symlink_open = icons.ui.FolderOpen,
-- 						},
-- 						git = {
-- 							unstaged = icons.git.FileUnstaged,
-- 							staged = icons.git.FileStaged,
-- 							unmerged = icons.git.FileUnmerged,
-- 							renamed = icons.git.FileRenamed,
-- 							untracked = icons.git.FileUntracked,
-- 							deleted = icons.git.FileDeleted,
-- 							ignored = icons.git.FileIgnored,
-- 						},
-- 					},
-- 				},
-- 				special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
-- 				symlink_destination = true,
-- 			},
-- 			update_focused_file = {
-- 				enable = true,
-- 				debounce_delay = 15,
-- 				update_root = true,
-- 				ignore_list = {},
-- 			},
--
-- 			diagnostics = {
-- 				enable = true,
-- 				show_on_dirs = false,
-- 				show_on_open_dirs = true,
-- 				debounce_delay = 50,
-- 				severity = {
-- 					min = vim.diagnostic.severity.HINT,
-- 					max = vim.diagnostic.severity.ERROR,
-- 				},
-- 				icons = {
-- 					hint = icons.diagnostics.BoldHint,
-- 					info = icons.diagnostics.BoldInformation,
-- 					warning = icons.diagnostics.BoldWarning,
-- 					error = icons.diagnostics.BoldError,
-- 				},
-- 			},
-- 		})
-- 		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvim Tree focus" })
-- 		vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeClose<CR>", { desc = "Nvim Tree focus" })
-- 	end,
-- }

return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
	cmd = "Neotree",
	keys = {
		{ "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
		{ "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
		{
			"<leader>ge",
			function()
				require("neo-tree.command").execute({ source = "git_status", toggle = true })
			end,
			desc = "Git Explorer",
		},
		{
			"<leader>be",
			function()
				require("neo-tree.command").execute({ source = "buffers", toggle = true })
			end,
			desc = "Buffer Explorer",
		},
	},
	deactivate = function()
		vim.cmd([[Neotree close]])
	end,
	init = function()
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
			desc = "Start Neo-tree with directory",
			once = true,
			callback = function()
				if package.loaded["neo-tree"] then
					return
				else
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then
						require("neo-tree")
					end
				end
			end,
		})
	end,
	opts = {
		sources = { "filesystem", "buffers", "git_status" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		filesystem = {
			window = {
				mappings = {
					[","] = "navigate_up",
					["."] = "set_root",
				},
			},
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
		},

		window = {
			position = "float",
			mappings = {
				["/"] = "none",
				["l"] = "open",
				["<space>"] = "none",
				["z"] = "close_node",
				["Z"] = "close_all_nodes",
				["E"] = "expand_all_nodes",
				--["Z"] = "expand_all_subnodes",
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c")
					end,
					desc = "Copy Path to Clipboard",
				},
				["O"] = {
					function(state)
						require("lazy.util").open(state.tree:get_node().path, { system = true })
					end,
					desc = "Open with System Application",
				},
				["P"] = { "toggle_preview", config = { use_float = false } },
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			git_status = {
				symbols = {
					unstaged = "󰄱",
					staged = "󰱒",
				},
			},
		},
	},
	config = function(_, opts)
		local function on_move(data)
			require("snacks").rename.on_rename_file(data.source, data.destination)
		end

		local events = require("neo-tree.events")
		opts.event_handlers = opts.event_handlers or {}
		vim.list_extend(opts.event_handlers, {
			{ event = events.FILE_MOVED, handler = on_move },
			{ event = events.FILE_RENAMED, handler = on_move },
		})
		require("neo-tree").setup(opts)
		vim.api.nvim_create_autocmd("TermClose", {
			pattern = "*lazygit",
			callback = function()
				if package.loaded["neo-tree.sources.git_status"] then
					require("neo-tree.sources.git_status").refresh()
				end
			end,
		})

		vim.keymap.set("n", "<leader>e", "<cmd>Neotree <CR>", { desc = "Nvim Tree focus" })
		vim.keymap.set("n", "<leader>E", "<cmd>Neotree dir=%:p:h<CR>", { desc = "Nvim Tree focus" })
	end,
}
