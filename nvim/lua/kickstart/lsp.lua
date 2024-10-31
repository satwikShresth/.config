return {
  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gD', vim.lsp.buf.declaration, 'Declaration')
          map('gd', vim.lsp.buf.definition, 'Definition')
          map('K', vim.lsp.buf.hover, 'Hover')
          map('gi', vim.lsp.buf.implementation, 'Implementation')
          map('gr', vim.lsp.buf.references, 'References')
          map('gl', vim.diagnostic.open_float, 'Float')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local function organize_imports()
        local params = {
          command = '_typescript.organizeImports',
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
      end

      local servers = {
        ts_ls = {
          init_options = {
            preferences = {
              disableSuggestions = true,
            },
          },
          commands = {
            OrganizeImports = {
              organize_imports,
              description = 'Organize Imports',
            },
          },
        },
        denols = {
          settings = {
            deno = {
              enable = true,
              enablePaths = true,
              suggest = {
                imports = {
                  autoDiscover = true,
                  hosts = {
                    ['https://deno.land'] = true,
                  },
                },
                autoImports = true,
                completeFunctionCalls = true,
                names = true,
                paths = true,
              },
              codeLens = {
                implementations = true,
                references = true,
                referencesAllFunctions = true,
                test = true,
                testArgs = { '--allow-all', '--no-check' },
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = false },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
              },
              lint = true,
              future = true,
              testing = {
                args = { '--allow-all', '--no-check' },
              },
            },
          },
          root_dir = require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc'),
        },
        pylsp = {
          plugins = {
            jedi_completion = { enabled = true },
            jedi_hover = { enabled = true },
            jedi_references = { enabled = true },
            jedi_signature_help = { enabled = true },
            jedi_symbols = { enabled = true, all_scopes = true },
            pycodestyle = { enabled = false },
            flake8 = {
              enabled = false,
              ignore = {},
              maxLineLength = 160,
            },
            mypy = { enabled = false },
            isort = { enabled = false },
            yapf = { enabled = false },
            pylint = { enabled = false },
            pydocstyle = { enabled = false },
            mccabe = { enabled = false },
            preload = { enabled = false },
            rope_completion = { enabled = true },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              format = { enable = false },
              diagnostics = {
                globals = { 'vim', 'spec' },
              },
              runtime = {
                version = 'LuaJIT',
                special = {
                  spec = 'require',
                },
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                  [vim.fn.stdpath 'config' .. '/lua'] = true,
                },
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
