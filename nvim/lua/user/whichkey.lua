 return { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

function M.config()
  local mappings = {
    ["q"] = { "<cmd>confirm q<CR>", "Quit" },
    ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
    -- ["/"] = { "gc", "Comment" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["e"] = { "<cmd>NvimTreeFocus<CR>", "Explorer" },
    ["E"] = { "<cmd>NvimTreeClose<CR>", "Explorer" },
    ["s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "replace word"},
    ["S"] = { "<cmd> SessionSave<CR>" , "Save current session"},
    ["x"] = { "<cmd>!chmod +x %<CR>","make current file executable"},
    -- ["H"] = { "<cmd>lua require('user.extras.harpoon').mark_file()<cr>", "Harpoon"},
    -- ["<leader>"] = {function() vim.cmd("luafile ~/.config/nvim/init.lua") end, "reload lua file"},
    b = {
      name = "Buffers",
      b = { "<cmd>lua require('fzf-lua').buffers()<cr>", "Find" },
    },
    F = {"<cmd>FzfLua<cr>","FzfLua"},
    f = {
      name = "Find",
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      f = { "<cmd>lua require('fzf-lua').files()<cr>", "Find files (cwd)" },
      F = { "<cmd>lua require('fzf-lua').files({cwd = '%:p:h'})<cr>", "Find files (cbd)" },
      s = { "<cmd>lua require('fzf-lua').grep()<cr>", "Grep (cbd)" },
      S = { "<cmd>lua require('fzf-lua').grep_curbuf()({cwd = %:p:h})<cr>", "Grep (cb)" },
      -- s ={
      --   a = { "<cmd>call FuzzyRipAllCurrBuff()<cr>", "Find String (all open buffers)" },
      --   s = { "<cmd>call FuzzyRipCurrBuff()<cr>", "Find String (cb)" },
      --   S = { "<cmd>call FuzzyRipCurrBuffDir()<cr>", "Find String (cbd)" },
      --   w = { "<cmd>call FuzzyRipCurrWorkDir()<cr>", "Find string (cwd)" },
      -- },
      -- h = { "<cmd>Telescope help_tags<cr>", "Help" },
      -- H = { "<cmd>Telescope highlights<cr>", "Highlights" },
      -- M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      -- r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
      -- R = { "<cmd>Telescope registers<cr>", "Registers" },
      -- k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      -- C = { "<cmd>Telescope commands<cr>", "Commands" },
      -- u = { "<cmd>Telescope undo<cr>", "Undo Tree" },
      -- p = { "<cmd>Telescope persisted<cr>", "Sessions" },
    },
    g = {
      name = "Git",
      g = { "<cmd>Neogit<cr>", "Neogit" },
      j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      -- o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      -- c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      -- C = {
      --   "<cmd>Telescope git_bcommits<cr>",
      --   "Checkout commit(for current file)",
      -- },
      d = {
        "<cmd>Gitsigns diffthis HEAD<cr>",
        "Git Diff",
      },
    },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>lua require('fzf-lua').diagnostics_document()<cr>", "Buffer Diagnostics" },
      -- w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      f = { "<cmd>lua vim.lsp.buf.format({timeout_ms = 1000000})<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      I = { "<cmd>Mason<cr>", "Mason Info" },
      j = {
        "<cmd>lua vim.diagnostic.goto_next()<cr>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        "Prev Diagnostic",
      },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
      e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
    },

    t = {
      name = "Tab",
      t = {
        "<cmd>lua require('telescope').extensions['telescope-tabs'].list_tabs(require('telescope.themes').get_dropdown{previewer = false, initial_mode='normal', prompt_title='Tabs'})<cr>",
        "Find Tab",
      },
      a = { "<cmd>$tabnew<cr>", "New Empty Tab" },
      A = { "<cmd>tabnew %<cr>", "New Tab" },
      n = { "<cmd>tabn<cr>", "Next" },
      o = { "<cmd>tabonly<cr>", "Only" },
      p = { "<cmd>tabp<cr>", "Prev" },
      h = { "<cmd>-tabmove<cr>", "Move Left" },
      l = { "<cmd>+tabmove<cr>", "Move Right" },
    },

    T = {
      name = "Treesitter",
      i = { ":TSConfigInfo<cr>", "Info" },
    },
  }

  local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
    timeoutlen=50
  }

  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  local vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    },
  }

  local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  local which_key = require "which-key"

  which_key.setup {
    plugins = {
      marks = false, -- shows a list of your marks on ' and `
      registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true,
        suggestions = 30,
      }, -- use which-key for spelling hints
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false, -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = false, -- default bindings on <c-w>
        nav = false, -- misc bindings to work with windows
        z = false, -- bindings for folds, spelling and others prefixed with z
        g = false, -- bindings for prefixed with g
      },
    },
    layout = {
      height = { min = 5, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    show_help = true, -- show help message on the command line when the popup is visible
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  which_key.register(mappings, opts)
  which_key.register(vmappings, vopts)
end

return M
