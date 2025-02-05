local M = {
  -- "lunarvim/darkplus.nvim",
  -- "rebelot/kanagawa.nvim",
  'ellisonleao/gruvbox.nvim',
  -- "luisiacc/gruvbox-baby",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  branch = 'main',
}

function M.config()
  -- vim.cmd.colorscheme "darkplus"
  -- vim.cmd.colorscheme "kanagawa-dragon"
  -- vim.g.gruvbox_baby_highlights = {Normal = {fg = "NONE", bg = "NONE", style="NONE"}}
  -- vim.cmd.colorscheme "gruvbox-baby"
  require('gruvbox').setup {
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
    contrast = 'hard',
    transparent_mode = true,
  }
  vim.cmd 'colorscheme gruvbox'
  -- require 'kickstart.plugins.gruvbox'()
  -- vim.cmd.colorscheme "gruvbox-baby"
end

return M
