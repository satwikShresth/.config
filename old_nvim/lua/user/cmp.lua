local settings = {
  theme = 'neofusion', -- ayu|gruvbox|neofusion
  indentChar = '│', -- │, |, ¦, ┆, ┊
  separatorChar = '-', -- ─, -, .
  aspect = 'clean', -- normal|clean
  lualine_separator = 'rect', -- rect|triangle|semitriangle|curve
  cmp_style = 'nvchad', -- default|nvchad
  cmp_icons_style = 'vscode', -- devicons|vscode
  transparent_mode = true,
}
local opt = vim.opt -- vim options

opt.completeopt = 'menu,menuone,noselect'

-- vscode like icons
local cmp_kinds = {
  Text = '',
  Method = '',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = '',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '',
  TypeParameter = '',
}

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'onsails/lspkind.nvim',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
    'roobert/tailwindcss-colorizer-cmp.nvim',
  },
  event = 'InsertEnter',
  config = function()
    -- load friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    -- require cmp
    local cmp = require 'cmp'

    -- require luasnip
    local luasnip = require 'luasnip'

    -- require lspkind
    local lspkind = require 'lspkind'

    -- require tailwind colorizer for cmp
    local tailwindcss_colorizer_cmp = require 'tailwindcss-colorizer-cmp'

    -- custom setup
    cmp.setup {

      window = {
        completion = {
          border = 'rounded', -- single|rounded|none
          -- custom colors
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None', -- BorderBG|FloatBorder
          col_offset = -3,
          side_padding = 1,
          scrollbar = false,
          scrolloff = 8,
        },
        documentation = {
          border = 'rounded', -- single|rounded|none
          -- custom colors
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLineBG,Search:None', -- BorderBG|FloatBorder
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-m>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},

        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'lazydev', group_index = 0 },
        {
          name = 'nvim_lsp',
          entry_filter = function(entry, ctx)
            local kind = require('cmp.types.lsp').CompletionItemKind[entry:get_kind()]
            if kind == 'Snippet' and ctx.prev_context.filetype == 'java' then
              return false
            end

            if ctx.prev_context.filetype == 'markdown' then
              return true
            end

            if kind == 'Text' then
              return false
            end

            return true
          end,
        },
        { name = 'luasnip' },
        { name = 'cmp_tabnine' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'calc' },
        { name = 'emoji' },
        { name = 'treesitter' },
        { name = 'crates' },
        { name = 'tmux' },
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      formatting = {
        fields = settings.cmp_style == 'nvchad' and { 'kind', 'abbr', 'menu' } or nil,
        format = function(entry, item)
          -- vscode like icons for cmp autocompletion
          local fmt = lspkind.cmp_format {
            -- with_text = false, -- hide kind beside the icon
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            before = tailwindcss_colorizer_cmp.formatter, -- prepend tailwindcss-colorizer
          }(entry, item)

          -- customize lspkind format
          local strings = vim.split(fmt.kind, '%s', { trimempty = true })

          -- strings[1] -> default icon
          -- strings[2] -> kind

          -- set different icon styles
          if settings.cmp_icons_style == 'vscode' then
            fmt.kind = ' ' .. (cmp_kinds[strings[2]] or '') -- concatenate icon based on kind
          else
            fmt.kind = ' ' .. (strings[1] or '') -- just use the default icon
          end

          -- append customized kind text
          if settings.cmp_style == 'nvchad' then
            fmt.kind = fmt.kind .. ' ' -- just an extra space at the end
            fmt.menu = strings[2] ~= nil and ('  ' .. (strings[2] or '')) or ''
          else
            -- default and others
            fmt.menu = strings[2] ~= nil and (strings[2] or '') or ''
          end

          return fmt
        end,
      },
    }

    pcall(function()
      local function on_confirm_done(...)
        require('nvim-autopairs.completion.cmp').on_confirm_done()(...)
      end
      require('cmp').event:off('confirm_done', on_confirm_done)
      require('cmp').event:on('confirm_done', on_confirm_done)
    end)
  end,
}
