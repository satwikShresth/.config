local M = {
  "mbbill/undotree",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
}

function M.config()
  vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle)
end

return M
