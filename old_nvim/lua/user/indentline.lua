local M = {
  "lukas-reineke/indent-blankline.nvim", main = "ibl"
}

function M.config()
  local icons = require "user.icons"

  require("ibl").setup({
    exclude = {
      buftypes = { "terminal", "nofile" },
      filetypes= {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
      },
    },
    scope={
      enabled = true,
      show_start = false,
      show_end = false,
      char = icons.ui.LineMiddle,
    },
  })

  -- indent = { char = icons.ui.LineMiddle },
  -- whitespace = {
  --   remove_blankline_trail = true,
  -- },
  --
  -- exclude = {
  --   filetypes = {
  --     "help",
  --     "startify",
  --     "dashboard",
  --     "lazy",
  --     "neogitstatus",
  --     "NvimTree",
  --     "Trouble",
  --     "text",
  --   },
  --   buftypes = { "terminal", "nofile" },
  -- },
  -- scope = { enabled = false },
end

return M
