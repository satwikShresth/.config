-- local M = {
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPre", "BufNewFile" },
--   -- dependencies = {
--   --   {
--   --     -- "folke/neodev.nvim",
--   --   },
--   -- },
-- }
--
-- local function lsp_keymaps(bufnr)
--   local opts = { noremap = true, silent = true }
--   local keymap = vim.api.nvim_buf_set_keymap
--   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- end
--
-- M.on_attach = function(client, bufnr)
--   lsp_keymaps(bufnr)
-- end
--
-- function M.common_capabilities()
--   local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
--   if status_ok then
--     return cmp_nvim_lsp.default_capabilities()
--   end
--
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities.textDocument.completion.completionItem.snippetSupport = true
--   capabilities.textDocument.completion.completionItem.resolveSupport = {
--     properties = {
--       "documentation",
--       "detail",
--       "additionalTextEdits",
--     },
--   }
--
--   return capabilities
-- end
--
-- function M.config()
--   local lspconfig = require "lspconfig"
--   local icons = require "user.icons"
--
--   local servers ={ "lua_ls","ruff", "ruff_lsp", "typst_lsp", "marksman", "gopls", "pylsp", "clangd", "rust_analyzer", "tsls", "html", "volar", "grammarly", "r_language_server","ast_grep", "bashls", "marksman" }
--
--   local default_diagnostic_config = {
--     signs = {
--       active = true,
--       values = {
--         { name = "DiagnosticSignError", text = icons.diagnostics.Error },
--         { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
--         { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
--         { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
--       },
--     },
--     virtual_text = false,
--     update_in_insert = false,
--     underline = true,
--     severity_sort = true,
--     float = {
--       focusable = true,
--       style = "minimal",
--       border = "rounded",
--       source = "always",
--       header = "",
--       prefix = "",
--     },
--   }
--
--   vim.diagnostic.config(default_diagnostic_config)
--
--   for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
--     vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
--   end
--
--   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
--   vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
--   require("lspconfig.ui.windows").default_options.border = "rounded"
--
--   for _, server in pairs(servers) do
--     local opts = {
--       on_attach = M.on_attach,
--       capabilities = M.common_capabilities(),
--     }
--
--     local require_ok, settings = pcall(require, "user.lspsettings." .. server)
--     if require_ok then
--       opts = vim.tbl_deep_extend("force", settings, opts)
--     end
--
--     -- if server == "lua_ls" then
--     --   require("neodev").setup {}
--     -- end
--
--     lspconfig[server].setup(opts)
--   end
-- end
--
--
--
--
-- local M = {
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPre", "BufNewFile" },
--   -- dependencies = {
--   --   {
--   --     -- "folke/neodev.nvim",
--   --   },
--   -- },
-- }

return {
   {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v4.x',
      lazy = true,
      config = false,
   },
   {
      'williamboman/mason.nvim',
      lazy = false,
      config = true,
   },

   -- LSP
   {
      'neovim/nvim-lspconfig',
      cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
         { 'hrsh7th/cmp-nvim-lsp' },
         { 'williamboman/mason.nvim' },
         { 'williamboman/mason-lspconfig.nvim' },
      },
      config = function()
         local lsp_zero = require('lsp-zero')

         -- lsp_attach is where you enable features that only work
         -- if there is a language server active in the file
         local lsp_attach = function(client, bufnr)
            local opts = { buffer = bufnr }

            vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
            vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
            vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
            vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
            vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
            vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
            vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
            vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
         end

         lsp_zero.extend_lspconfig({
            sign_text = true,
            lsp_attach = lsp_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities()
         })

         require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {
               function(server_name)
                  require('lspconfig')[server_name].setup({})
               end,
            }
         })
      end
   }
}
