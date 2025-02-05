require 'kickstart.options'

LAZY_PLUGINS = {}

local function spec(item)
  table.insert(LAZY_PLUGINS, require(item))
end

spec 'kickstart.plugins.lsp'
spec 'kickstart.plugins.autopairs'
spec 'kickstart.plugins.gitsigns'
spec 'kickstart.plugins.indent_line'
spec 'kickstart.plugins.lualine'
-- spec 'kickstart.plugins.lint'
spec 'kickstart.plugins.nvimtree'
spec 'kickstart.plugins.undo'
-- spec 'kickstart.plugins.obsidian'
-- spec 'kickstart.plugins.cmp'
spec 'kickstart.plugins.blink'
spec 'kickstart.plugins.format'
spec 'kickstart.plugins.fzf_lua'
spec 'kickstart.plugins.gitgraph'
spec 'kickstart.plugins.markview'
spec 'kickstart.plugins.neogit'
spec 'kickstart.plugins.whichkey'
spec 'kickstart.plugins.kickstart'
spec 'kickstart.plugins.treesitter'
spec 'kickstart.plugins.colorscheme'
spec 'kickstart.plugins.breadcrumbs'

require 'kickstart.lazy'
-- require('obsidian').get_client()
