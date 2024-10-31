local M = {
  'chipsenkbeil/distant.nvim',
  branch = 'v0.3',
}

function M.config()
  require('distant'):setup()
end

return M
