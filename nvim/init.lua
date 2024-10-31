require 'user.options'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.keymap.set('v', 'p', [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

vim.diagnostic.config {
  virtual_text = false, -- Disable inline diagnostic messages
  signs = True, -- Disable signs in the gutter
  underline = false, -- Disable underlining for errors
  update_in_insert = false, -- Disable diagnostics update in insert mode
}

LAZY_PLUGIN_SPEC = require 'kickstart.common'

function spec(item)
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

spec 'user.nvimtree'
spec 'kickstart.lsp'
spec 'kickstart.autoformat'
spec 'kickstart.autocomplete'
spec 'user.cmp'
spec 'user.fzf_lua'
spec 'user.lualine'
spec 'user.nvimtree'
spec 'user.markview'
spec 'user.colorizer'
spec 'user.colorscheme'
spec 'kickstart.plugins.autopairs'
spec 'user.nvimtree'
-- spec 'user.indentline'
spec 'user.neogit'
spec 'user.todo'
spec 'user.web-devicons'
spec 'user.hlchunk'
-- spec 'user.gitsigns'

require 'kickstart.lazy'

local wk = require 'which-key'

wk.add {
  { '<leader>q', '<cmd>confirm q<CR>', desc = 'Quit', mode = { 'n', 'v' } },
  { '<leader>e', '<cmd>NvimTreeOpen<CR>', desc = 'Nvim Tree', mode = 'n' },
  { '<leader>E', '<cmd>NvimTreeClose<CR>', desc = 'Nvim Tree', mode = 'n' },
  { '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = 'Replace word', mode = 'n' },
  { '<leader>x', '<cmd>!chmod +x %<CR>', desc = 'make current buffer executable', mode = 'n' },
  { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit', mode = 'n' },
  { '<leader>gP', '<cmd>Neogit push<CR>', desc = 'Neogit Push', mode = 'n' },
  { '<leader>gp', '<cmd>Neogit pull<CR>', desc = 'Neogit Pull', mode = 'n' },
  { '<leader>gc', '<cmd>Neogit commit<CR>', desc = 'Neogit commit', mode = 'n' },
  { '<leader>li', '<cmd>LspInfo<CR>', desc = 'Lsp Info', mode = 'n' },
  { '<leader>lI', '<cmd>Mason<CR>', desc = 'Mason', mode = 'n' },
  { '<leader>ti', '<cmd>TSConfigInfo<CR>', desc = 'TS info', mode = 'n' },
}
