-- return {
-- 	"nyoom-engineering/oxocarbon.nvim",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other start plugins
-- 	config = function()
-- 		vim.opt.background = "dark"
-- 		vim.cmd.colorscheme("oxocarbon")
-- 	end,
-- }

return {
	"ellisonleao/gruvbox.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		require("gruvbox").setup({
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true,
			contrast = "hard", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		})
		vim.cmd.colorscheme("gruvbox")
	end,
}

-- return {
-- 	"bluz71/vim-moonfly-colors",
-- 	name = "moonfly",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.moonflyTransparent = true
-- 		vim.cmd.colorscheme("moonfly")
-- 	end,
-- }
